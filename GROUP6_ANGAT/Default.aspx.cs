using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace GROUP6_ANGAT {
    public partial class _Default : Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (!IsPostBack) {
                LoadFeaturedJobs();
                LoadFeaturedServices();
                LoadNegosyoCount();
            }
        }

        private void LoadFeaturedJobs() {
            string connStr = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr)) {
                conn.Open();

                // ── Count — same pattern as HanapTrabaho ──
                using (SqlCommand countCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Jobs WHERE IsActive = 1", conn)) {
                    lblStatJobs.Text = countCmd.ExecuteScalar().ToString();
                }

                // ── Featured cards ──
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT TOP 3 JobId, JobTitle, JobDescription, Category,
                           Barangay, PayMin, PayMax, PayRate, Tags, Status, PostedAt
                    FROM Jobs WHERE IsActive = 1
                    ORDER BY PostedAt DESC", conn)) {
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

                // ── Count — same pattern as HanapGawa ──
                using (SqlCommand countCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Services WHERE IsActive = 1", conn)) {
                    lblStatServices.Text = countCmd.ExecuteScalar().ToString();
                }

                // ── Featured cards ──
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT TOP 3 ServiceId, ServiceTitle, Category,
                           Barangay, RateMin, RateMax, RateType, Tags, Status, PostedAt
                    FROM Services WHERE IsActive = 1
                    ORDER BY PostedAt DESC", conn)) {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptFeaturedServices.DataSource = dt;
                    rptFeaturedServices.DataBind();
                }
            }
        }

        private void LoadNegosyoCount() {
            string connStr = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr)) {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM DirectoryBusinesses WHERE IsActive = 1", conn)) {
                    lblStatNegosyo.Text = cmd.ExecuteScalar().ToString();
                }
            }
        }
    }
}