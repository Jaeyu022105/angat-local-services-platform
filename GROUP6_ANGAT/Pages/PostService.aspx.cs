using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace GROUP6_ANGAT {
    public partial class PostService : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (Session["UserId"] == null) {
                Response.Redirect("~/Pages/Login.aspx?returnUrl=/Pages/PostService.aspx");
                return;
            }
        }

        protected void BtnPostService_Click(object sender, EventArgs e) {
            // ── SANITIZE INPUTS ──
            string title = CleanTitle(txtServiceTitle.Text);
            string category = SanitizeText(ddlCategory.SelectedValue, maxLength: 60);
            string barangay = SanitizeText(ddlBarangay.SelectedValue, maxLength: 60);
            string minRaw = SanitizeText(txtRateMin.Text, maxLength: 15);
            string maxRaw = SanitizeText(txtRateMax.Text, maxLength: 15);
            string rateUnit = SanitizeText(ddlRateUnit.SelectedValue, maxLength: 30);
            string tags = SanitizeText(hfTags.Value, maxLength: 300);
            string description = CleanDescription(txtServiceDescription.Text);

            // ── VALIDATION ──
            if (string.IsNullOrEmpty(title)) {
                ShowMessage("error", "Pakiusap ilagay ang Service Title."); return;
            }
            if (title.Length < 3) {
                ShowMessage("error", "Ang Service Title ay dapat hindi bababa sa 3 karakter."); return;
            }
            if (string.IsNullOrEmpty(category)) {
                ShowMessage("error", "Pakiusap piliin ang kategorya."); return;
            }
            if (string.IsNullOrEmpty(barangay) || barangay == "0") {
                ShowMessage("error", "Pakiusap piliin ang barangay."); return;
            }
            if (!decimal.TryParse(minRaw, out decimal rateMin) || rateMin <= 0) {
                ShowMessage("error", "Pakiusap ilagay ang tamang minimum na rate."); return;
            }
            if (!decimal.TryParse(maxRaw, out decimal rateMax) || rateMax <= 0) {
                ShowMessage("error", "Pakiusap ilagay ang tamang maximum na rate."); return;
            }
            if (rateMax < rateMin + 1) {
                ShowMessage("error", "Ang maximum na rate ay dapat hindi bababa sa minimum + \u20B11."); return;
            }
            if (string.IsNullOrEmpty(tags)) {
                ShowMessage("error", "Pakiusap pumili ng kahit isang tag."); return;
            }
            if (string.IsNullOrEmpty(description)) {
                ShowMessage("error", "Pakiusap ilagay ang detalye ng serbisyo."); return;
            }
            if (description.Length < 10) {
                ShowMessage("error", "Ang detalye ay dapat hindi bababa sa 10 karakter."); return;
            }

            // ── INSERT TO DATABASE (parameterized — SQL injection safe) ──
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                INSERT INTO Services
                    (ServiceTitle, Category, Barangay, RateMin, RateMax, RateType,
                     Tags, Status, ServiceDescription, PostedByUserId, IsActive, PostedAt)
                VALUES
                    (@ServiceTitle, @Category, @Barangay, @RateMin, @RateMax, @RateType,
                     @Tags, 'Available', @ServiceDescription, @PostedByUserId, 1, GETDATE())", conn)) {
                cmd.Parameters.Add("@ServiceTitle", System.Data.SqlDbType.NVarChar, 150).Value = title;
                cmd.Parameters.Add("@Category", System.Data.SqlDbType.NVarChar, 60).Value = category;
                cmd.Parameters.Add("@Barangay", System.Data.SqlDbType.NVarChar, 60).Value = barangay;
                cmd.Parameters.Add("@RateMin", System.Data.SqlDbType.Decimal).Value = rateMin;
                cmd.Parameters.Add("@RateMax", System.Data.SqlDbType.Decimal).Value = rateMax;
                cmd.Parameters.Add("@RateType", System.Data.SqlDbType.NVarChar, 30).Value = rateUnit;
                cmd.Parameters.Add("@Tags", System.Data.SqlDbType.NVarChar, 300).Value = tags;
                cmd.Parameters.Add("@ServiceDescription", System.Data.SqlDbType.NVarChar, 500).Value = description;
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

            Response.Redirect("~/Pages/HanapGawa.aspx?posted=success");
        }

        // ── HELPERS ──

        // Title case + strip special chars — same as PostJob
        private string CleanTitle(string input) {
            if (string.IsNullOrWhiteSpace(input)) return "";
            input = input.Trim();
            input = Regex.Replace(input, @"\s+", " ");
            input = Regex.Replace(input, @"[^\w\s\-\.\,\/]", "");
            return System.Globalization.CultureInfo.CurrentCulture
                .TextInfo.ToTitleCase(input.ToLower());
        }

        // Strip HTML tags, enforce max length — same as PostJob
        private string CleanDescription(string input) {
            if (string.IsNullOrWhiteSpace(input)) return "";
            input = input.Trim();
            input = Regex.Replace(input, @"<[^>]*>", "");
            if (input.Length > 500) input = input.Substring(0, 500);
            return input;
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