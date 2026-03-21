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

        private void LoadJobs() {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString)) {
                conn.Open();

                using (SqlCommand countCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Jobs WHERE IsActive = 1", conn)) {
                    lblJobCount.Text = countCmd.ExecuteScalar().ToString();
                }

                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT JobId, JobTitle, JobDescription, Category,
                           Barangay, PayMin, PayMax, PayRate, Tags, Status, PostedAt
                    FROM Jobs
                    WHERE IsActive = 1
                    ORDER BY PostedAt DESC", conn)) {
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
            using (SqlConnection conn = new SqlConnection(connString)) {
                conn.Open();

                using (SqlCommand ownerCmd = new SqlCommand(
                    "SELECT PostedByUserId FROM Jobs WHERE JobId = @JobId", conn)) {
                    ownerCmd.Parameters.AddWithValue("@JobId", jobId);
                    object ownerId = ownerCmd.ExecuteScalar();
                    if (ownerId != null && ownerId != DBNull.Value &&
                        ownerId.ToString() == Session["UserId"].ToString()) {
                        ShowMessage("error", "Hindi ka maaaring mag-apply sa sariling listing.");
                        return;
                    }
                }

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
                    VALUES (@UserId, @JobId, 'Pending', GETDATE())", conn)) {
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    cmd.Parameters.AddWithValue("@JobId", jobId);
                    cmd.ExecuteNonQuery();
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