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
                LoadAnnouncements();
            }
        }

        private void LoadAnnouncements() {
            string connStr = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr)) {
                conn.Open();
                string query = @"SELECT TOP 5 Title, Body, MonthLabel, DayLabel 
                         FROM Announcements 
                         WHERE IsActive = 1 
                         ORDER BY PostedAt DESC";
                using (SqlCommand cmd = new SqlCommand(query, conn)) {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptAnnouncements.DataSource = dt;
                    rptAnnouncements.DataBind();
                }
            }
        }

        private void LoadFeaturedJobs() {
            string connStr = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr)) {
                conn.Open();
                string query = @"SELECT TOP 3 JobId, JobTitle, JobLocation, JobPay, 
                                 JobTags, Category, Status, DateLabel, IconClass, IconBg, IconColor
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

        protected string GetTagsHtml(object tags, object category) {
            string result = "";
            if (tags != null && !string.IsNullOrEmpty(tags.ToString())) {
                string[] tagList = tags.ToString().Split('|');
                foreach (string tag in tagList) {
                    if (!string.IsNullOrWhiteSpace(tag))
                        result += $"<span class='badge badge-teal'>{tag.Trim()}</span> ";
                }
            }
            return result;
        }
    }
}