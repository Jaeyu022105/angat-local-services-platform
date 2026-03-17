using System;
using System.Configuration;
using System.Data.SqlClient;

namespace GROUP6_ANGAT
{
    public partial class PostService : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx?returnUrl=/Pages/PostService.aspx");
                return;
            }
        }

        protected void BtnPostService_Click(object sender, EventArgs e)
        {
            string title = txtServiceTitle.Text.Trim();
            string category = ddlCategory.SelectedValue;
            string location = txtServiceLocation.Text.Trim();
            string barangay = txtBarangay.Text.Trim();
            string minRate = txtRateMin.Text.Trim();
            string maxRate = txtRateMax.Text.Trim();
            string rateUnit = ddlRateUnit.SelectedValue;
            string rate = BuildRate(minRate, maxRate, rateUnit);
            string tags = txtServiceTags.Text.Trim();
            string status = ddlStatus.SelectedValue;
            string dateLabel = string.IsNullOrWhiteSpace(txtDateLabel.Text) ? "Ngayon" : txtDateLabel.Text.Trim();
            string description = txtServiceDescription.Text.Trim();

            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(location) || string.IsNullOrEmpty(barangay))
            {
                pnlPostMessage.Visible = true;
                pnlPostMessage.CssClass = "form-alert error";
                lblPostMessage.Text = "Paki-kumpleto ang Service Title, Location, at Barangay.";
                return;
            }
            if (string.IsNullOrEmpty(rate))
            {
                pnlPostMessage.Visible = true;
                pnlPostMessage.CssClass = "form-alert error";
                lblPostMessage.Text = "Paki-kumpleto ang Rate range.";
                return;
            }

            string iconClass;
            string iconBg;
            string iconColor;
            GetCategoryIcon(category, out iconClass, out iconBg, out iconColor);

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"INSERT INTO Services
                                                     (ServiceTitle, ServiceLocation, Barangay, ServiceRate, ServiceTags, ServiceDescription, Status, DateLabel,
                                                      IconClass, IconBg, IconColor, Category, PostedByUserId, IsActive, PostedAt)
                                                     VALUES (@ServiceTitle, @ServiceLocation, @Barangay, @ServiceRate, @ServiceTags, @ServiceDescription, @Status, @DateLabel,
                                                             @IconClass, @IconBg, @IconColor, @Category, @PostedByUserId, 1, GETDATE())", conn))
            {
                cmd.Parameters.AddWithValue("@ServiceTitle", title);
                cmd.Parameters.AddWithValue("@ServiceLocation", location);
                cmd.Parameters.AddWithValue("@Barangay", barangay);
                cmd.Parameters.AddWithValue("@ServiceRate", rate);
                cmd.Parameters.AddWithValue("@ServiceTags", tags);
                cmd.Parameters.AddWithValue("@ServiceDescription", description);
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
            lblPostMessage.Text = "Naipost na ang serbisyo! Makikita ito sa Hanap Gawa.";

            txtServiceTitle.Text = "";
            txtServiceLocation.Text = "";
            txtBarangay.Text = "";
            txtRateMin.Text = "";
            txtRateMax.Text = "";
            txtServiceTags.Text = "";
            txtDateLabel.Text = "";
            txtServiceDescription.Text = "";
        }

        private string BuildRate(string min, string max, string unit)
        {
            string cleanMin = CleanNumber(min);
            string cleanMax = CleanNumber(max);
            if (string.IsNullOrEmpty(cleanMin) || string.IsNullOrEmpty(cleanMax))
            {
                return "";
            }

            return "\u20B1" + cleanMin + "-" + "\u20B1" + cleanMax + " " + unit;
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
                case "karpintero":
                    iconClass = "bx bx-hammer";
                    iconBg = "#fef3c7";
                    iconColor = "#b45309";
                    break;
                case "tubero":
                    iconClass = "bx bx-wrench";
                    iconBg = "#dbeafe";
                    iconColor = "#1d4ed8";
                    break;
                case "electrician":
                    iconClass = "bx bx-bolt";
                    iconBg = "#e0f2fe";
                    iconColor = "#0284c7";
                    break;
                case "aircon":
                    iconClass = "bx bx-wind";
                    iconBg = "#ccfbf1";
                    iconColor = "#14b8a6";
                    break;
                case "mananahi":
                    iconClass = "bx bx-scissors";
                    iconBg = "#ffe4e6";
                    iconColor = "#be123c";
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
