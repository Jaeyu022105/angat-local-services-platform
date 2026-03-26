using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
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
                SELECT u.FullName, u.Email, u.Phone, u.AddressLine,
                       b.BarangayName AS Barangay,
                       r.RoleName AS Role,
                       u.ProfileImagePath
                FROM Users u
                LEFT JOIN Barangays b ON u.BarangayId = b.BarangayId
                LEFT JOIN Roles r ON u.RoleId = r.RoleId
                WHERE u.UserId = @UserId", conn)) {
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleRow)) {
                    if (reader.Read()) {
                        string fullName = reader["FullName"].ToString();
                        string email = reader["Email"].ToString();

                        lblProfileName.Text = fullName;
                        lblProfileEmail.Text = string.IsNullOrWhiteSpace(email) ? "Walang email" : email;

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
        private void LoadApplications()
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // Active (Pending + Approved + Rejected)
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT ja.ApplicationId, ja.Status, ja.AppliedAt,
                           j.JobTitle, j.Barangay, j.PayMin, j.PayMax, j.PayRate, j.Tags,
                           u.FullName AS EmployerName, u.Email AS EmployerEmail, u.Phone AS EmployerPhone
                    FROM JobApplications ja
                    LEFT JOIN vwJobs j ON ja.JobId = j.JobId
                    LEFT JOIN Users u ON j.PostedByUserId = u.UserId
                    WHERE ja.UserId = @UserId AND ja.Status IN ('Pending', 'Approved', 'Rejected')
                    AND (ja.Status != 'Retracted' AND ja.Status NOT LIKE '%_Archived')
                    ORDER BY ja.AppliedAt DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        bool hasRows = reader.HasRows;
                        rptApplications.DataSource = reader;
                        rptApplications.DataBind();
                        pnlNoApplications.Visible = !hasRows;
                    }
                }

                // Closed (Retracted + Archived)
                using (SqlCommand cmd = new SqlCommand(@"
            SELECT ja.ApplicationId, ja.Status, ja.AppliedAt,
                   j.JobTitle, j.Barangay, j.PayMin, j.PayMax, j.PayRate, j.Tags
            FROM JobApplications ja
            LEFT JOIN vwJobs j ON ja.JobId = j.JobId
            WHERE ja.UserId = @UserId AND (ja.Status = 'Retracted' OR ja.Status LIKE '%_Archived')
            ORDER BY ja.AppliedAt DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        rptApplicationsClosed.DataSource = reader;
                        rptApplicationsClosed.DataBind();
                    }
                }
            }
        }

        // =============================================
        // LOAD SERVICE REQUESTS (user requested services)
        // =============================================
        private void LoadServiceRequests()
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // Active (Pending + Approved)
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT sr.RequestId, sr.Status, sr.RequestedAt,
                           s.ServiceTitle, s.Barangay, s.RateMin, s.RateMax, s.RateType, s.Tags,
                           u.FullName AS PosterName, u.Email AS PosterEmail, u.Phone AS PosterPhone
                    FROM ServiceRequests sr
                    LEFT JOIN vwServices s ON sr.ServiceId = s.ServiceId
                    LEFT JOIN Users u ON s.PostedByUserId = u.UserId
                    WHERE sr.UserId = @UserId AND sr.Status IN ('Pending', 'Approved', 'Rejected')
                    ORDER BY sr.RequestedAt DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        bool hasRows = reader.HasRows;
                        rptServiceRequests.DataSource = reader;
                        rptServiceRequests.DataBind();
                        pnlNoServiceRequests.Visible = !hasRows;
                    }
                }

                // Closed (Retracted + Archived)
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT sr.RequestId, sr.Status, sr.RequestedAt,
                           s.ServiceTitle, s.Barangay, s.RateMin, s.RateMax, s.RateType, s.Tags
                    FROM ServiceRequests sr
                    LEFT JOIN vwServices s ON sr.ServiceId = s.ServiceId
                    WHERE sr.UserId = @UserId AND (sr.Status = 'Retracted' OR sr.Status LIKE '%_Archived')
                    ORDER BY sr.RequestedAt DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        rptServiceRequestsClosed.DataSource = reader;
                        rptServiceRequestsClosed.DataBind();
                    }
                }
            }
        }

        // =============================================
        // LOAD MY JOB LISTINGS (user posted jobs)
        // =============================================
        private void LoadMyListings()
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // Active listings
                using (SqlCommand cmd = new SqlCommand(@"
            SELECT JobId, JobTitle, Barangay, PayMin, PayMax, PayRate,
                   Tags, Category, Status, PostedAt, Slots, IsActive
            FROM vwJobs
            WHERE PostedByUserId = @UserId AND (IsActive = 1 OR Status = 'Filled')
            ORDER BY PostedAt DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        bool hasRows = reader.HasRows;
                        rptMyListings.DataSource = reader;
                        rptMyListings.DataBind();
                        pnlNoListings.Visible = !hasRows;
                    }
                }

                // Deleted listings
                using (SqlCommand cmd = new SqlCommand(@"
            SELECT JobId, JobTitle, Barangay, PayMin, PayMax, PayRate,
                   Tags, Category, Status, PostedAt, Slots, IsActive
            FROM vwJobs
            WHERE PostedByUserId = @UserId AND IsActive = 0 AND Status != 'Filled'
            ORDER BY PostedAt DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        rptMyListingsDeleted.DataSource = reader;
                        rptMyListingsDeleted.DataBind();
                    }
                }
            }
        }

        // =============================================
        // LOAD MY SERVICE LISTINGS (user posted services)
        // =============================================
        private void LoadMyServiceListings()
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // Active listings
                using (SqlCommand cmd = new SqlCommand(@"
            SELECT ServiceId, ServiceTitle, Barangay, RateMin, RateMax, RateType,
                   Tags, Category, Status, PostedAt, IsActive
            FROM vwServices
            WHERE PostedByUserId = @UserId AND IsActive = 1
            ORDER BY PostedAt DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        bool hasRows = reader.HasRows;
                        rptServiceListings.DataSource = reader;
                        rptServiceListings.DataBind();
                        pnlNoServiceListings.Visible = !hasRows;
                    }
                }

                // Deleted listings
                using (SqlCommand cmd = new SqlCommand(@"
            SELECT ServiceId, ServiceTitle, Barangay, RateMin, RateMax, RateType,
                   Tags, Category, Status, PostedAt, IsActive
            FROM vwServices
            WHERE PostedByUserId = @UserId AND IsActive = 0
            ORDER BY PostedAt DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        rptServiceListingsDeleted.DataSource = reader;
                        rptServiceListingsDeleted.DataBind();
                    }
                }
            }
        }

        // =============================================
        // LOAD MY BUSINESS LISTINGS (user posted negosyo)
        // =============================================
        private void LoadMyBusinessListings()
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // Active listings
                using (SqlCommand cmd = new SqlCommand(@"
            SELECT NegosyoId, BusinessName, Category, Barangay, AddressLine,
                   Tags, Status, CreatedAt, ContactNumber
            FROM vwNegosyo
            WHERE UserId = @UserId AND IsActive = 1
            ORDER BY CreatedAt DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        bool hasRows = reader.HasRows;
                        rptBusinessListings.DataSource = reader;
                        rptBusinessListings.DataBind();
                        pnlNoBusinessListings.Visible = !hasRows;
                    }
                }

                // Deleted listings
                using (SqlCommand cmd = new SqlCommand(@"
            SELECT NegosyoId, BusinessName, Category, Barangay, AddressLine,
                   Tags, Status, CreatedAt, ContactNumber
            FROM vwNegosyo
            WHERE UserId = @UserId AND IsActive = 0
            ORDER BY CreatedAt DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        rptBusinessListingsDeleted.DataSource = reader;
                        rptBusinessListingsDeleted.DataBind();
                    }
                }
            }
        }
        // =============================================
        // ITEM DATA BOUND - load nested applicants
        // =============================================
        protected void RptMyListings_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item &&
                e.Item.ItemType != ListItemType.AlternatingItem) return;

            System.Data.Common.DbDataRecord row =
                (System.Data.Common.DbDataRecord)e.Item.DataItem;

            bool isActive = Convert.ToBoolean(row["IsActive"]);

            LinkButton btnDelete = (LinkButton)e.Item.FindControl("btnDeleteListing");
            btnDelete.Visible = isActive;

            Literal litStatus = (Literal)e.Item.FindControl("litStatus");
            if (litStatus != null)
            {
                if (!isActive && row["Status"].ToString() == "Filled")
                    litStatus.Text = "<span class=\"app-status filled\">Filled</span>";
                else if (!isActive)
                    litStatus.Text = "<span class=\"app-status deleted\">Deleted</span>";
                else
                    litStatus.Text = "<span class=\"app-status " + row["Status"].ToString().ToLower() + "\">" + row["Status"].ToString() + "</span>";
            }
            var hf = (HiddenField)e.Item.FindControl("hfListingJobId");
            var rptApplicants = (Repeater)e.Item.FindControl("rptApplicants");
            var pnlNoApplicants = (Panel)e.Item.FindControl("pnlNoApplicants");
            int jobId;
            if (hf != null && int.TryParse(hf.Value, out jobId))
                LoadApplicants(jobId, rptApplicants, pnlNoApplicants);
        }
        // ========================================================================
        // ITEM DATA BOUND - For service listings, load nested requesters
        // ========================================================================
        protected void RptServiceListings_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item &&
                e.Item.ItemType != ListItemType.AlternatingItem) return;

            System.Data.Common.DbDataRecord row =
                (System.Data.Common.DbDataRecord)e.Item.DataItem;

            bool isActive = Convert.ToBoolean(row["IsActive"]);

            LinkButton btnDelete = (LinkButton)e.Item.FindControl("btnDeleteServiceListing");
            if (btnDelete != null) btnDelete.Visible = isActive;

            Literal litStatus = (Literal)e.Item.FindControl("litServiceStatus");
            if (litStatus != null)
            {
                if (!isActive)
                    litStatus.Text = "<span class=\"app-status deleted\">Deleted</span>";
                else
                    litStatus.Text = "<span class=\"app-status " + row["Status"].ToString().ToLower() + "\">" + row["Status"].ToString() + "</span>";
            }

            var hf = (HiddenField)e.Item.FindControl("hfListingServiceId");
            var rptServiceApplicants = (Repeater)e.Item.FindControl("rptServiceApplicants");
            var pnlNoServiceApplicants = (Panel)e.Item.FindControl("pnlNoServiceApplicants");
            var pnlApplicantsBlock = (Panel)e.Item.FindControl("pnlApplicantsBlock");

            int serviceId;
            if (hf != null && int.TryParse(hf.Value, out serviceId))
                LoadServiceApplicants(serviceId, rptServiceApplicants, pnlNoServiceApplicants);

            if (pnlApplicantsBlock != null)
                pnlApplicantsBlock.Visible = rptServiceApplicants.Items.Count > 0;
        }
        private void LoadApplicants(int jobId, Repeater rpt, System.Web.UI.WebControls.Panel pnlEmpty)
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
            SELECT ja.ApplicationId, ja.Status, ja.AppliedAt,
                   u.FullName, u.Email, u.Phone
            FROM JobApplications ja
            INNER JOIN Users u ON ja.UserId = u.UserId
            INNER JOIN Jobs j ON ja.JobId = j.JobId
            WHERE ja.JobId = @JobId
            AND (
                (j.Status != 'Filled' AND ja.Status IN ('Pending', 'Approved'))
                OR
                (j.Status = 'Filled' AND ja.Status = 'Approved')
            )
            ORDER BY ja.AppliedAt DESC", conn))
            {
                cmd.Parameters.AddWithValue("@JobId", jobId);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    bool hasRows = reader.HasRows;
                    rpt.DataSource = reader;
                    rpt.DataBind();
                    pnlEmpty.Visible = !hasRows;
                }
            }
        }

        private void LoadServiceApplicants(int serviceId, Repeater rpt, System.Web.UI.WebControls.Panel pnlEmpty)
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT sr.RequestId, sr.Status, sr.RequestedAt,
                        u.FullName, u.Email, u.Phone
                FROM ServiceRequests sr
                INNER JOIN Users u ON sr.UserId = u.UserId
                WHERE sr.ServiceId = @ServiceId
                AND sr.Status IN ('Pending', 'Approved')
                ORDER BY sr.RequestedAt DESC", conn))
            {
                cmd.Parameters.AddWithValue("@ServiceId", serviceId);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
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

            pnlApplicationsMessage.Visible = false;
            pnlServiceMessage.Visible = false;
            pnlBusinessMessage.Visible = false;

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            int rows = 0;
            //notifs
            int targetUserId = 0;
            string jobTitle = "";


            using (SqlConnection conn = new SqlConnection(connString)) {
                conn.Open();
                //notifs
                using (SqlCommand infoCmd = new SqlCommand(@"SELECT TOP 1 ja.UserId, j.JobTitle FROM JobApplications ja INNER JOIN Jobs j ON ja.JobId = j.JobId WHERE ja.ApplicationId = @ApplicationId AND j.PostedByUserId = @UserId", conn))
                {
                    infoCmd.Parameters.AddWithValue("@ApplicationId", e.CommandArgument);
                    infoCmd.Parameters.AddWithValue("@UserId", Session["UserId"]);

                    using (SqlDataReader reader = infoCmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            targetUserId = Convert.ToInt32(reader["UserId"]);
                            jobTitle = reader["JobTitle"].ToString();
                        }
                    }
                }



                // Update application status
                using (SqlCommand cmd = new SqlCommand(@"
                UPDATE JobApplications SET Status = 
                    CASE 
                        WHEN Status LIKE '%_Archived' THEN @Status + '_Archived'
                        ELSE @Status 
                    END
                WHERE ApplicationId = @ApplicationId
                AND JobId IN (SELECT JobId FROM Jobs WHERE PostedByUserId = @UserId)", conn))
                {
                    cmd.Parameters.AddWithValue("@Status", newStatus);
                    cmd.Parameters.AddWithValue("@ApplicationId", e.CommandArgument);
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    rows = cmd.ExecuteNonQuery();
                }
                // Check if slots are still available before approving
                if (newStatus == "Approved")
                {
                    using (SqlCommand slotsCheck = new SqlCommand(@"
                SELECT Slots FROM Jobs 
                WHERE JobId IN (SELECT JobId FROM JobApplications WHERE ApplicationId = @ApplicationId)
                AND PostedByUserId = @UserId", conn))
                    {
                        slotsCheck.Parameters.AddWithValue("@ApplicationId", e.CommandArgument);
                        slotsCheck.Parameters.AddWithValue("@UserId", Session["UserId"]);
                        int slots = Convert.ToInt32(slotsCheck.ExecuteScalar());
                        if (slots <= 0)
                        {
                            pnlApplicationsMessage.Visible = true;
                            pnlApplicationsMessage.CssClass = "form-alert error";
                            lblApplicationsMessage.Text = "Puno na ang slots para sa trabahong ito.";
                            return;
                        }
                    }
                }
                // If approved, decrease slots — keep card visible but mark as Filled when full
                if (newStatus == "Approved" && rows > 0)
                {
                    using (SqlCommand slotsCmd = new SqlCommand(@"
                    UPDATE Jobs
                    SET Slots = Slots - 1,
                        Status = CASE WHEN Slots - 1 <= 0 THEN 'Filled' ELSE Status END
                    WHERE JobId IN (
                        SELECT JobId FROM JobApplications WHERE ApplicationId = @ApplicationId
                    )
                    AND PostedByUserId = @UserId", conn))
                    {
                        slotsCmd.Parameters.AddWithValue("@ApplicationId", e.CommandArgument);
                        slotsCmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                        slotsCmd.ExecuteNonQuery();
                    }
                }
                //notifs
                if (rows > 0 && targetUserId > 0)
                {
                    GROUP6_ANGAT.NotificationHelper.TryCreateNotification(
                        conn,
                        targetUserId,
                        newStatus == "Approved" ? "Na-approve ang job application" : "Na-reject ang job application",
                        newStatus == "Approved"
                            ? string.Format("Na-approve ang application mo para sa \"{0}\".", jobTitle)
                            : string.Format("Na-reject ang application mo para sa \"{0}\".", jobTitle),
                        newStatus == "Approved" ? "job_application_approved" : "job_application_rejected",
                        string.Format("~/Pages/Profile.aspx?tab=applications&applicationId={0}", e.CommandArgument));
                }

            }

            pnlApplicationsMessage.Visible = true;
            pnlApplicationsMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
            lblApplicationsMessage.Text = rows > 0 ? "Na-update ang status ng applicant." : "Hindi ma-update ang status.";

            LoadMyListings();

            ScriptManager.RegisterStartupScript(this, GetType(), "StayTab",
                "document.querySelector('[data-tab=\"listings\"]').click();", true);
        }

        // =============================================
        // APPROVE / REJECT SERVICE REQUESTS
        // =============================================
        protected void RptServiceApplicants_ItemCommand(object source, RepeaterCommandEventArgs e) {
            string newStatus = null;
            if (e.CommandName == "ApproveService") newStatus = "Approved";
            else if (e.CommandName == "RejectService") newStatus = "Rejected";
            else return;

            pnlApplicationsMessage.Visible = false;
            pnlServiceMessage.Visible = false;
            pnlBusinessMessage.Visible = false;

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            int rows = 0;
            //notifs
            int targetUserId = 0;
            string serviceTitle = "";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                //notifs
                using (SqlCommand infoCmd = new SqlCommand(@"
                SELECT TOP 1 sr.UserId, s.ServiceTitle
                FROM ServiceRequests sr
                INNER JOIN Services s ON sr.ServiceId = s.ServiceId
                WHERE sr.RequestId = @RequestId
                AND s.PostedByUserId = @UserId", conn)) {
                    infoCmd.Parameters.AddWithValue("@RequestId", e.CommandArgument);
                    infoCmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    using (SqlDataReader reader = infoCmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            targetUserId = Convert.ToInt32(reader["UserId"]);
                            serviceTitle = reader["ServiceTitle"].ToString();
                        }
                    }
                }

                using (SqlCommand cmd = new SqlCommand(@"
                UPDATE ServiceRequests SET Status = @Status
                WHERE RequestId = @RequestId
                AND ServiceId IN (SELECT ServiceId FROM Services WHERE PostedByUserId = @UserId)", conn))
                {
                    cmd.Parameters.AddWithValue("@Status", newStatus);
                    cmd.Parameters.AddWithValue("@RequestId", e.CommandArgument);
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    
                    rows = cmd.ExecuteNonQuery();
                }
                //notifs
                if (rows > 0 && targetUserId > 0)
                {
                    GROUP6_ANGAT.NotificationHelper.TryCreateNotification(
                        conn,
                        targetUserId,
                        newStatus == "Approved" ? "Na-approve ang service request" : "Na-reject ang service request",
                        newStatus == "Approved"
                            ? string.Format("Na-approve ang request mo para sa \"{0}\".", serviceTitle)
                            : string.Format("Na-reject ang request mo para sa \"{0}\".", serviceTitle),
                        newStatus == "Approved" ? "service_request_approved" : "service_request_rejected",
                        string.Format("~/Pages/Profile.aspx?tab=requests&requestId={0}", e.CommandArgument));

                }
            }
            pnlServiceMessage.Visible = true;
            pnlServiceMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
            lblServiceMessage.Text = rows > 0 ? "Na-update ang status ng requester." : "Hindi ma-update ang status.";

            LoadMyServiceListings();

            ScriptManager.RegisterStartupScript(this, GetType(), "StayTab",
                "document.querySelector('[data-tab=\"servicelistings\"]').click();", true);
        }

        // =============================================
        // DELETE JOB LISTING
        // =============================================
     protected void RptMyListings_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "DeleteListing") return;

            if (!int.TryParse(e.CommandArgument.ToString(), out int jobId))
                return;

            if (Session["UserId"] == null) return;

            if (!int.TryParse(Session["UserId"].ToString(), out int userId))
                return;

            pnlApplicationsMessage.Visible = false;
            pnlServiceMessage.Visible = false;
            pnlBusinessMessage.Visible = false;

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
        UPDATE Jobs SET IsActive = 0
        WHERE JobId = @JobId AND PostedByUserId = @UserId", conn))
            {
                cmd.Parameters.Add("@JobId", SqlDbType.Int).Value = jobId;
                cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = userId;

                conn.Open();
                int rows = cmd.ExecuteNonQuery();

                pnlApplicationsMessage.Visible = true;
                pnlApplicationsMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
                lblApplicationsMessage.Text = rows > 0 ? "Na-delete ang listing." : "Hindi ma-delete ang listing.";
            }

            LoadMyListings();

            ScriptManager.RegisterStartupScript(this, GetType(), "StayTab",
                "document.querySelector('[data-tab=\"listings\"]').click();", true);
        }

        // =============================================
        // DELETE SERVICE LISTING
        // =============================================
        protected void RptServiceListings_ItemCommand(object source, RepeaterCommandEventArgs e) {
            if (e.CommandName != "DeleteServiceListing") return;

            pnlApplicationsMessage.Visible = false;
            pnlServiceMessage.Visible = false;
            pnlBusinessMessage.Visible = false;

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

            ScriptManager.RegisterStartupScript(this, GetType(), "StayTab",
                "document.querySelector('[data-tab=\"servicelistings\"]').click();", true);
        }

        // =============================================
        // DELETE BUSINESS LISTING
        // =============================================
        protected void RptBusinessListings_ItemCommand(object source, RepeaterCommandEventArgs e) {
            if (e.CommandName != "DeleteBusinessListing") return;

            pnlApplicationsMessage.Visible = false;
            pnlServiceMessage.Visible = false;
            pnlBusinessMessage.Visible = false;

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                UPDATE Negosyo SET IsActive = 0
                WHERE NegosyoId = @NegosyoId AND UserId = @UserId", conn)) {
                cmd.Parameters.AddWithValue("@NegosyoId", e.CommandArgument);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();

                pnlBusinessMessage.Visible = true;
                pnlBusinessMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
                lblBusinessMessage.Text = rows > 0 ? "Na-delete ang negosyo listing." : "Hindi ma-delete ang listing.";
            }

            LoadMyBusinessListings();

            ScriptManager.RegisterStartupScript(this, GetType(), "StayTab",
                "document.querySelector('[data-tab=\"businesslistings\"]').click();", true);
        }
        // =============================================
        // RETRACT APPLICATION
        // =============================================
        protected void RptApplications_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            pnlApplicationsMessage.Visible = false;
            pnlServiceMessage.Visible = false;
            pnlBusinessMessage.Visible = false;

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            string newStatus = null;

            if (e.CommandName == "Retract") newStatus = "Retracted";
            else if (e.CommandName == "Archive") newStatus = e.CommandName; // handled below
            else return;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                if (e.CommandName == "Archive")
                {
                    // Get current status first
                    string currentStatus = "";
                    using (SqlCommand getCmd = new SqlCommand(@"
                SELECT Status FROM JobApplications 
                WHERE ApplicationId = @ApplicationId AND UserId = @UserId", conn))
                    {
                        getCmd.Parameters.AddWithValue("@ApplicationId", e.CommandArgument);
                        getCmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                        currentStatus = getCmd.ExecuteScalar()?.ToString() ?? "";
                    }
                    newStatus = currentStatus + "_Archived";
                }

                using (SqlCommand cmd = new SqlCommand(@"
            UPDATE JobApplications SET Status = @Status
            WHERE ApplicationId = @ApplicationId AND UserId = @UserId", conn))
                {
                    cmd.Parameters.AddWithValue("@Status", newStatus);
                    cmd.Parameters.AddWithValue("@ApplicationId", e.CommandArgument);
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    int rows = cmd.ExecuteNonQuery();

                    pnlApplicationsMessage.Visible = true;
                    pnlApplicationsMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
                    lblApplicationsMessage.Text = rows > 0
                        ? (e.CommandName == "Archive" ? "Na-archive ang application." : "Na-retract ang application.")
                        : "Hindi ma-update. Subukan ulit.";
                }
            }

            LoadApplications();
            ScriptManager.RegisterStartupScript(this, GetType(), "StayTab",
                "document.querySelector('[data-tab=\"applications\"]').click();", true);
        }

        // =============================================
        // RETRACT SERVICE REQUEST
        // =============================================
        protected void RptServiceRequests_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            pnlApplicationsMessage.Visible = false;
            pnlServiceMessage.Visible = false;
            pnlBusinessMessage.Visible = false;

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            if (e.CommandName == "RetractService")
            {
                using (SqlConnection conn = new SqlConnection(connString))
                using (SqlCommand cmd = new SqlCommand(@"
            UPDATE ServiceRequests SET Status = 'Retracted'
            WHERE RequestId = @RequestId AND UserId = @UserId AND Status = 'Pending'", conn))
                {
                    cmd.Parameters.AddWithValue("@RequestId", e.CommandArgument);
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    conn.Open();
                    int rows = cmd.ExecuteNonQuery();
                    pnlServiceMessage.Visible = true;
                    pnlServiceMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
                    lblServiceMessage.Text = rows > 0 ? "Na-retract ang request." : "Hindi ma-retract.";
                }
            }
            else if (e.CommandName == "ArchiveService")
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string currentStatus = "";
                    using (SqlCommand getCmd = new SqlCommand(@"
                SELECT Status FROM ServiceRequests 
                WHERE RequestId = @RequestId AND UserId = @UserId", conn))
                    {
                        getCmd.Parameters.AddWithValue("@RequestId", e.CommandArgument);
                        getCmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                        currentStatus = getCmd.ExecuteScalar()?.ToString() ?? "";
                    }
                    string newStatus = currentStatus + "_Archived";
                    using (SqlCommand cmd = new SqlCommand(@"
                UPDATE ServiceRequests SET Status = @Status
                WHERE RequestId = @RequestId AND UserId = @UserId", conn))
                    {
                        cmd.Parameters.AddWithValue("@Status", newStatus);
                        cmd.Parameters.AddWithValue("@RequestId", e.CommandArgument);
                        cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                        int rows = cmd.ExecuteNonQuery();
                        pnlServiceMessage.Visible = true;
                        pnlServiceMessage.CssClass = rows > 0 ? "form-alert success" : "form-alert error";
                        lblServiceMessage.Text = rows > 0 ? "Na-archive ang request." : "Hindi ma-archive.";
                    }
                }
            }
            else return;

            LoadServiceRequests();
            ScriptManager.RegisterStartupScript(this, GetType(), "StayTab",
                "document.querySelector('[data-tab=\"requests\"]').click();", true);
        }

        // =============================================
        // SAVE PROFILE + PHOTO
        // =============================================
        protected void BtnSaveProfile_Click(object sender, EventArgs e) {
            lblProfileMessage.Text = "";

            pnlApplicationsMessage.Visible = false;
            pnlServiceMessage.Visible = false;
            pnlBusinessMessage.Visible = false;

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

            using (SqlConnection conn = new SqlConnection(connString)) {
                try {
                    conn.Open();
                    int barangayId = DbLookupHelper.EnsureBarangayId(conn, null, txtBarangay.Text.Trim());

                    using (SqlCommand cmd = new SqlCommand(@"
                UPDATE Users SET
                    FullName = @FullName,
                    Email    = @Email,
                    Phone    = @Phone,
                    AddressLine = @AddressLine,
                    BarangayId  = @BarangayId,
                    ProfileImagePath = COALESCE(@ProfileImagePath, ProfileImagePath)
                WHERE UserId = @UserId", conn)) {
                        cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim().ToLowerInvariant());
                        cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                        cmd.Parameters.AddWithValue("@AddressLine", txtAddress.Text.Trim());
                        cmd.Parameters.AddWithValue("@BarangayId", barangayId);
                        cmd.Parameters.AddWithValue("@ProfileImagePath", (object)newImagePath ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);

                        cmd.ExecuteNonQuery();
                    }
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

            ScriptManager.RegisterStartupScript(this, GetType(), "StayTabListings",
            "document.querySelector('[data-tab=\"listings\"]').click();", true);
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

            pnlApplicationsMessage.Visible = false;
            pnlServiceMessage.Visible = false;
            pnlBusinessMessage.Visible = false;

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

            ScriptManager.RegisterStartupScript(this, GetType(), "StayTabListings",
            "document.querySelector('[data-tab=\"listings\"]').click();", true);
        }

        // =============================================
        // HELPERS
        // =============================================
        protected string FormatTags(object tagsObj) {
            return tagsObj == null ? "" : tagsObj.ToString().Replace("|", " \u2022 ");
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
