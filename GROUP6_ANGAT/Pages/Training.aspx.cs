using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GROUP6_ANGAT.Pages
{
    public partial class Training : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load all data on initial visit
                BindTrainingData();
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindTrainingData();
        }
        private void BindTrainingData(string search = "", string status = "All")
        {
            string connStr = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT Title, Agency, Description, Location, Status, ApplyURL FROM TrainingPrograms WHERE 1=1";

                if (!string.IsNullOrEmpty(search))
                {
                    sql += " AND (Title LIKE @search OR Agency LIKE @search OR Description LIKE @search)";
                }

                if (status != "All")
                {
                    sql += " AND Status = @status";
                }

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    if (!string.IsNullOrEmpty(search))
                        cmd.Parameters.AddWithValue("@search", "%" + search + "%");

                    if (status != "All")
                        cmd.Parameters.AddWithValue("@status", status);

                    // Use SqlDataAdapter to fill a DataTable
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    try
                    {
                        conn.Open();
                        da.Fill(dt); // This fills the DataTable with your search results

                        Repeater1.DataSource = dt;
                        Repeater1.DataBind();
                    }
                    catch (Exception ex)
                    {
                        // Log error or display a message if the database connection fails
                    }
                }
            }
        }
    }
}