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

            // ── SANITIZE INPUTS ──
            string title = CleanTitle(txtJobTitle.Text);
            string category = SanitizeText(ddlCategory.SelectedValue, maxLength: 60);
            string barangay = SanitizeText(ddlBarangay.SelectedValue, maxLength: 60);
            string payRate = SanitizeText(ddlPayRate.SelectedValue, maxLength: 30);
            string tags = SanitizeText(hfTags.Value, maxLength: 300);
            string description = CleanDescription(txtJobDescription.Text);

            int slots = 1;
            int.TryParse(txtSlots.Text, out slots);
            if (slots < 1) slots = 1;
            if (slots > 10) slots = 10;

            // ── VALIDATION ──
            if (string.IsNullOrEmpty(title)) {
                ShowMessage("error", "Pakiusap ilagay ang Job Title."); return;
            }
            if (title.Length < 3) {
                ShowMessage("error", "Ang Job Title ay dapat hindi bababa sa 3 karakter."); return;
            }
            if (string.IsNullOrEmpty(category)) {
                ShowMessage("error", "Pakiusap pumili ng Kategorya."); return;
            }
            if (string.IsNullOrEmpty(barangay)) {
                ShowMessage("error", "Pakiusap pumili ng Barangay."); return;
            }
            if (string.IsNullOrEmpty(tags)) {
                ShowMessage("error", "Pakiusap pumili ng kahit isang tag."); return;
            }
            if (string.IsNullOrEmpty(description)) {
                ShowMessage("error", "Pakiusap ilagay ang Detalye ng trabaho."); return;
            }
            if (description.Length < 10) {
                ShowMessage("error", "Ang detalye ay dapat hindi bababa sa 10 karakter."); return;
            }

            decimal payMin = ParseDecimal(txtPayMin.Text);
            decimal payMax = ParseDecimal(txtPayMax.Text);

            if (payMin <= 0 || payMax <= 0) {
                ShowMessage("error", "Pakiusap ilagay ang Sahod."); return;
            }
            if (payMax < payMin + 1) {
                ShowMessage("error", "Ang maximum na sahod ay dapat hindi bababa sa minimum + ₱1."); return;
            }

            // ── INSERT TO DATABASE (parameterized — SQL injection safe) ──
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                INSERT INTO Jobs
                    (JobTitle, JobDescription, Category, Barangay, PayMin, PayMax, PayRate,
                     Tags, Status, Slots, IsActive, PostedAt, PostedByUserId)
                VALUES
                    (@JobTitle, @JobDescription, @Category, @Barangay, @PayMin, @PayMax, @PayRate,
                     @Tags, 'Available', @Slots, 1, GETDATE(), @PostedByUserId)", conn)) {

                cmd.Parameters.Add("@JobTitle", System.Data.SqlDbType.NVarChar, 150).Value = title;
                cmd.Parameters.Add("@JobDescription", System.Data.SqlDbType.NVarChar, 500).Value = description;
                cmd.Parameters.Add("@Category", System.Data.SqlDbType.NVarChar, 60).Value = category;
                cmd.Parameters.Add("@Barangay", System.Data.SqlDbType.NVarChar, 60).Value = barangay;
                cmd.Parameters.Add("@PayMin", System.Data.SqlDbType.Decimal).Value = payMin;
                cmd.Parameters.Add("@PayMax", System.Data.SqlDbType.Decimal).Value = payMax;
                cmd.Parameters.Add("@PayRate", System.Data.SqlDbType.NVarChar, 30).Value = payRate;
                cmd.Parameters.Add("@Tags", System.Data.SqlDbType.NVarChar, 300).Value = tags;
                cmd.Parameters.Add("@Slots", System.Data.SqlDbType.Int).Value = slots;
                cmd.Parameters.Add("@PostedByUserId", System.Data.SqlDbType.Int).Value = Session["UserId"];

                try {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException) {
                    ShowMessage("error", "Nagkaroon ng error sa server. Subukan ulit.");
                    return;
                }
            }

            // ── REDIRECT TO HANAPTRABAHO after successful post ──
            Response.Redirect("~/Pages/HanapTrabaho.aspx?posted=success");
        }

        // ── HELPERS ──

        // Sentence case + strip special chars
        private string CleanTitle(string input) {
            if (string.IsNullOrWhiteSpace(input)) return "";
            input = input.Trim();
            input = Regex.Replace(input, @"\s+", " ");
            input = Regex.Replace(input, @"[^\w\s\-\.\,\/]", "");
            return System.Globalization.CultureInfo.CurrentCulture
                .TextInfo.ToTitleCase(input.ToLower());
        }

        // Strip HTML tags, enforce max length
        private string CleanDescription(string input) {
            if (string.IsNullOrWhiteSpace(input)) return "";
            input = input.Trim();
            input = Regex.Replace(input, @"<[^>]*>", "");
            if (input.Length > 500) input = input.Substring(0, 500);
            return input;
        }

        // Strip non-numeric chars and parse
        private decimal ParseDecimal(string input) {
            if (string.IsNullOrWhiteSpace(input)) return 0;
            string cleaned = Regex.Replace(input, @"[^\d\.]", "");
            return decimal.TryParse(cleaned, out decimal result) ? result : 0;
        }

        private string SanitizeText(string input, int maxLength) {
            if (string.IsNullOrWhiteSpace(input)) return "";
            input = input.Trim();
            if (input.Length > maxLength) input = input.Substring(0, maxLength);
            return input;
        }

        private void ShowMessage(string type, string message) {
            pnlPostMessage.Visible = true;
            pnlPostMessage.CssClass = $"form-alert {type}";
            lblPostMessage.Text = message;
        }
    }
}