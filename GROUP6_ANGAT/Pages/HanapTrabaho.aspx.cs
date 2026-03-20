using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;

namespace GROUP6_ANGAT.Pages {
    public partial class HanapTrabaho : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            bool isLoggedIn = Session["UserId"] != null;
            phApplyLoggedIn.Visible = isLoggedIn;
            phApplyLoggedOut.Visible = !isLoggedIn;

            if (!IsPostBack)
                LoadJobs();
        }

        private void LoadJobs() {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString)) {
                conn.Open();

                // Get job count
                using (SqlCommand countCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Jobs WHERE IsActive = 1", conn)) {
                    lblJobCount.Text = countCmd.ExecuteScalar().ToString();
                }

                // Get job listings
                using (SqlCommand cmd = new SqlCommand(@"
            SELECT JobId, JobTitle, JobDescription, Category, Barangay,
                   PayMin, PayMax, PayRate, Tags, Status, PostedAt
            FROM Jobs
            WHERE IsActive = 1
            ORDER BY PostedAt DESC", conn)) {
                    using (SqlDataReader reader = cmd.ExecuteReader()) {
                        rptJobs.DataSource = reader;
                        rptJobs.DataBind();
                    }
                }
            }

            // Show empty state if no jobs
            pnlEmpty.Visible = rptJobs.Items.Count == 0;
        }

        // ── Pay display ──
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

        // ── Date label (auto-calculated) ──
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

        // ── Tags HTML ──
        protected string GetTagsHtml(object tagsObj, object categoryObj) {
            string tagsRaw = (tagsObj ?? "").ToString();
            if (string.IsNullOrWhiteSpace(tagsRaw)) return "";

            string[] tags = tagsRaw.Split(new[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
            var sb = new StringBuilder();

            foreach (string tag in tags) {
                string t = tag.Trim();
                string css = GetTagCss(t);
                sb.AppendFormat("<span class=\"badge {0}\">{1}</span>", css, HttpUtility.HtmlEncode(t));
            }
            return sb.ToString();
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

        // ── Search text ──
        protected string GetSearchText(object titleObj, object tagsObj, object barangayObj, object categoryObj) {
            string title = (titleObj ?? "").ToString();
            string tags = (tagsObj ?? "").ToString().Replace("|", " ");
            string barangay = (barangayObj ?? "").ToString();
            string category = (categoryObj ?? "").ToString();
            return $"{title} {tags} {barangay} {category}".Trim();
        }

        // ── Status badge class ──
        protected string GetStatusClass(object statusObj) {
            string status = (statusObj ?? "").ToString().ToLower();
            if (status.Contains("filled")) return "badge-rose";
            if (status.Contains("paused")) return "badge-amber";
            if (status.Contains("available")) return "badge-green";
            return "badge-teal";
        }

        // ── Posted sort value ──
        protected string GetPostedValue(object postedObj) {
            if (postedObj == null || postedObj == DBNull.Value) return "0";
            if (DateTime.TryParse(postedObj.ToString(), out DateTime posted))
                return posted.ToFileTimeUtc().ToString();
            return "0";
        }

        // ── Apply button ──
        protected void BtnApplyJob_Click(object sender, EventArgs e) {
            if (Session["UserId"] == null) {
                Response.Redirect("~/Pages/Login.aspx?returnUrl=/Pages/HanapTrabaho.aspx");
                return;
            }

            if (!int.TryParse(hfJobId.Value, out int jobId)) {
                ShowMessage("error", "Piliin muna ang trabaho bago mag-apply.");
                return;
            }

            string title = (hfJobTitle.Value ?? "").Trim();
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString)) {
                conn.Open();

                int ownerUserId = 0;
                // Check if own listing
                using (SqlCommand ownerCmd = new SqlCommand(
                    "SELECT PostedByUserId FROM Jobs WHERE JobId = @JobId", conn)) {
                    ownerCmd.Parameters.AddWithValue("@JobId", jobId);
                    object ownerId = ownerCmd.ExecuteScalar();
                    if (ownerId != null && ownerId != DBNull.Value) {
                        ownerUserId = Convert.ToInt32(ownerId);
                        if (ownerUserId == Convert.ToInt32(Session["UserId"])) {
                            ShowMessage("error", "Hindi ka maaaring mag-apply sa sariling listing.");
                            return;
                        }
                    }
                }

                // Check existing application
                using (SqlCommand existsCmd = new SqlCommand(@"
                    SELECT TOP 1 ApplicationId, Status 
                    FROM JobApplications 
                    WHERE UserId = @UserId AND JobId = @JobId
                    ORDER BY AppliedAt DESC", conn)) {
                    existsCmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    existsCmd.Parameters.AddWithValue("@JobId", jobId);

                    using (SqlDataReader reader = existsCmd.ExecuteReader()) {
                        if (reader.Read()) {
                            string status = reader["Status"].ToString();
                            int appId = Convert.ToInt32(reader["ApplicationId"]);
                            reader.Close();

                            if (string.Equals(status, "Retracted", StringComparison.OrdinalIgnoreCase)) {
                                using (SqlCommand updateCmd = new SqlCommand(@"
                                    UPDATE JobApplications 
                                    SET Status = 'Pending', AppliedAt = GETDATE()
                                    WHERE ApplicationId = @AppId", conn)) {
                                    updateCmd.Parameters.AddWithValue("@AppId", appId);
                                    updateCmd.ExecuteNonQuery();

                                    //for notifs
                                    if (ownerUserId > 0) {
                                        string applicantName = Session["UserName"] == null ? "May user" : Session["UserName"].ToString();
                                        GROUP6_ANGAT.NotificationHelper.TryCreateNotification(
                                            conn,
                                            ownerUserId,
                                            "Bagong job application",
                                            string.Format("{0} applied to your job: {1}.", applicantName, title),
                                            "job_application_new",
                                            "~/Pages/Profile.aspx");
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

                // Insert new application
                using (SqlCommand cmd = new SqlCommand(@"
                    INSERT INTO JobApplications (UserId, JobId, Status, AppliedAt)
                    VALUES (@UserId, @JobId, 'Pending', GETDATE())", conn)) {
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    cmd.Parameters.AddWithValue("@JobId", jobId);
                    cmd.ExecuteNonQuery();

                    //for notifs
                    if (ownerUserId > 0) {
                        string applicantName = Session["UserName"] == null ? "May user" : Session["UserName"].ToString();
                        GROUP6_ANGAT.NotificationHelper.TryCreateNotification(
                            conn,
                            ownerUserId,
                            "Bagong job application",
                            string.Format("{0} applied to your job: {1}.", applicantName, title),
                            "job_application_new",
                            "~/Pages/Profile.aspx");
                    }
                }
            }

            ShowMessage("success", "Na-submit ang inyong application! Makikita ito sa inyong Profile.");
        }

        private void ShowMessage(string type, string message) {
            pnlApplyMessage.Visible = true;
            pnlApplyMessage.CssClass = $"form-alert {type}";
            lblApplyMessage.Text = message;
        }
    }
}