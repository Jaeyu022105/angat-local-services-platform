using System;
using System.Configuration;
using System.Data.SqlClient;

namespace GROUP6_ANGAT
{
    public partial class PostJob : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx?returnUrl=/Pages/PostJob.aspx");
                return;
            }
        }

        protected void BtnPostJob_Click(object sender, EventArgs e)
        {
            string title = txtJobTitle.Text.Trim();
            string category = ddlCategory.SelectedValue;
            string location = txtJobLocation.Text.Trim();
            string barangay = txtBarangay.Text.Trim();
            string minPay = txtPayMin.Text.Trim();
            string maxPay = txtPayMax.Text.Trim();
            string payUnit = ddlPayUnit.SelectedValue;
            string pay = BuildPay(minPay, maxPay, payUnit);
            string tags = txtJobTags.Text.Trim();
            string status = ddlStatus.SelectedValue;
            string dateLabel = string.IsNullOrWhiteSpace(txtDateLabel.Text) ? "Ngayon" : txtDateLabel.Text.Trim();
            string description = txtJobDescription.Text.Trim();

            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(location) || string.IsNullOrEmpty(barangay))
            {
                pnlPostMessage.Visible = true;
                pnlPostMessage.CssClass = "form-alert error";
                lblPostMessage.Text = "Paki-kumpleto ang Job Title, Location, at Barangay.";
                return;
            }
            if (string.IsNullOrEmpty(pay))
            {
                pnlPostMessage.Visible = true;
                pnlPostMessage.CssClass = "form-alert error";
                lblPostMessage.Text = "Paki-kumpleto ang Pay range.";
                return;
            }

            string iconClass;
            string iconBg;
            string iconColor;
            GetCategoryIcon(category, out iconClass, out iconBg, out iconColor);

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"INSERT INTO Jobs
                                                     (JobTitle, JobLocation, Barangay, JobPay, JobTags, JobDescription, Status, DateLabel,
                                                      IconClass, IconBg, IconColor, Category, PostedByUserId, IsActive, PostedAt)
                                                     VALUES (@JobTitle, @JobLocation, @Barangay, @JobPay, @JobTags, @JobDescription, @Status, @DateLabel,
                                                             @IconClass, @IconBg, @IconColor, @Category, @PostedByUserId, 1, GETDATE())", conn))
            {
                cmd.Parameters.AddWithValue("@JobTitle", title);
                cmd.Parameters.AddWithValue("@JobLocation", location);
                cmd.Parameters.AddWithValue("@Barangay", barangay);
                cmd.Parameters.AddWithValue("@JobPay", pay);
                cmd.Parameters.AddWithValue("@JobTags", tags);
                cmd.Parameters.AddWithValue("@JobDescription", description);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@DateLabel", dateLabel);
                cmd.Parameters.AddWithValue("@IconClass", iconClass);
                cmd.Parameters.AddWithValue("@IconBg", iconBg);
                cmd.Parameters.AddWithValue("@IconColor", iconColor);
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.Parameters.AddWithValue("@PostedByUserId", Session["UserId"]);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            pnlPostMessage.Visible = true;
            pnlPostMessage.CssClass = "form-alert success";
            lblPostMessage.Text = "Naipost na ang trabaho! Makikita ito sa Hanap Trabaho.";

            txtJobTitle.Text = "";
            txtJobLocation.Text = "";
            txtBarangay.Text = "";
            txtPayMin.Text = "";
            txtPayMax.Text = "";
            txtJobTags.Text = "";
            txtDateLabel.Text = "";
            txtJobDescription.Text = "";
        }

        private string BuildPay(string min, string max, string unit)
        {
            string cleanMin = CleanNumber(min);
            string cleanMax = CleanNumber(max);
            if (string.IsNullOrEmpty(cleanMin) || string.IsNullOrEmpty(cleanMax))
            {
                return "";
            }

            return "₱" + cleanMin + "–₱" + cleanMax + " " + unit;
        }

        private string CleanNumber(string raw)
        {
            if (string.IsNullOrWhiteSpace(raw))
            {
                return "";
            }

            var chars = raw.ToCharArray();
            var digits = new System.Text.StringBuilder();
            for (int i = 0; i < chars.Length; i++)
            {
                if (char.IsDigit(chars[i]))
                {
                    digits.Append(chars[i]);
                }
            }

            if (digits.Length == 0)
            {
                return "";
            }

            if (long.TryParse(digits.ToString(), out long value))
            {
                return value.ToString("N0");
            }

            return digits.ToString();
        }

        private void GetCategoryIcon(string category, out string iconClass, out string iconBg, out string iconColor)
        {
            switch ((category ?? "").ToLowerInvariant())
            {
                case "household":
                    iconClass = "bx bx-home-heart";
                    iconBg = "#e6f7f1";
                    iconColor = "#0d9e6e";
                    break;
                case "driver":
                    iconClass = "bx bx-car";
                    iconBg = "#ccfbf1";
                    iconColor = "#14b8a6";
                    break;
                case "laundry":
                    iconClass = "bx bx-water";
                    iconBg = "#ffe4e6";
                    iconColor = "#be123c";
                    break;
                case "retail":
                    iconClass = "bx bx-store-alt";
                    iconBg = "#ede9fe";
                    iconColor = "#6d28d9";
                    break;
                case "food":
                    iconClass = "bx bx-restaurant";
                    iconBg = "#fef3c7";
                    iconColor = "#b45309";
                    break;
                case "warehouse":
                    iconClass = "bx bx-package";
                    iconBg = "#dbeafe";
                    iconColor = "#1d4ed8";
                    break;
                default:
                    iconClass = "bx bx-briefcase";
                    iconBg = "#e6f7f1";
                    iconColor = "#0d9e6e";
                    break;
            }
        }
    }
}
