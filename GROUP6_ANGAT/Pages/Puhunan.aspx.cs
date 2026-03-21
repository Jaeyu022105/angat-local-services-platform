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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadPuhunanPrograms();
        }

        private void LoadPuhunanPrograms()
        {
            var connSettings = ConfigurationManager.ConnectionStrings["AngatDB"];

            if (connSettings == null)
            {
                System.Diagnostics.Debug.WriteLine("Error: AngatDB connection string not found in Web.config");
                return;
            }

            string connString = connSettings.ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT ProgramName, TagText, CategorySlug, Description, TargetURL, LoanType FROM PuhunanPrograms";
                SqlCommand cmd = new SqlCommand(query, conn);
                DataTable dt = new DataTable();

                try
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);

                    if (rptPuhunan != null)
                    {
                        rptPuhunan.DataSource = dt;
                        rptPuhunan.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("Database Error: " + ex.Message);
                }
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
            if (string.IsNullOrEmpty(slug)) return "bx-help-circle";

            switch (slug.Trim().ToUpper())
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