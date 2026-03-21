using System;
using System.Configuration;
using System.Data.SqlClient;

namespace GROUP6_ANGAT.Pages {
    public partial class HanapGawa : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            bool isLoggedIn = Session["UserId"] != null;
            phServiceLoggedIn.Visible = isLoggedIn;
            phServiceLoggedOut.Visible = !isLoggedIn;

            if (!IsPostBack)
                LoadServices();
        }

        protected string GetRelativeTime(object postedAt) {
            if (postedAt == null || postedAt == DBNull.Value)
                return "";

            DateTime postDate = Convert.ToDateTime(postedAt);
            TimeSpan ts = DateTime.Now - postDate;

            if (ts.TotalSeconds < 60) return "just now";
            if (ts.TotalMinutes < 60) return (int)ts.TotalMinutes + "m";
            if (ts.TotalHours < 24) return (int)ts.TotalHours + "h";
            if (ts.TotalDays < 7) return (int)ts.TotalDays + "d";

            return postDate.ToString("MMM dd");
        }

        private void LoadServices() {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString)) {
                conn.Open();

                // Service count label
                using (SqlCommand countCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Services WHERE IsActive = 1", conn)) {
                    lblServiceCount.Text = countCmd.ExecuteScalar().ToString();
                }

                // Load services with poster info (same JOIN pattern as HanapTrabaho)
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT s.ServiceId, s.ServiceTitle, s.ServiceDescription, s.Category,
                           s.Barangay, s.RateMin, s.RateMax, s.RateType, s.Tags,
                           s.Status, s.PostedAt, u.FullName AS PosterName,
                           u.ProfileImagePath AS PosterImage
                    FROM Services s
                    LEFT JOIN Users u ON s.PostedByUserId = u.UserId
                    WHERE s.IsActive = 1
                    ORDER BY s.PostedAt DESC", conn)) {
                    using (SqlDataReader reader = cmd.ExecuteReader()) {
                        rptServices.DataSource = reader;
                        rptServices.DataBind();
                    }
                }
            }

            pnlEmpty.Visible = rptServices.Items.Count == 0;
        }

        protected void BtnRequestService_Click(object sender, EventArgs e) {
            if (Session["UserId"] == null) {
                Response.Redirect("~/Pages/Login.aspx?returnUrl=/Pages/HanapGawa.aspx");
                return;
            }

            if (!int.TryParse(hfServiceId.Value, out int serviceId)) {
                ShowMessage("error", "Piliin muna ang serbisyo bago mag-request.");
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString)) {
                conn.Open();

                using (SqlCommand ownerCmd = new SqlCommand(
                    "SELECT PostedByUserId FROM Services WHERE ServiceId = @ServiceId", conn)) {
                    ownerCmd.Parameters.AddWithValue("@ServiceId", serviceId);
                    object ownerId = ownerCmd.ExecuteScalar();
                    if (ownerId != null && ownerId != DBNull.Value &&
                        ownerId.ToString() == Session["UserId"].ToString()) {
                        ShowMessage("error", "Hindi ka maaaring mag-request sa sariling listing.");
                        return;
                    }
                }

                using (SqlCommand existsCmd = new SqlCommand(@"
                    SELECT TOP 1 RequestId, Status
                    FROM ServiceRequests
                    WHERE UserId = @UserId AND ServiceId = @ServiceId
                    ORDER BY RequestedAt DESC", conn)) {
                    existsCmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    existsCmd.Parameters.AddWithValue("@ServiceId", serviceId);

                    using (SqlDataReader reader = existsCmd.ExecuteReader()) {
                        if (reader.Read()) {
                            string status = reader["Status"].ToString();
                            int requestId = Convert.ToInt32(reader["RequestId"]);
                            reader.Close();

                            if (string.Equals(status, "Retracted", StringComparison.OrdinalIgnoreCase)) {
                                using (SqlCommand updateCmd = new SqlCommand(@"
                                    UPDATE ServiceRequests
                                    SET Status = 'Pending', RequestedAt = GETDATE()
                                    WHERE RequestId = @RequestId", conn)) {
                                    updateCmd.Parameters.AddWithValue("@RequestId", requestId);
                                    updateCmd.ExecuteNonQuery();
                                }
                                ShowMessage("success", "Na-submit ulit ang inyong request.");
                                return;
                            }

                            ShowMessage("error", "May active request ka na sa serbisyong ito.");
                            return;
                        }
                    }
                }

                using (SqlCommand cmd = new SqlCommand(@"
                    INSERT INTO ServiceRequests (UserId, ServiceId, Status, RequestedAt)
                    VALUES (@UserId, @ServiceId, 'Pending', GETDATE())", conn)) {
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    cmd.Parameters.AddWithValue("@ServiceId", serviceId);
                    cmd.ExecuteNonQuery();
                }
            }

            ShowMessage("success", "Na-submit ang inyong request! Makikita ito sa inyong Profile.");
        }

        private void ShowMessage(string type, string message) {
            pnlServiceApplyMessage.Visible = true;
            pnlServiceApplyMessage.CssClass = $"form-alert {type}";
            lblServiceApplyMessage.Text = message;
        }
    }
}