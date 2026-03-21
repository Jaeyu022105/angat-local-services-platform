using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI;

namespace GROUP6_ANGAT {
    public partial class _Default : Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (!IsPostBack) {
                LoadFeaturedJobs();
                LoadFeaturedServices();
            }
        }

        private void LoadFeaturedJobs() {
            string connStr = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr)) {
                conn.Open();
                string query = @"SELECT TOP 3 JobId, JobTitle, JobDescription, Category, 
                         Barangay, PayMin, PayMax, PayRate, Tags, Status, PostedAt
                         FROM Jobs WHERE IsActive = 1 
                         ORDER BY PostedAt DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn)) {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptFeaturedJobs.DataSource = dt;
                    rptFeaturedJobs.DataBind();
                }
            }
        }

        private void LoadFeaturedServices() {
            string connStr = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr)) {
                conn.Open();
                string query = @"SELECT TOP 3 ServiceId, ServiceTitle, Category,
                         Barangay, RateMin, RateMax, RateType, Tags, Status, PostedAt
                         FROM Services WHERE IsActive = 1
                         ORDER BY PostedAt DESC";
                using (SqlCommand cmd = new SqlCommand(query, conn)) {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    System.Diagnostics.Debug.WriteLine("Services count: " + dt.Rows.Count);
                    rptFeaturedServices.DataSource = dt;
                    rptFeaturedServices.DataBind();
                }
            }
        }
    }
}