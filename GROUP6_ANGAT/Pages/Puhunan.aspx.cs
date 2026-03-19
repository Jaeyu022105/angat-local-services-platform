using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GROUP6_ANGAT.Pages
{
    public partial class Puhunan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPuhunanPrograms();
            }
        }

        // =============================================
        // SEARCH & FILTER LOGIC
        // =============================================
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string search = txtSearch.Text.Trim();
            string filter = ddlLoanType.SelectedValue;
            LoadPuhunanPrograms(search, filter);
        }

        private void LoadPuhunanPrograms(string searchQuery = "", string loanFilter = "All")
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Including LoanType in the SELECT so we can use it if needed
                string query = "SELECT ProgramName, TagText, CategorySlug, Description, TargetURL, LoanType FROM PuhunanPrograms WHERE 1=1";

                if (!string.IsNullOrEmpty(searchQuery))
                    query += " AND ProgramName LIKE @search";

                if (!string.IsNullOrEmpty(loanFilter) && loanFilter != "All")
                    query += " AND LoanType = @type";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@search", "%" + searchQuery + "%");
                cmd.Parameters.AddWithValue("@type", loanFilter);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                try
                {
                    conn.Open();
                    da.Fill(dt);
                    rptPuhunan.DataSource = dt;
                    rptPuhunan.DataBind();
                }
                catch (Exception) { /* Handle error or log it */ }
            }
        }

        // =============================================
        // ICONS AND STYLING HELPERS
        // =============================================
        protected string GetIconStyle(string slug)
        {
            switch (slug.ToUpper())
            {
                case "DOLE": return "color: #b45309; background: #fef3c7; width: 60px; height: 60px; font-size: 1.8rem; display: flex; align-items: center; justify-content: center; border-radius: 8px;";
                case "SSS": return "color: #be123c; background: #ffe4e6; width: 60px; height: 60px; font-size: 1.8rem; display: flex; align-items: center; justify-content: center; border-radius: 8px;";
                case "DTI": return "color: #15803d; background: #dcfce7; width: 60px; height: 60px; font-size: 1.8rem; display: flex; align-items: center; justify-content: center; border-radius: 8px;";
                case "CARD": return "color: #1d4ed8; background: #dbeafe; width: 60px; height: 60px; font-size: 1.8rem; display: flex; align-items: center; justify-content: center; border-radius: 8px;";
                default: return "color: #64748b; background: #f1f5f9; width: 60px; height: 60px; font-size: 1.8rem; display: flex; align-items: center; justify-content: center; border-radius: 8px;";
            }
        }

        protected string GetIconClass(string slug)
        {
            switch (slug.ToUpper())
            {
                case "DOLE": return "bx-briefcase-alt-2";
                case "SSS": return "bxs-id-card";
                case "DTI": return "bx-store";
                case "CARD": return "bx-group";
                default: return "bx-help-circle";
            }
        }

        protected string GetBadgeClass(string slug)
        {
            switch (slug.ToUpper())
            {
                case "DTI": return "badge-green";
                case "DOLE": return "badge-amber";
                case "SSS": return "badge-rose";
                case "CARD": return "badge-blue";
                default: return "badge-secondary";
            }
        }

        protected string GetPrimaryColor(string slug)
        {
            switch (slug.ToUpper())
            {
                case "DOLE": return "#b45309";
                case "SSS": return "#be123c";
                case "DTI": return "#15803d";
                case "CARD": return "#1d4ed8";
                default: return "#64748b";
            }
        }
    }
}