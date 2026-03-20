using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace GROUP6_ANGAT
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProfile();
                LoadApplications();
                LoadServiceRequests();
                LoadMyListings();
                LoadMyServiceListings();
            }
        }

        private void LoadProfile()
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"SELECT FullName, Email, Phone, AddressLine, Barangay, Bio, Role, ProfileImagePath
                                                     FROM Users
                                                     WHERE UserId = @UserId", conn))
            {
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleRow))
                {
                    if (reader.Read())
                    {
                        string fullName = reader["FullName"].ToString();
                        string email = reader["Email"].ToString();

                        lblProfileName.Text = fullName;
                        lblProfileEmail.Text = email;
                        lblProfileRole.Text = string.IsNullOrWhiteSpace(reader["Role"].ToString()) ? "User" : reader["Role"].ToString();

                        txtFullName.Text = fullName;
                        txtEmail.Text = email;
                        txtPhone.Text = reader["Phone"].ToString();
                        txtAddress.Text = reader["AddressLine"].ToString();
                        txtBarangay.Text = reader["Barangay"].ToString();
                        txtBio.Text = reader["Bio"].ToString();

                        string imagePath = reader["ProfileImagePath"].ToString();
                        imgProfile.ImageUrl = string.IsNullOrWhiteSpace(imagePath) ? "~/Images/angat_logo.png" : imagePath;
                    }
                }
            }
        }

        private void LoadApplications()
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"SELECT ApplicationId, JobTitle, JobLocation, JobPay, JobTags, Status, AppliedAt
                                                     FROM JobApplications
                                                     WHERE UserId = @UserId
                                                     ORDER BY AppliedAt DESC", conn))
            {
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        rptApplications.DataSource = reader;
                        rptApplications.DataBind();
                        pnlNoApplications.Visible = false;
                    }
                    else
                    {
                        rptApplications.DataSource = null;
                        rptApplications.DataBind();
                        pnlNoApplications.Visible = true;
                    }
                }
            }
        }

        private void LoadServiceRequests()
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"SELECT RequestId, ServiceTitle, ServiceLocation, ServiceRate, ServiceTags, Status, RequestedAt
                                                     FROM ServiceRequests
                                                     WHERE UserId = @UserId
                                                     ORDER BY RequestedAt DESC", conn))
            {
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        rptServiceRequests.DataSource = reader;
                        rptServiceRequests.DataBind();
                        pnlNoServiceRequests.Visible = false;
                    }
                    else
                    {
                        rptServiceRequests.DataSource = null;
                        rptServiceRequests.DataBind();
                        pnlNoServiceRequests.Visible = true;
                    }
                }
            }
        }

        private void LoadMyListings()
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"SELECT JobId, JobTitle, JobLocation, JobPay, JobTags, Status, PostedAt
                                                     FROM Jobs
                                                     WHERE PostedByUserId = @UserId
                                                     ORDER BY PostedAt DESC", conn))
            {
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        rptMyListings.DataSource = reader;
                        rptMyListings.DataBind();
                        pnlNoListings.Visible = false;
                    }
                    else
                    {
                        rptMyListings.DataSource = null;
                        rptMyListings.DataBind();
                        pnlNoListings.Visible = true;
                    }
                }
            }
        }

        private void LoadMyServiceListings()
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"SELECT ServiceId, ServiceTitle, ServiceLocation, ServiceRate, ServiceTags, Status, PostedAt
                                                     FROM Services
                                                     WHERE PostedByUserId = @UserId
                                                     ORDER BY PostedAt DESC", conn))
            {
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        rptServiceListings.DataSource = reader;
                        rptServiceListings.DataBind();
                        pnlNoServiceListings.Visible = false;
                    }
                    else
                    {
                        rptServiceListings.DataSource = null;
                        rptServiceListings.DataBind();
                        pnlNoServiceListings.Visible = true;
                    }
                }
            }
        }

        protected void RptMyListings_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != System.Web.UI.WebControls.ListItemType.Item &&
                e.Item.ItemType != System.Web.UI.WebControls.ListItemType.AlternatingItem)
            {
                return;
            }

            var hf = (System.Web.UI.WebControls.HiddenField)e.Item.FindControl("hfListingJobId");
            var rptApplicants = (System.Web.UI.WebControls.Repeater)e.Item.FindControl("rptApplicants");
            var pnlNoApplicants = (System.Web.UI.WebControls.Panel)e.Item.FindControl("pnlNoApplicants");

            int jobId;
            if (hf != null && int.TryParse(hf.Value, out jobId))
            {
                LoadApplicants(jobId, rptApplicants, pnlNoApplicants);
            }
        }

        protected void RptServiceListings_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != System.Web.UI.WebControls.ListItemType.Item &&
                e.Item.ItemType != System.Web.UI.WebControls.ListItemType.AlternatingItem)
            {
                return;
            }

            var hf = (System.Web.UI.WebControls.HiddenField)e.Item.FindControl("hfListingServiceId");
            var rptApplicants = (System.Web.UI.WebControls.Repeater)e.Item.FindControl("rptServiceApplicants");
            var pnlNoApplicants = (System.Web.UI.WebControls.Panel)e.Item.FindControl("pnlNoServiceApplicants");

            int serviceId;
            if (hf != null && int.TryParse(hf.Value, out serviceId))
            {
                LoadServiceApplicants(serviceId, rptApplicants, pnlNoApplicants);
            }
        }

        private void LoadApplicants(int jobId, System.Web.UI.WebControls.Repeater rpt, System.Web.UI.WebControls.Panel pnlEmpty)
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"SELECT ja.ApplicationId, ja.Status, ja.AppliedAt,
                                                            u.FullName, u.Email, u.Phone
                                                     FROM JobApplications ja
                                                     INNER JOIN Users u ON ja.UserId = u.UserId
                                                     WHERE ja.JobId = @JobId
                                                     ORDER BY ja.AppliedAt DESC", conn))
            {
                cmd.Parameters.AddWithValue("@JobId", jobId);
                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        rpt.DataSource = reader;
                        rpt.DataBind();
                        pnlEmpty.Visible = false;
                    }
                    else
                    {
                        rpt.DataSource = null;
                        rpt.DataBind();
                        pnlEmpty.Visible = true;
                    }
                }
            }
        }

        private void LoadServiceApplicants(int serviceId, System.Web.UI.WebControls.Repeater rpt, System.Web.UI.WebControls.Panel pnlEmpty)
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"SELECT sr.RequestId, sr.Status, sr.RequestedAt,
                                                            u.FullName, u.Email, u.Phone
                                                     FROM ServiceRequests sr
                                                     INNER JOIN Users u ON sr.UserId = u.UserId
                                                     WHERE sr.ServiceId = @ServiceId
                                                     ORDER BY sr.RequestedAt DESC", conn))
            {
                cmd.Parameters.AddWithValue("@ServiceId", serviceId);
                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        rpt.DataSource = reader;
                        rpt.DataBind();
                        pnlEmpty.Visible = false;
                    }
                    else
                    {
                        rpt.DataSource = null;
                        rpt.DataBind();
                        pnlEmpty.Visible = true;
                    }
                }
            }
        }

        protected void RptApplicants_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            string newStatus = null;

            if (e.CommandName == "Approve")
            {
                newStatus = "Approved";
            }
            else if (e.CommandName == "Reject")
            {
                newStatus = "Rejected";
            }
            else
            {
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            int rows = 0;
            

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"UPDATE JobApplications
                                 SET Status = @Status
                                 WHERE ApplicationId = @ApplicationId
                                   AND JobId IN (SELECT JobId FROM Jobs WHERE PostedByUserId = @UserId)", conn))

            {
                cmd.Parameters.AddWithValue("@Status", newStatus);
                cmd.Parameters.AddWithValue("@ApplicationId", e.CommandArgument);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();

                rows = cmd.ExecuteNonQuery();
            }

            pnlApplicationsMessage.Visible = true;
            pnlApplicationsMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
            lblApplicationsMessage.Text = rows > 0 ? "Na-update ang status ng applicant." : "Hindi ma-update ang status.";

            LoadMyListings();
        }


        protected void RptServiceApplicants_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            string newStatus = null;

            if (e.CommandName == "ApproveService")
            {
                newStatus = "Approved";
            }
            else if (e.CommandName == "RejectService")
            {
                newStatus = "Rejected";
            }
            else
            {
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            int rows = 0;
            

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"UPDATE ServiceRequests
                                             SET Status = @Status
                                             WHERE RequestId = @RequestId
                                               AND ServiceId IN (SELECT ServiceId FROM Services WHERE PostedByUserId = @UserId)", conn))
            {
                cmd.Parameters.AddWithValue("@Status", newStatus);
                cmd.Parameters.AddWithValue("@RequestId", e.CommandArgument);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();

                rows = cmd.ExecuteNonQuery();

            }

            pnlServiceMessage.Visible = true;
            pnlServiceMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
            lblServiceMessage.Text = rows > 0 ? "Na-update ang status ng requester." : "Hindi ma-update ang status.";

            LoadMyServiceListings();
        }


        protected void RptMyListings_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "DeleteListing")
            {
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand(@"UPDATE Jobs
                                                         SET IsActive = 0
                                                         WHERE JobId = @JobId AND PostedByUserId = @UserId", conn))
                {
                    cmd.Parameters.AddWithValue("@JobId", e.CommandArgument);
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    int rows = cmd.ExecuteNonQuery();

                    pnlApplicationsMessage.Visible = true;
                    pnlApplicationsMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
                    lblApplicationsMessage.Text = rows > 0 ? "Na-delete ang listing." : "Hindi ma-delete ang listing.";
                }
            }

            LoadMyListings();
        }

        protected void RptServiceListings_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "DeleteServiceListing")
            {
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand(@"UPDATE Services
                                                         SET IsActive = 0
                                                         WHERE ServiceId = @ServiceId AND PostedByUserId = @UserId", conn))
                {
                    cmd.Parameters.AddWithValue("@ServiceId", e.CommandArgument);
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    int rows = cmd.ExecuteNonQuery();

                    pnlServiceMessage.Visible = true;
                    pnlServiceMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
                    lblServiceMessage.Text = rows > 0 ? "Na-delete ang service listing." : "Hindi ma-delete ang listing.";
                }
            }

            LoadMyServiceListings();
        }

        protected string FormatTags(object tagsObj)
        {
            return tagsObj == null ? "" : tagsObj.ToString().Replace("|", ", ");
        }

        protected void RptApplications_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "Retract")
            {
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"UPDATE JobApplications
                                                     SET Status = 'Retracted'
                                                     WHERE ApplicationId = @ApplicationId AND UserId = @UserId AND Status = 'Pending'", conn))
            {
                cmd.Parameters.AddWithValue("@ApplicationId", e.CommandArgument);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();

                pnlApplicationsMessage.Visible = true;
                pnlApplicationsMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
                lblApplicationsMessage.Text = rows > 0 ? "Na-retract ang application." : "Hindi ma-retract ang application.";
            }

            LoadApplications();
        }

        protected void RptServiceRequests_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "RetractService")
            {
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"UPDATE ServiceRequests
                                                     SET Status = 'Retracted'
                                                     WHERE RequestId = @RequestId AND UserId = @UserId AND Status = 'Pending'", conn))
            {
                cmd.Parameters.AddWithValue("@RequestId", e.CommandArgument);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();

                pnlServiceMessage.Visible = true;
                pnlServiceMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
                lblServiceMessage.Text = rows > 0 ? "Na-retract ang request." : "Hindi ma-retract ang request.";
            }

            LoadServiceRequests();
        }

        protected void BtnSaveProfile_Click(object sender, EventArgs e)
        {
            lblProfileMessage.Text = "";

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            string newImagePath = null;

            if (fuProfileImage.HasFile)
            {
                string ext = Path.GetExtension(fuProfileImage.FileName).ToLowerInvariant();
                if (ext != ".jpg" && ext != ".jpeg" && ext != ".png")
                {
                    lblProfileMessage.Text = "JPG o PNG lang ang pwede i-upload.";
                    return;
                }

                string folder = Server.MapPath("~/Images/Profiles/");
                Directory.CreateDirectory(folder);

                string fileName = $"user_{Session["UserId"]}_{DateTime.Now.Ticks}{ext}";
                string savePath = Path.Combine(folder, fileName);
                fuProfileImage.SaveAs(savePath);
                newImagePath = "~/Images/Profiles/" + fileName;
            }

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"UPDATE Users
                                                     SET FullName = @FullName,
                                                         Email = @Email,
                                                         Phone = @Phone,
                                                         AddressLine = @AddressLine,
                                                         Barangay = @Barangay,
                                                         Bio = @Bio,
                                                         ProfileImagePath = COALESCE(@ProfileImagePath, ProfileImagePath)
                                                     WHERE UserId = @UserId", conn))
            {
                cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim().ToLowerInvariant());
                cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                cmd.Parameters.AddWithValue("@AddressLine", txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@Barangay", txtBarangay.Text.Trim());
                cmd.Parameters.AddWithValue("@Bio", txtBio.Text.Trim());
                cmd.Parameters.AddWithValue("@ProfileImagePath", (object)newImagePath ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 2627 || ex.Number == 2601)
                    {
                        lblProfileMessage.Text = "Email ay ginagamit na. Gumamit ng iba.";
                    }
                    else
                    {
                        lblProfileMessage.Text = "Hindi na-save ang profile. Subukan ulit.";
                    }
                    return;
                }
            }

            Session["UserName"] = txtFullName.Text.Trim();
            Session["UserEmail"] = txtEmail.Text.Trim().ToLowerInvariant();
            lblProfileMessage.Text = "Na-save ang profile.";

            LoadProfile();
        }

        protected void BtnChangePassword_Click(object sender, EventArgs e)
        {
            lblPasswordMessage.Text = "";

            string current = txtCurrentPassword.Text.Trim();
            string next = txtNewPassword.Text.Trim();
            string confirm = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(current) || string.IsNullOrEmpty(next))
            {
                lblPasswordMessage.Text = "Paki-kumpleto ang password fields.";
                return;
            }

            if (!string.Equals(next, confirm, StringComparison.Ordinal))
            {
                lblPasswordMessage.Text = "Hindi magkatugma ang bagong password.";
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            string storedPassword = "";

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"SELECT Password FROM Users WHERE UserId = @UserId", conn))
            {
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                object result = cmd.ExecuteScalar();
                storedPassword = result != null ? result.ToString() : "";
            }

            if (!string.Equals(current, storedPassword, StringComparison.Ordinal))
            {
                lblPasswordMessage.Text = "Mali ang kasalukuyang password.";
                return;
            }

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"UPDATE Users SET Password = @Password WHERE UserId = @UserId", conn))
            {
                cmd.Parameters.AddWithValue("@Password", next);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            txtCurrentPassword.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";
            lblPasswordMessage.Text = "Na-update ang password.";
        }
    }
}
