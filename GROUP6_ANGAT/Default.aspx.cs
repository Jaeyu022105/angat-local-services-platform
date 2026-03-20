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

        protected string GetTagsHtml(object tags, object category) {
            string result = "";
            if (tags != null && !string.IsNullOrEmpty(tags.ToString())) {
                string[] tagList = tags.ToString().Split('|');
                foreach (string tag in tagList) {
                    if (!string.IsNullOrWhiteSpace(tag)) {
                        string t = tag.Trim();
                        string css = GetTagCss(t);
                        result += $"<span class='badge {css}'>{t}</span> ";
                    }
                }
            }
            return result;
        }

        protected string GetTagCss(string tag) {
            string t = (tag ?? "").ToLower();
            if (t.Contains("full-time")) return "tag-fulltime";
            if (t.Contains("part-time")) return "tag-parttime";
            if (t.Contains("urgent")) return "tag-urgent";
            if (t.Contains("pisikal")) return "tag-physical";
            if (t.Contains("may karanasan")) return "tag-experience";
            if (t.Contains("flexible")) return "tag-teal";
            if (t.Contains("live-in")) return "tag-housing";
            if (t.Contains("weekdays")) return "tag-blue";
            if (t.Contains("weekends")) return "tag-violet";
            return "tag-teal";
        }

        protected string GetPayDisplay(object minObj, object maxObj, object rateObj) {
            string rate = (rateObj ?? "").ToString()
                .Replace("per month", "buwan")
                .Replace("per day", "araw")
                .Replace("per hour", "oras")
                .Replace("per job", "bawat trabaho");

            if (minObj == DBNull.Value || minObj == null) return "";

            decimal min = Convert.ToDecimal(minObj);
            decimal max = maxObj == DBNull.Value || maxObj == null ? min : Convert.ToDecimal(maxObj);

            string formatted = min == max
                ? $"₱{min:N0}"
                : $"₱{min:N0}–₱{max:N0}";

            return $"{formatted} / {rate}";
        }

        protected string GetDateLabel(object postedObj) {
            if (postedObj == null || postedObj == DBNull.Value) return "";
            if (!DateTime.TryParse(postedObj.ToString(), out DateTime posted)) return "";

            var diff = DateTime.Now - posted;
            if (diff.TotalMinutes < 60) return "Kaninang umaga";
            if (diff.TotalHours < 24) return "Ngayon";
            if (diff.TotalDays < 2) return "Kahapon";
            if (diff.TotalDays < 7) return $"{(int)diff.TotalDays} araw na ang nakalipas";
            if (diff.TotalDays < 14) return "Isang linggo na ang nakalipas";
            return $"{(int)(diff.TotalDays / 7)} linggo na ang nakalipas";
        }
    }
}