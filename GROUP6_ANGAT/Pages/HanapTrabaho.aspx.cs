using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace GROUP6_ANGAT.Pages {
    public partial class HanapTrabaho : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            bool isLoggedIn = Session["UserId"] != null;
            phApplyLoggedIn.Visible = isLoggedIn;
            phApplyLoggedOut.Visible = !isLoggedIn;

            if (!IsPostBack) LoadJobs();
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

        protected string GetRelativeTime(object p) {
            if (p == null || p == DBNull.Value) return "";
            DateTime dt = Convert.ToDateTime(p);
            TimeSpan ts = DateTime.UtcNow - dt;
            if (ts.TotalDays >= 7) return dt.ToString("MMM dd");
            if (ts.TotalDays >= 1) return $"{(int)ts.TotalDays}d ago";
            if (ts.TotalHours >= 1) return $"{(int)ts.TotalHours}h ago";
            return $"{(int)ts.TotalMinutes}m ago";
        }

        protected void BtnApplyJob_Click(object sender, EventArgs e) {
            pnlModalAlert.Visible = false;

            if (Session["UserId"] == null) return;
            string jobId = hfJobId.Value;

            try {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString)) {
                    conn.Open();

                    // 1. Check if user is the Owner
                    SqlCommand ownerCheck = new SqlCommand("SELECT PostedByUserId FROM Jobs WHERE JobId = @jid", conn);
                    ownerCheck.Parameters.AddWithValue("@jid", jobId);
                    object ownerId = ownerCheck.ExecuteScalar();
                    if (ownerId != null && ownerId.ToString() == Session["UserId"].ToString()) {
                        ShowModalMessage("error", "Hindi ka maaaring mag-apply sa sariling listing.");
                        return;
                    }

                    // 2. Check if already applied
                    SqlCommand check = new SqlCommand("SELECT COUNT(*) FROM JobApplications WHERE UserId=@uid AND JobId=@jid", conn);
                    check.Parameters.AddWithValue("@uid", Session["UserId"]);
                    check.Parameters.AddWithValue("@jid", jobId);
                    if ((int)check.ExecuteScalar() > 0) {
                        ShowModalMessage("error", "Mayroon ka nang active application dito.");
                        return;
                    }

                    // 2.5 Check if job is still accepting applications
                    SqlCommand filledCheck = new SqlCommand("SELECT COUNT(*) FROM Jobs WHERE JobId=@jid AND IsActive=1 AND Status != 'Filled'", conn);
                    filledCheck.Parameters.AddWithValue("@jid", jobId);
                    if ((int)filledCheck.ExecuteScalar() == 0)
                    {
                        ShowModalMessage("error", "Puno na ang slots para sa trabahong ito.");
                        return;
                    }

                    // 3. Insert Application
                    SqlCommand cmd = new SqlCommand("INSERT INTO JobApplications (UserId, JobId, Status, AppliedAt) VALUES (@uid, @jid, 'Pending', GETDATE())", conn);
                    cmd.Parameters.AddWithValue("@uid", Session["UserId"]);
                    cmd.Parameters.AddWithValue("@jid", jobId);
                    cmd.ExecuteNonQuery();

                    ShowModalMessage("success", "Application submitted! Antayin ang tugon ng employer.");
                }
            }
            catch { ShowModalMessage("error", "Nagkaroon ng error. Subukan ulit."); }
        }

        private void ShowModalMessage(string type, string message) {
            pnlModalAlert.Visible = true;
            pnlModalAlert.CssClass = $"form-alert {type}";
            lblModalAlert.Text = message;
        }
    }
}