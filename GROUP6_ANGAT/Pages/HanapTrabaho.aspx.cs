using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;

namespace GROUP6_ANGAT.Pages
{
    public partial class HanapTrabaho : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool isLoggedIn = Session["UserId"] != null;
            phApplyLoggedIn.Visible = isLoggedIn;
            phApplyLoggedOut.Visible = !isLoggedIn;

            if (!IsPostBack)
            {
                LoadJobs();
            }
        }

        private void LoadJobs()
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"SELECT JobId, JobTitle, JobLocation, JobPay, JobTags, JobDescription, Status,
                                                            DateLabel, IconClass, IconBg, IconColor, Barangay, Category, PostedAt
                                                     FROM Jobs
                                                     WHERE IsActive = 1
                                                     ORDER BY PostedAt DESC", conn))
            {
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    rptJobs.DataSource = reader;
                    rptJobs.DataBind();
                }
            }
        }

        protected string GetTagsHtml(object tagsObj, object categoryObj)
        {
            string tagsRaw = tagsObj == null ? string.Empty : tagsObj.ToString();
            if (string.IsNullOrWhiteSpace(tagsRaw))
            {
                return string.Empty;
            }

            string category = categoryObj == null ? string.Empty : categoryObj.ToString();

            string[] tags = tagsRaw.Split(new[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
            var sb = new StringBuilder();

            for (int i = 0; i < tags.Length; i++)
            {
                string rawTag = tags[i].Trim();
                string tag = HttpUtility.HtmlEncode(rawTag);
                string css = GetTagClassForTag(rawTag, category);
                sb.AppendFormat("<span class=\"badge {0}\">{1}</span>", css, tag);
            }

            return sb.ToString();
        }

        protected string GetTagClassForTag(string tag, string category)
        {
            string normalized = (tag ?? string.Empty).ToLowerInvariant();
            if (normalized.Contains("full-time"))
            {
                return "tag-fulltime";
            }
            if (normalized.Contains("part-time"))
            {
                return "tag-parttime";
            }
            if (normalized.Contains("urgent"))
            {
                return "tag-urgent";
            }
            if (normalized.Contains("may tirahan"))
            {
                return "tag-housing";
            }
            if (normalized.Contains("may lisensya"))
            {
                return "tag-license";
            }
            if (normalized.Contains("pang-araw-araw"))
            {
                return "tag-daily";
            }
            if (normalized.Contains("pisikal"))
            {
                return "tag-physical";
            }
            if (normalized.Contains("may karanasan"))
            {
                return "tag-experience";
            }

            return GetTagClass(category);
        }

        protected string GetTagClass(object categoryObj)
        {
            string category = categoryObj == null ? string.Empty : categoryObj.ToString().ToLowerInvariant();
            if (category.Contains("house") || category.Contains("kasambahay"))
            {
                return "tag-mint";
            }
            if (category.Contains("driver"))
            {
                return "tag-blue";
            }
            if (category.Contains("laundry"))
            {
                return "tag-rose";
            }
            if (category.Contains("store") || category.Contains("retail"))
            {
                return "tag-amber";
            }
            if (category.Contains("food") || category.Contains("kusinero") || category.Contains("carinderia"))
            {
                return "tag-amber";
            }
            if (category.Contains("warehouse") || category.Contains("bodega"))
            {
                return "tag-violet";
            }
            return "tag-teal";
        }

        protected string GetSearchText(object titleObj, object locationObj, object tagsObj, object barangayObj, object categoryObj)
        {
            string title = titleObj == null ? "" : titleObj.ToString();
            string location = locationObj == null ? "" : locationObj.ToString();
            string tags = tagsObj == null ? "" : tagsObj.ToString().Replace("|", " ");
            string barangay = barangayObj == null ? "" : barangayObj.ToString();
            string category = categoryObj == null ? "" : categoryObj.ToString();
            return (title + " " + location + " " + tags + " " + barangay + " " + category).Trim();
        }

        protected string GetStatusClass(object statusObj)
        {
            string status = statusObj == null ? "" : statusObj.ToString().ToLower();
            if (status.Contains("busy"))
            {
                return "badge-rose";
            }
            if (status.Contains("bukas"))
            {
                return "badge-green";
            }
            return "badge-teal";
        }

        protected string GetPayDisplay(object payObj)
        {
            string pay = payObj == null ? "" : payObj.ToString();
            if (string.IsNullOrWhiteSpace(pay))
            {
                return "";
            }

            if (pay.Contains("?"))
            {
                pay = pay.Replace("?", "₱");
            }

            if (!pay.Contains("₱") && !pay.StartsWith("PHP", StringComparison.OrdinalIgnoreCase))
            {
                pay = "₱" + pay.TrimStart();
            }

            return HttpUtility.HtmlEncode(pay);
        }

        protected string GetPaySortValue(object payObj)
        {
            string pay = payObj == null ? "" : payObj.ToString();
            if (string.IsNullOrWhiteSpace(pay))
            {
                return "0";
            }

            // Extract the highest number found in the pay string
            string cleaned = pay.Replace(",", "");
            int max = 0;
            string current = "";
            foreach (char c in cleaned)
            {
                if (char.IsDigit(c))
                {
                    current += c;
                }
                else
                {
                    if (current.Length > 0)
                    {
                        if (int.TryParse(current, out int val) && val > max)
                        {
                            max = val;
                        }
                        current = "";
                    }
                }
            }
            if (current.Length > 0)
            {
                if (int.TryParse(current, out int val) && val > max)
                {
                    max = val;
                }
            }

            return max.ToString();
        }

        protected string GetPostedValue(object postedObj)
        {
            if (postedObj == null)
            {
                return "0";
            }

            if (DateTime.TryParse(postedObj.ToString(), out DateTime posted))
            {
                return posted.ToFileTimeUtc().ToString();
            }

            return "0";
        }

        protected void BtnApplyJob_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx?returnUrl=/Pages/HanapTrabaho.aspx");
                return;
            }

            if (!int.TryParse(hfJobId.Value, out int jobId))
            {
                pnlApplyMessage.Visible = true;
                pnlApplyMessage.CssClass = "form-alert error";
                lblApplyMessage.Text = "Piliin muna ang trabaho bago mag-apply.";
                return;
            }

            string title = (hfJobTitle.Value ?? string.Empty).Trim();
            string location = (hfJobLocation.Value ?? string.Empty).Trim();
            string pay = (hfJobPay.Value ?? string.Empty).Trim();
            string tags = (hfJobTags.Value ?? string.Empty).Trim();
            string desc = (hfJobDesc.Value ?? string.Empty).Trim();

            if (string.IsNullOrEmpty(title))
            {
                pnlApplyMessage.Visible = true;
                pnlApplyMessage.CssClass = "form-alert error";
                lblApplyMessage.Text = "Piliin muna ang trabaho bago mag-apply.";
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                int ownerUserId = 0;

                using (SqlCommand ownerCmd = new SqlCommand(@"SELECT PostedByUserId FROM Jobs WHERE JobId = @JobId", conn))
                {
                    ownerCmd.Parameters.AddWithValue("@JobId", jobId);
                    object ownerId = ownerCmd.ExecuteScalar();

                    if (ownerId != null && ownerId != DBNull.Value)
                    {
                        int.TryParse(ownerId.ToString(), out ownerUserId);

                        if (ownerUserId == Convert.ToInt32(Session["UserId"]))
                        {
                            pnlApplyMessage.Visible = true;
                            pnlApplyMessage.CssClass = "form-alert error";
                            lblApplyMessage.Text = "Hindi ka maaaring mag-apply sa sariling listing.";
                            return;
                        }
                    }
                }

                using (SqlCommand existsCmd = new SqlCommand(@"SELECT TOP 1 ApplicationId, Status 
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
                            int applicationId = Convert.ToInt32(reader["ApplicationId"]);
                            string status = reader["Status"].ToString();

                            if (string.Equals(status, "Retracted", StringComparison.OrdinalIgnoreCase))
                            {
                                reader.Close();
                                using (SqlCommand updateCmd = new SqlCommand(@"UPDATE JobApplications
                                                                             SET Status = 'Pending',
                                                                                 AppliedAt = GETDATE(),
                                                                                 JobTitle = @JobTitle,
                                                                                 JobLocation = @JobLocation,
                                                                                 JobPay = @JobPay,
                                                                                 JobTags = @JobTags,
                                                                                 JobDescription = @JobDescription
                                                                             WHERE ApplicationId = @ApplicationId", conn))
                                {
                                    updateCmd.Parameters.AddWithValue("@JobTitle", title);
                                    updateCmd.Parameters.AddWithValue("@JobLocation", location);
                                    updateCmd.Parameters.AddWithValue("@JobPay", pay);
                                    updateCmd.Parameters.AddWithValue("@JobTags", tags);
                                    updateCmd.Parameters.AddWithValue("@JobDescription", desc);
                                    updateCmd.Parameters.AddWithValue("@ApplicationId", applicationId);
                                    updateCmd.ExecuteNonQuery();
                                    //for notifs
                                    if (ownerUserId > 0)
                                    {
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

                                pnlApplyMessage.Visible = true;
                                pnlApplyMessage.CssClass = "form-alert success";
                                lblApplyMessage.Text = "Na-submit ulit ang inyong application.";
                                ClientScript.RegisterStartupScript(this.GetType(), "scrollApplyMsg", "window.location.hash='pnlApplyMessage';", true);
                                return;
                            }

                            pnlApplyMessage.Visible = true;
                            pnlApplyMessage.CssClass = "form-alert error";
                            lblApplyMessage.Text = "May active application ka na sa trabahong ito.";
                            return;
                        }
                    }
                }

                using (SqlCommand cmd = new SqlCommand(@"INSERT INTO JobApplications
                                                         (UserId, JobId, JobTitle, JobLocation, JobPay, JobTags, JobDescription, Status, AppliedAt)
                                                         VALUES (@UserId, @JobId, @JobTitle, @JobLocation, @JobPay, @JobTags, @JobDescription, 'Pending', GETDATE())", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    cmd.Parameters.AddWithValue("@JobId", jobId);
                    cmd.Parameters.AddWithValue("@JobTitle", title);
                    cmd.Parameters.AddWithValue("@JobLocation", location);
                    cmd.Parameters.AddWithValue("@JobPay", pay);
                    cmd.Parameters.AddWithValue("@JobTags", tags);
                    cmd.Parameters.AddWithValue("@JobDescription", desc);
                    cmd.ExecuteNonQuery();

                    //for notifs
                    if (ownerUserId > 0)
                    {
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

            pnlApplyMessage.Visible = true;
            pnlApplyMessage.CssClass = "form-alert success";
            lblApplyMessage.Text = "Na-submit ang inyong application. Makikita ito sa inyong profile status.";

            ClientScript.RegisterStartupScript(this.GetType(), "scrollApplyMsg", "window.location.hash='pnlApplyMessage';", true);
        }
    }
}
