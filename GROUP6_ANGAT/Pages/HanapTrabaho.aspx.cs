using System;
using System.Configuration;
using System.Data.SqlClient;

namespace GROUP6_ANGAT.Pages {
    public partial class HanapTrabaho : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            phApplyLoggedIn.Visible = Session["UserId"] != null;
            if (!IsPostBack) {
                LoadJobs();
                if (Request.QueryString["posted"] == "success") {
                    ShowMessage("success", "Naipost na ang trabaho! Makikita ito sa listahan.");
                }
            }
        }

        private void LoadJobs() {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString)) {
                conn.Open();
                using (SqlCommand countCmd = new SqlCommand("SELECT COUNT(*) FROM Jobs WHERE IsActive = 1", conn)) {
                    lblJobCount.Text = countCmd.ExecuteScalar().ToString();
                }
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT j.*, u.FullName AS PosterName, u.ProfileImagePath AS PosterImage 
                    FROM Jobs j LEFT JOIN Users u ON j.PostedByUserId = u.UserId 
                    WHERE j.IsActive = 1 ORDER BY j.PostedAt DESC", conn)) {
                    using (SqlDataReader reader = cmd.ExecuteReader()) {
                        rptJobs.DataSource = reader; rptJobs.DataBind();
                    }
                }
            }
        }

        // FIXED TIME LOGIC
        protected string GetRelativeTime(object p) {
            if (p == null || p == DBNull.Value) return "";
            DateTime postedAt = Convert.ToDateTime(p);
            TimeSpan ts = DateTime.Now - postedAt;

            if (ts.TotalDays >= 7) return postedAt.ToString("MMM dd");
            if (ts.TotalDays >= 1) return $"{(int)ts.TotalDays}d ago";
            if (ts.TotalHours >= 1) return $"{(int)ts.TotalHours}h ago"; // Added hours check
            if (ts.TotalMinutes >= 1) return $"{(int)ts.TotalMinutes}m ago";
            return "Just now";
        }

        protected void BtnApplyJob_Click(object sender, EventArgs e) {
            if (Session["UserId"] == null) return;
            try {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString)) {
                    conn.Open();
                    SqlCommand check = new SqlCommand("SELECT COUNT(*) FROM JobApplications WHERE UserId=@u AND JobId=@j", conn);
                    check.Parameters.AddWithValue("@u", Session["UserId"]); check.Parameters.AddWithValue("@j", hfJobId.Value);
                    if ((int)check.ExecuteScalar() > 0) { ShowMessage("error", "Mayroon ka nang active application dito."); return; }

                    SqlCommand cmd = new SqlCommand("INSERT INTO JobApplications (UserId, JobId, Status, AppliedAt) VALUES (@u, @j, 'Pending', GETDATE())", conn);
                    cmd.Parameters.AddWithValue("@u", Session["UserId"]); cmd.Parameters.AddWithValue("@j", hfJobId.Value);
                    cmd.ExecuteNonQuery();
                    ShowMessage("success", "Na-submit ang inyong application!");
                }
            }
            catch { ShowMessage("error", "Error submitting application."); }
        }

        private void ShowMessage(string t, string m) {
            pnlApplyMessage.Visible = true;
            pnlApplyMessage.CssClass = $"form-alert {t}";
            lblApplyMessage.Text = m;
        }
    }
}