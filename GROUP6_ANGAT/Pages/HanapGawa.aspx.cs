using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web;

namespace GROUP6_ANGAT.Pages
{
    public partial class HanapGawa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool isLoggedIn = Session["UserId"] != null;
            phServiceLoggedIn.Visible = isLoggedIn;
            phServiceLoggedOut.Visible = !isLoggedIn;

            if (!IsPostBack)
            {
                LoadServices();
            }
        }

        private void LoadServices()
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"SELECT ServiceId, ServiceTitle, ServiceLocation, ServiceRate, ServiceTags, ServiceDescription, Status,
                                                            DateLabel, Barangay, Category, PostedAt
                                                     FROM Services
                                                     WHERE IsActive = 1
                                                     ORDER BY PostedAt DESC", conn))
            {
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    rptServices.DataSource = reader;
                    rptServices.DataBind();
                }
            }
        }

        protected void BtnRequestService_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx?returnUrl=/Pages/HanapGawa.aspx");
                return;
            }

            int serviceId;
            if (!int.TryParse(hfServiceId.Value, out serviceId))
            {
                pnlServiceApplyMessage.Visible = true;
                pnlServiceApplyMessage.CssClass = "form-alert error";
                lblServiceApplyMessage.Text = "Piliin muna ang serbisyo bago mag-request.";
                return;
            }

            string title = (hfServiceTitle.Value ?? string.Empty).Trim();
            string location = (hfServiceLocation.Value ?? string.Empty).Trim();
            string rate = (hfServiceRate.Value ?? string.Empty).Trim();
            string tags = (hfServiceTags.Value ?? string.Empty).Trim();
            string desc = (hfServiceDesc.Value ?? string.Empty).Trim();

            if (string.IsNullOrEmpty(title))
            {
                pnlServiceApplyMessage.Visible = true;
                pnlServiceApplyMessage.CssClass = "form-alert error";
                lblServiceApplyMessage.Text = "Piliin muna ang serbisyo bago mag-request.";
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                int ownerUserId = 0;

                using (SqlCommand ownerCmd = new SqlCommand(@"SELECT PostedByUserId FROM Services WHERE ServiceId = @ServiceId", conn))
                {
                    ownerCmd.Parameters.AddWithValue("@ServiceId", serviceId);
                    object ownerId = ownerCmd.ExecuteScalar();

                    if (ownerId != null && ownerId != DBNull.Value)
                    {
                        int.TryParse(ownerId.ToString(), out ownerUserId);

                        if (ownerUserId == Convert.ToInt32(Session["UserId"]))
                        {
                            pnlServiceApplyMessage.Visible = true;
                            pnlServiceApplyMessage.CssClass = "form-alert error";
                            lblServiceApplyMessage.Text = "Hindi ka maaaring mag-request sa sariling listing.";
                            return;
                        }
                    }
                }


                using (SqlCommand existsCmd = new SqlCommand(@"SELECT TOP 1 RequestId, Status 
                                                               FROM ServiceRequests 
                                                               WHERE UserId = @UserId AND ServiceId = @ServiceId
                                                               ORDER BY RequestedAt DESC", conn))
                {
                    existsCmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    existsCmd.Parameters.AddWithValue("@ServiceId", serviceId);

                    using (SqlDataReader reader = existsCmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int requestId = Convert.ToInt32(reader["RequestId"]);
                            string status = reader["Status"].ToString();

                            if (string.Equals(status, "Retracted", StringComparison.OrdinalIgnoreCase))
                            {
                                reader.Close();
                                using (SqlCommand updateCmd = new SqlCommand(@"UPDATE ServiceRequests
                                                                              SET Status = 'Pending',
                                                                                  RequestedAt = GETDATE(),
                                                                                  ServiceTitle = @ServiceTitle,
                                                                                  ServiceLocation = @ServiceLocation,
                                                                                  ServiceRate = @ServiceRate,
                                                                                  ServiceTags = @ServiceTags,
                                                                                  ServiceDescription = @ServiceDescription
                                                                              WHERE RequestId = @RequestId", conn))
                                {
                                    updateCmd.Parameters.AddWithValue("@ServiceTitle", title);
                                    updateCmd.Parameters.AddWithValue("@ServiceLocation", location);
                                    updateCmd.Parameters.AddWithValue("@ServiceRate", rate);
                                    updateCmd.Parameters.AddWithValue("@ServiceTags", tags);
                                    updateCmd.Parameters.AddWithValue("@ServiceDescription", desc);
                                    updateCmd.Parameters.AddWithValue("@RequestId", requestId);
                                    updateCmd.ExecuteNonQuery();

                                    //for notifs
                                    if (ownerUserId > 0)
                                    {
                                        string requesterName = Session["UserName"] == null ? "May user" : Session["UserName"].ToString();

                                        GROUP6_ANGAT.NotificationHelper.TryCreateNotification(
                                            conn,
                                            ownerUserId,
                                            "Bagong service request",
                                            string.Format("{0} requested your service: {1}.", requesterName, title),
                                            "service_request_new",
                                            "~/Pages/Profile.aspx");
                                    }
                                }

                                pnlServiceApplyMessage.Visible = true;
                                pnlServiceApplyMessage.CssClass = "form-alert success";
                                lblServiceApplyMessage.Text = "Na-submit ulit ang inyong request.";
                                ClientScript.RegisterStartupScript(this.GetType(), "scrollServiceMsg", "window.location.hash='pnlServiceApplyMessage';", true);
                                return;
                            }

                            pnlServiceApplyMessage.Visible = true;
                            pnlServiceApplyMessage.CssClass = "form-alert error";
                            lblServiceApplyMessage.Text = "May active request ka na sa serbisyong ito.";
                            return;
                        }
                    }
                }

                using (SqlCommand cmd = new SqlCommand(@"INSERT INTO ServiceRequests
                                                         (UserId, ServiceId, ServiceTitle, ServiceLocation, ServiceRate, ServiceTags, ServiceDescription, Status, RequestedAt)
                                                         VALUES (@UserId, @ServiceId, @ServiceTitle, @ServiceLocation, @ServiceRate, @ServiceTags, @ServiceDescription, 'Pending', GETDATE())", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    cmd.Parameters.AddWithValue("@ServiceId", serviceId);
                    cmd.Parameters.AddWithValue("@ServiceTitle", title);
                    cmd.Parameters.AddWithValue("@ServiceLocation", location);
                    cmd.Parameters.AddWithValue("@ServiceRate", rate);
                    cmd.Parameters.AddWithValue("@ServiceTags", tags);
                    cmd.Parameters.AddWithValue("@ServiceDescription", desc);
                    cmd.ExecuteNonQuery();

                    //for notifs
                    if (ownerUserId > 0)
                    {
                        string requesterName = Session["UserName"] == null ? "May user" : Session["UserName"].ToString();

                        GROUP6_ANGAT.NotificationHelper.TryCreateNotification(
                            conn,
                            ownerUserId,
                            "Bagong service request",
                            string.Format("{0} requested your service: {1}.", requesterName, title),
                            "service_request_new",
                            "~/Pages/Profile.aspx");
                    }
                }
            }

            pnlServiceApplyMessage.Visible = true;
            pnlServiceApplyMessage.CssClass = "form-alert success";
            lblServiceApplyMessage.Text = "Na-submit ang inyong request. Makikita ito sa inyong profile status.";

            ClientScript.RegisterStartupScript(this.GetType(), "scrollServiceMsg", "window.location.hash='pnlServiceApplyMessage';", true);
        }
    }
}
