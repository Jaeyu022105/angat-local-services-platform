using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace GROUP6_ANGAT {
    public partial class Profile : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (Session["UserId"] == null) {
                Response.Redirect("~/Pages/Login.aspx");
                return;
            }

            if (!IsPostBack) {
                LoadProfile();
                LoadApplications();
                LoadServiceRequests();
                LoadMyListings();
                LoadMyServiceListings();
                LoadMyBusinessListings();
            }
        }

        // =============================================
        // LOAD PROFILE
        // =============================================
        private void LoadProfile() {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT FullName, Email, Phone, AddressLine, Barangay, Role, ProfileImagePath
                FROM Users WHERE UserId = @UserId", conn)) {
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleRow)) {
                    if (reader.Read()) {
                        string fullName = reader["FullName"].ToString();
                        string email = reader["Email"].ToString();

                        lblProfileName.Text = fullName;
                        lblProfileEmail.Text = string.IsNullOrWhiteSpace(email) ? "Walang email" : email;
                        lblProfileRole.Text = string.IsNullOrWhiteSpace(reader["Role"].ToString()) ? "User" : reader["Role"].ToString();

                        txtFullName.Text = fullName;
                        txtEmail.Text = email;
                        txtPhone.Text = reader["Phone"].ToString();
                        txtAddress.Text = reader["AddressLine"].ToString();
                        txtBarangay.Text = reader["Barangay"].ToString();

                        string imagePath = reader["ProfileImagePath"].ToString();
                        imgProfile.ImageUrl = string.IsNullOrWhiteSpace(imagePath)
                            ? "~/Images/default-avatar.png"
                            : imagePath;
                    }
                }
            }
        }

        // =============================================
        // LOAD APPLICATIONS (user applied to jobs)
        // =============================================
        private void LoadApplications() {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT ja.ApplicationId, ja.Status, ja.AppliedAt,
                       j.JobTitle, j.Barangay, j.PayMin, j.PayMax, j.PayRate, j.Tags, j.Category
                FROM JobApplications ja
                LEFT JOIN Jobs j ON ja.JobId = j.JobId
                WHERE ja.UserId = @UserId
                ORDER BY ja.AppliedAt DESC", conn)) {
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader()) {
                    bool hasRows = reader.HasRows;
                    rptApplications.DataSource = reader;
                    rptApplications.DataBind();
                    pnlNoApplications.Visible = !hasRows;
                }
            }
        }

        // =============================================
        // LOAD SERVICE REQUESTS (user requested services)
        // =============================================
        private void LoadServiceRequests() {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT sr.RequestId, sr.Status, sr.RequestedAt,
                       s.ServiceTitle, s.Barangay, s.RateMin, s.RateMax, s.RateType, s.Tags, s.Category
                FROM ServiceRequests sr
                LEFT JOIN Services s ON sr.ServiceId = s.ServiceId
                WHERE sr.UserId = @UserId
                ORDER BY sr.RequestedAt DESC", conn)) {
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader()) {
                    bool hasRows = reader.HasRows;
                    rptServiceRequests.DataSource = reader;
                    rptServiceRequests.DataBind();
                    pnlNoServiceRequests.Visible = !hasRows;
                }
            }
        }

        // =============================================
        // LOAD MY JOB LISTINGS (user posted jobs)
        // =============================================
        private void LoadMyListings() {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT JobId, JobTitle, Barangay, PayMin, PayMax, PayRate,
                       Tags, Category, Status, PostedAt, Slots
                FROM Jobs
                WHERE PostedByUserId = @UserId
                ORDER BY PostedAt DESC", conn)) {
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader()) {
                    bool hasRows = reader.HasRows;
                    rptMyListings.DataSource = reader;
                    rptMyListings.DataBind();
                    pnlNoListings.Visible = !hasRows;
                }
            }
        }

        // =============================================
        // LOAD MY SERVICE LISTINGS (user posted services)
        // =============================================
        private void LoadMyServiceListings() {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT ServiceId, ServiceTitle, Barangay, RateMin, RateMax, RateType,
                       Tags, Category, Status, PostedAt
                FROM Services
                WHERE PostedByUserId = @UserId
                ORDER BY PostedAt DESC", conn)) {
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader()) {
                    bool hasRows = reader.HasRows;
                    rptServiceListings.DataSource = reader;
                    rptServiceListings.DataBind();
                    pnlNoServiceListings.Visible = !hasRows;
                }
            }
        }

        // =============================================
        // LOAD MY BUSINESS LISTINGS (user posted negosyo)
        // =============================================
        private void LoadMyBusinessListings() {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT DirectoryId, BusinessName, Category, Barangay, AddressLine, Tags, Status, CreatedAt, ContactNumber
                FROM DirectoryBusinesses
                WHERE UserId = @UserId AND IsActive = 1
                ORDER BY CreatedAt DESC", conn)) {
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader()) {
                    bool hasRows = reader.HasRows;
                    rptBusinessListings.DataSource = reader;
                    rptBusinessListings.DataBind();
                    pnlNoBusinessListings.Visible = !hasRows;
                }
            }
        }
        // ITEM DATA BOUND — load nested applicants
        // =============================================
        protected void RptMyListings_ItemDataBound(object sender, RepeaterItemEventArgs e) {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var hf = (System.Web.UI.WebControls.HiddenField)e.Item.FindControl("hfListingJobId");
            var rptApplicants = (Repeater)e.Item.FindControl("rptApplicants");
            var pnlNoApplicants = (System.Web.UI.WebControls.Panel)e.Item.FindControl("pnlNoApplicants");

            int jobId;
            if (hf != null && int.TryParse(hf.Value, out jobId))
                LoadApplicants(jobId, rptApplicants, pnlNoApplicants);
        }

        protected void RptServiceListings_ItemDataBound(object sender, RepeaterItemEventArgs e) {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var hf = (System.Web.UI.WebControls.HiddenField)e.Item.FindControl("hfListingServiceId");
            var rptApplicants = (Repeater)e.Item.FindControl("rptServiceApplicants");
            var pnlNoApplicants = (System.Web.UI.WebControls.Panel)e.Item.FindControl("pnlNoServiceApplicants");

            int serviceId;
            if (hf != null && int.TryParse(hf.Value, out serviceId))
                LoadServiceApplicants(serviceId, rptApplicants, pnlNoApplicants);
        }

        private void LoadApplicants(int jobId, Repeater rpt, System.Web.UI.WebControls.Panel pnlEmpty) {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT ja.ApplicationId, ja.Status, ja.AppliedAt,
                       u.FullName, u.Email, u.Phone
                FROM JobApplications ja
                INNER JOIN Users u ON ja.UserId = u.UserId
                WHERE ja.JobId = @JobId
                ORDER BY ja.AppliedAt DESC", conn)) {
                cmd.Parameters.AddWithValue("@JobId", jobId);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader()) {
                    bool hasRows = reader.HasRows;
                    rpt.DataSource = reader;
                    rpt.DataBind();
                    pnlEmpty.Visible = !hasRows;
                }
            }
        }

        private void LoadServiceApplicants(int serviceId, Repeater rpt, System.Web.UI.WebControls.Panel pnlEmpty) {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT sr.RequestId, sr.Status, sr.RequestedAt,
                       u.FullName, u.Email, u.Phone
                FROM ServiceRequests sr
                INNER JOIN Users u ON sr.UserId = u.UserId
                WHERE sr.ServiceId = @ServiceId
                ORDER BY sr.RequestedAt DESC", conn)) {
                cmd.Parameters.AddWithValue("@ServiceId", serviceId);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader()) {
                    bool hasRows = reader.HasRows;
                    rpt.DataSource = reader;
                    rpt.DataBind();
                    pnlEmpty.Visible = !hasRows;
                }
            }
        }

        // =============================================
        // APPROVE / REJECT JOB APPLICANTS + SLOTS
        // =============================================
        protected void RptApplicants_ItemCommand(object source, RepeaterCommandEventArgs e) {
            string newStatus = null;
            if (e.CommandName == "Approve") newStatus = "Approved";
            else if (e.CommandName == "Reject") newStatus = "Rejected";
            else return;

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            int rows = 0;

            using (SqlConnection conn = new SqlConnection(connString)) {
                conn.Open();

                // Update application status
                using (SqlCommand cmd = new SqlCommand(@"
                    UPDATE JobApplications SET Status = @Status
                    WHERE ApplicationId = @ApplicationId
                    AND JobId IN (SELECT JobId FROM Jobs WHERE PostedByUserId = @UserId)", conn)) {
                    cmd.Parameters.AddWithValue("@Status", newStatus);
                    cmd.Parameters.AddWithValue("@ApplicationId", e.CommandArgument);
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    rows = cmd.ExecuteNonQuery();
                }

                // If approved, decrease slots and auto-close if full
                if (newStatus == "Approved" && rows > 0) {
                    using (SqlCommand slotsCmd = new SqlCommand(@"
                        UPDATE Jobs
                        SET Slots = Slots - 1,
                            IsActive = CASE WHEN Slots - 1 <= 0 THEN 0 ELSE 1 END,
                            Status   = CASE WHEN Slots - 1 <= 0 THEN 'Filled' ELSE Status END
                        WHERE JobId IN (
                            SELECT JobId FROM JobApplications WHERE ApplicationId = @ApplicationId
                        )
                        AND PostedByUserId = @UserId", conn)) {
                        slotsCmd.Parameters.AddWithValue("@ApplicationId", e.CommandArgument);
                        slotsCmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                        slotsCmd.ExecuteNonQuery();
                    }
                }
            }

            pnlApplicationsMessage.Visible = true;
            pnlApplicationsMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
            lblApplicationsMessage.Text = rows > 0 ? "Na-update ang status ng applicant." : "Hindi ma-update ang status.";

            LoadMyListings();
        }

        // =============================================
        // APPROVE / REJECT SERVICE REQUESTS
        // =============================================
        protected void RptServiceApplicants_ItemCommand(object source, RepeaterCommandEventArgs e) {
            string newStatus = null;
            if (e.CommandName == "ApproveService") newStatus = "Approved";
            else if (e.CommandName == "RejectService") newStatus = "Rejected";
            else return;

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            int rows = 0;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                UPDATE ServiceRequests SET Status = @Status
                WHERE RequestId = @RequestId
                AND ServiceId IN (SELECT ServiceId FROM Services WHERE PostedByUserId = @UserId)", conn)) {
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

        // =============================================
        // DELETE JOB LISTING
        // =============================================
        protected void RptMyListings_ItemCommand(object source, RepeaterCommandEventArgs e) {
            if (e.CommandName != "DeleteListing") return;

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                UPDATE Jobs SET IsActive = 0
                WHERE JobId = @JobId AND PostedByUserId = @UserId", conn)) {
                cmd.Parameters.AddWithValue("@JobId", e.CommandArgument);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();

                pnlApplicationsMessage.Visible = true;
                pnlApplicationsMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
                lblApplicationsMessage.Text = rows > 0 ? "Na-delete ang listing." : "Hindi ma-delete ang listing.";
            }

            LoadMyListings();
        }

        // =============================================
        // DELETE SERVICE LISTING
        // =============================================
        protected void RptServiceListings_ItemCommand(object source, RepeaterCommandEventArgs e) {
            if (e.CommandName != "DeleteServiceListing") return;

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                UPDATE Services SET IsActive = 0
                WHERE ServiceId = @ServiceId AND PostedByUserId = @UserId", conn)) {
                cmd.Parameters.AddWithValue("@ServiceId", e.CommandArgument);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();

                pnlServiceMessage.Visible = true;
                pnlServiceMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
                lblServiceMessage.Text = rows > 0 ? "Na-delete ang service listing." : "Hindi ma-delete ang listing.";
            }

            LoadMyServiceListings();
        }

        // =============================================
        // DELETE BUSINESS LISTING
        // =============================================
        protected void RptBusinessListings_ItemCommand(object source, RepeaterCommandEventArgs e) {
            if (e.CommandName != "DeleteBusinessListing") return;

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                UPDATE DirectoryBusinesses SET IsActive = 0
                WHERE DirectoryId = @DirectoryId AND UserId = @UserId", conn)) {
                cmd.Parameters.AddWithValue("@DirectoryId", e.CommandArgument);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();

                pnlBusinessMessage.Visible = true;
                pnlBusinessMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
                lblBusinessMessage.Text = rows > 0 ? "Na-delete ang negosyo listing." : "Hindi ma-delete ang listing.";
            }

            LoadMyBusinessListings();
        }
        // =============================================
        // RETRACT APPLICATION
        // =============================================
        protected void RptApplications_ItemCommand(object source, RepeaterCommandEventArgs e) {
            if (e.CommandName != "Retract") return;

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                UPDATE JobApplications SET Status = 'Retracted'
                WHERE ApplicationId = @ApplicationId AND UserId = @UserId AND Status = 'Pending'", conn)) {
                cmd.Parameters.AddWithValue("@ApplicationId", e.CommandArgument);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();

                pnlApplicationsMessage.Visible = true;
                pnlApplicationsMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
                lblApplicationsMessage.Text = rows > 0 ? "Na-retract ang application." : "Hindi ma-retract.";
            }

            LoadApplications();
        }

        // =============================================
        // RETRACT SERVICE REQUEST
        // =============================================
        protected void RptServiceRequests_ItemCommand(object source, RepeaterCommandEventArgs e) {
            if (e.CommandName != "RetractService") return;

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                UPDATE ServiceRequests SET Status = 'Retracted'
                WHERE RequestId = @RequestId AND UserId = @UserId AND Status = 'Pending'", conn)) {
                cmd.Parameters.AddWithValue("@RequestId", e.CommandArgument);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();

                pnlServiceMessage.Visible = true;
                pnlServiceMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
                lblServiceMessage.Text = rows > 0 ? "Na-retract ang request." : "Hindi ma-retract.";
            }

            LoadServiceRequests();
        }

        // =============================================
        // SAVE PROFILE + PHOTO
        // =============================================
        protected void BtnSaveProfile_Click(object sender, EventArgs e) {
            lblProfileMessage.Text = "";
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            string newImagePath = null;

            if (fuProfileImage.HasFile) {
                string ext = Path.GetExtension(fuProfileImage.FileName).ToLowerInvariant();
                if (ext != ".jpg" && ext != ".jpeg" && ext != ".png") {
                    lblProfileMessage.Text = "JPG o PNG lang ang pwede i-upload.";
                    return;
                }

                string folder = Server.MapPath("~/Images/Profiles/");
                Directory.CreateDirectory(folder);
                string fileName = $"user_{Session["UserId"]}_{DateTime.Now.Ticks}{ext}";
                fuProfileImage.SaveAs(Path.Combine(folder, fileName));
                newImagePath = "~/Images/Profiles/" + fileName;
            }

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                UPDATE Users SET
                    FullName = @FullName,
                    Email    = @Email,
                    Phone    = @Phone,
                    AddressLine = @AddressLine,
                    Barangay    = @Barangay,
                    ProfileImagePath = COALESCE(@ProfileImagePath, ProfileImagePath)
                WHERE UserId = @UserId", conn)) {
                cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim().ToLowerInvariant());
                cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                cmd.Parameters.AddWithValue("@AddressLine", txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@Barangay", txtBarangay.Text.Trim());
                cmd.Parameters.AddWithValue("@ProfileImagePath", (object)newImagePath ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);

                try {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex) {
                    lblProfileMessage.Text = ex.Number == 2627 || ex.Number == 2601
                        ? "Email ay ginagamit na. Gumamit ng iba."
                        : "Hindi na-save ang profile. Subukan ulit.";
                    return;
                }
            }

            Session["UserName"] = txtFullName.Text.Trim();
            Session["UserEmail"] = txtEmail.Text.Trim();
            lblProfileMessage.Text = "Na-save ang profile!";
            LoadProfile();
        }

        // =============================================
        // CHANGE PASSWORD
        // =============================================
        protected void BtnChangePassword_Click(object sender, EventArgs e) {
            lblPasswordMessage.Text = "";

            string current = txtCurrentPassword.Text.Trim();
            string next = txtNewPassword.Text.Trim();
            string confirm = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(current) || string.IsNullOrEmpty(next)) {
                lblPasswordMessage.Text = "Paki-kumpleto ang password fields."; return;
            }
            if (!string.Equals(next, confirm, StringComparison.Ordinal)) {
                lblPasswordMessage.Text = "Hindi magkatugma ang bagong password."; return;
            }
            if (next.Length < 6) {
                lblPasswordMessage.Text = "Ang password ay dapat hindi bababa sa 6 na karakter."; return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            string stored = "";
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand("SELECT Password FROM Users WHERE UserId = @UserId", conn)) {
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                object result = cmd.ExecuteScalar();
                stored = result != null ? result.ToString() : "";
            }

            if (!string.Equals(current, stored, StringComparison.Ordinal)) {
                lblPasswordMessage.Text = "Mali ang kasalukuyang password."; return;
            }

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand("UPDATE Users SET Password = @Password WHERE UserId = @UserId", conn)) {
                cmd.Parameters.AddWithValue("@Password", next);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            txtCurrentPassword.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";
            lblPasswordMessage.Text = "Na-update ang password!";
        }

        // =============================================
        // HELPERS
        // =============================================
        protected string FormatTags(object tagsObj) {
            return tagsObj == null ? "" : tagsObj.ToString().Replace("|", " • ");
        }

        protected string GetPayLabel(object minObj, object maxObj, object rateObj) {
            return GROUP6_ANGAT.DisplayHelper.GetPayDisplay(minObj, maxObj, rateObj);
        }
        protected string GetBusinessLocation(object addressObj, object barangayObj) {
            string address = addressObj == null ? "" : addressObj.ToString().Trim();
            if (!string.IsNullOrWhiteSpace(address)) {
                return address;
            }

            string barangay = barangayObj == null ? "" : barangayObj.ToString().Trim();
            if (string.IsNullOrWhiteSpace(barangay)) {
                return "Bi\u00f1an";
            }

            return "Brgy. " + barangay + ", Bi\u00f1an";
        }

        protected string GetBusinessContact(object contactObj) {
            string contact = contactObj == null ? "" : contactObj.ToString().Trim();
            return string.IsNullOrWhiteSpace(contact) ? "Walang contact number" : contact;
        }
    }
}

















