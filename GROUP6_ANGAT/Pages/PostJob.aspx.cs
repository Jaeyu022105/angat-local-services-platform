using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace GROUP6_ANGAT {
    public partial class PostJob : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (Session["UserId"] == null) {
                Response.Redirect("~/Pages/Login.aspx?returnUrl=/Pages/PostJob.aspx");
                return;
            }
        }

        protected void BtnPostJob_Click(object sender, EventArgs e) {

            int slots = 1;
            int.TryParse(txtSlots.Text, out slots);
            if (slots < 1) slots = 1;
            if (slots > 10) slots = 10;

            string title = CleanTitle(txtJobTitle.Text);
            string category = ddlCategory.SelectedValue;
            string barangay = ddlBarangay.SelectedValue;
            string payRate = ddlPayRate.SelectedValue;
            string tags = hfTags.Value;
            string status = ddlStatus.SelectedValue;
            string description = CleanDescription(txtJobDescription.Text);

            // Validation
            if (string.IsNullOrEmpty(title)) {
                ShowMessage("error", "Pakiusap ilagay ang Job Title."); return;
            }
            if (string.IsNullOrEmpty(category)) {
                ShowMessage("error", "Pakiusap pumili ng Kategorya."); return;
            }
            if (string.IsNullOrEmpty(barangay)) {
                ShowMessage("error", "Pakiusap pumili ng Barangay."); return;
            }
            if (string.IsNullOrEmpty(description)) {
                ShowMessage("error", "Pakiusap ilagay ang Detalye ng trabaho."); return;
            }

            decimal payMin = ParseDecimal(txtPayMin.Text);
            decimal payMax = ParseDecimal(txtPayMax.Text);

            if (payMin <= 0 || payMax <= 0) {
                ShowMessage("error", "Pakiusap ilagay ang Sahod."); return;
            }

            if (payMin > payMax) {
                ShowMessage("error", "Ang minimum na sahod ay hindi dapat mas mataas sa maximum."); return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                INSERT INTO Jobs
                (JobTitle, JobDescription, Category, Barangay, PayMin, PayMax, PayRate, Tags, Status, Slots, IsActive, PostedAt, PostedByUserId)
                VALUES
                (@JobTitle, @JobDescription, @Category, @Barangay, @PayMin, @PayMax, @PayRate, @Tags, @Status, @Slots, 1, GETDATE(), @PostedByUserId)", conn)) {
                cmd.Parameters.AddWithValue("@JobTitle", title);
                cmd.Parameters.AddWithValue("@JobDescription", description);
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.Parameters.AddWithValue("@Barangay", barangay);
                cmd.Parameters.AddWithValue("@PayMin", payMin);
                cmd.Parameters.AddWithValue("@PayMax", payMax);
                cmd.Parameters.AddWithValue("@PayRate", payRate);
                cmd.Parameters.AddWithValue("@Tags", tags);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@Slots", slots);
                cmd.Parameters.AddWithValue("@PostedByUserId", Session["UserId"]);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            ShowMessage("success", "Naipost na ang trabaho! Makikita ito sa Hanap Trabaho.");
            ClearForm();
            txtSlots.Text = "1";
        }

        private string CleanTitle(string input) {
            if (string.IsNullOrWhiteSpace(input)) return "";
            input = input.Trim();
            input = Regex.Replace(input, @"\s+", " ");
            input = Regex.Replace(input, @"[^\w\s\-\.\,\/]", "");
            return System.Globalization.CultureInfo.CurrentCulture
                .TextInfo.ToTitleCase(input.ToLower());
        }

        private string CleanDescription(string input) {
            if (string.IsNullOrWhiteSpace(input)) return "";
            input = input.Trim();
            input = Regex.Replace(input, @"<[^>]*>", "");
            if (input.Length > 500) input = input.Substring(0, 500);
            return input;
        }

        private decimal ParseDecimal(string input) {
            if (string.IsNullOrWhiteSpace(input)) return 0;
            string cleaned = Regex.Replace(input, @"[^\d\.]", "");
            return decimal.TryParse(cleaned, out decimal result) ? result : 0;
        }

        private void ShowMessage(string type, string message) {
            pnlPostMessage.Visible = true;
            pnlPostMessage.CssClass = $"form-alert {type}";
            lblPostMessage.Text = message;
        }

        private void ClearForm() {
            txtJobTitle.Text = "";
            txtPayMin.Text = "";
            txtPayMax.Text = "";
            txtJobDescription.Text = "";
            ddlCategory.SelectedIndex = 0;
            ddlBarangay.SelectedIndex = 0;
            ddlStatus.SelectedIndex = 0;
            hfTags.Value = "";
        }
    }
}