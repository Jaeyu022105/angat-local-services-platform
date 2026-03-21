using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;

namespace GROUP6_ANGAT.Pages {
    public partial class HanapTrabaho : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            bool isLoggedIn = Session["UserId"] != null;
            phApplyLoggedIn.Visible = isLoggedIn;
            phApplyLoggedOut.Visible = !isLoggedIn;

            if (!IsPostBack)
                LoadJobs();
        }

        protected string GetRelativeTime(object postedAt) {
            if (postedAt == null || postedAt == DBNull.Value)
                return "";

            DateTime postDate = Convert.ToDateTime(postedAt);
            DateTime localNow = DateTime.Now.AddHours(-8);
            TimeSpan ts = localNow - postDate;
            if (ts.TotalSeconds < 60)
                return "just now";
            if (ts.TotalMinutes < 60)
                return (int)ts.TotalMinutes + "m";
            if (ts.TotalHours < 24)
                return (int)ts.TotalHours + "h";
            if (ts.TotalDays < 7)
                return (int)ts.TotalDays + "d";

            // Kung higit sa isang linggo, ipakita na ang date
            return postDate.ToString("MMM dd");
        }

        private void LoadJobs() {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString)) {
                conn.Open();

                using (SqlCommand countCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Jobs WHERE IsActive = 1", conn)) {
                    lblJobCount.Text = countCmd.ExecuteScalar().ToString();
                }

                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT j.JobId, j.JobTitle, j.JobDescription, j.Category,
                           j.Barangay, j.PayMin, j.PayMax, j.PayRate, j.Tags, 
                           j.Status, j.PostedAt, j.Slots, u.FullName AS PosterName,
                           u.ProfileImagePath AS PosterImage
                    FROM Jobs j
                    LEFT JOIN Users u ON j.PostedByUserId = u.UserId
                    WHERE j.IsActive = 1
                    ORDER BY j.PostedAt DESC", conn)) {
                    using (SqlDataReader reader = cmd.ExecuteReader()) {
                        rptJobs.DataSource = reader;
                        rptJobs.DataBind();
                    }
                }
            }

            pnlEmpty.Visible = rptJobs.Items.Count == 0;
        }

        protected void BtnApplyJob_Click(object sender, EventArgs e) {
            if (Session["UserId"] == null) {
                Response.Redirect("~/Pages/Login.aspx?returnUrl=/Pages/HanapTrabaho.aspx");
                return;
            }

            if (!int.TryParse(hfJobId.Value, out int jobId)) {
                ShowMessage("error", "Piliin muna ang trabaho bago mag-apply.");
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            int ownerUserId = 0;
            string jobTitle = "";
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                using (SqlCommand ownerCmd = new SqlCommand(
                    "SELECT PostedByUserId, JobTitle FROM Jobs WHERE JobId = @JobId", conn))
                {
                    ownerCmd.Parameters.AddWithValue("@JobId", jobId);
                    using (SqlDataReader ownerReader = ownerCmd.ExecuteReader())
                    {
                        if (ownerReader.Read())
                        {
                            ownerUserId = ownerReader["PostedByUserId"] != DBNull.Value ? Convert.ToInt32(ownerReader["PostedByUserId"]) : 0;
                            jobTitle = ownerReader["JobTitle"].ToString();
                        }
                    }
                    if (ownerUserId > 0 && ownerUserId.ToString() == Session["UserId"].ToString())
                    {
                        ShowMessage("error", "Hindi ka maaaring mag-apply sa sariling listing.");
                        return;
                    }
                }



                using (SqlCommand existsCmd = new SqlCommand(@"
                    SELECT TOP 1 ApplicationId, Status
                    FROM JobApplications
                    WHERE UserId = @UserId AND JobId = @JobId
                    ORDER BY AppliedAt DESC", conn))
                {
                    existsCmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    existsCmd.Parameters.AddWithValue("@JobId", jobId);

                    using (SqlDataReader reader = existsCmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string status = reader["Status"].ToString();
                            int appId = Convert.ToInt32(reader["ApplicationId"]);
                            reader.Close();

                            if (string.Equals(status, "Retracted", StringComparison.OrdinalIgnoreCase))
                            {
                                using (SqlCommand updateCmd = new SqlCommand(@"
                                    UPDATE JobApplications
                                    SET Status = 'Pending', AppliedAt = GETDATE()
                                    WHERE ApplicationId = @AppId", conn))
                                {
                                    updateCmd.Parameters.AddWithValue("@AppId", appId);
                                    updateCmd.ExecuteNonQuery();
                                    if (ownerUserId > 0)
                                    {
                                        string applicantname = Session["UserName"] != null ? Session["UserName"].ToString() : "May User";
                                        GROUP6_ANGAT.NotificationHelper.TryCreateNotification(conn, ownerUserId, "May bagong application",
                                            string.Format("{0} applied to your job: {1}.", applicantname, jobTitle), "job_application_new",
                                            string.Format("~/Pages/Profile.aspx?tab=listings&applicationId={0}", appId));


                                    }
                                }
                                ShowMessage("success", "Na-submit ulit ang inyong application.");
                                return;
                            }

                            ShowMessage("error", "May active application ka na sa trabahong ito.");
                            return;
                        }
                    }
                }

                using (SqlCommand cmd = new SqlCommand(@"
                    INSERT INTO JobApplications (UserId, JobId, Status, AppliedAt)
                    VALUES (@UserId, @JobId, 'Pending', GETDATE());
                    SELECT CAST(SCOPE_IDENTITY() AS INT);", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    cmd.Parameters.AddWithValue("@JobId", jobId);
                    int applicationId = Convert.ToInt32(cmd.ExecuteScalar());
                    if (ownerUserId > 0)
                    {
                        string applicantName = Session["UserName"] != null ? Session["UserName"].ToString() : "May user";

                        GROUP6_ANGAT.NotificationHelper.TryCreateNotification(
                            conn,
                            ownerUserId,
                            "Bagong job application",
                            string.Format("{0} applied to your job: {1}.", applicantName, jobTitle),
                            "job_application_new",
                            string.Format("~/Pages/Profile.aspx?tab=listings&applicationId={0}", applicationId));
                    }

                }
                ShowMessage("success", "Na-submit ang inyong application! Makikita ito sa inyong Profile.");
            }
        }

        private void ShowMessage(string type, string message) {
            pnlApplyMessage.Visible = true;
            pnlApplyMessage.CssClass = $"form-alert {type}";
            lblApplyMessage.Text = message;
        }
    }
}