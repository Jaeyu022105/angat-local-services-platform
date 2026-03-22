using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web;

namespace GROUP6_ANGAT {
    public partial class PostJob : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (Session["UserId"] == null) {
                Response.Redirect("~/Pages/Login.aspx?returnUrl=/Pages/PostJob.aspx");
                return;
            }
        }

        protected void BtnPostJob_Click(object sender, EventArgs e) {
            string title = CleanTitle(txtJobTitle.Text);
            string category = SanitizeText(ddlCategory.SelectedValue, 60);
            string barangay = SanitizeText(ddlBarangay.SelectedValue, 60);
            string payRate = SanitizeText(ddlPayRate.SelectedValue, 30);
            string tags = SanitizeText(hfTags.Value, 300);
            string description = CleanDescription(txtJobDescription.Text);

            int slots = 1;
            int.TryParse(txtSlots.Text, out slots);
            slots = Math.Max(1, Math.Min(10, slots));

            if (string.IsNullOrEmpty(title) || title.Length < 3) { ShowMessage("error", "Pakiusap ilagay ang wastong Job Title."); return; }
            decimal payMin = ParseDecimal(txtPayMin.Text);
            decimal payMax = ParseDecimal(txtPayMax.Text);

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                INSERT INTO Jobs (JobTitle, JobDescription, Category, Barangay, PayMin, PayMax, PayRate, Tags, Status, Slots, IsActive, PostedAt, PostedByUserId)
                VALUES (@JobTitle, @JobDescription, @Category, @Barangay, @PayMin, @PayMax, @PayRate, @Tags, 'Available', @Slots, 1, GETDATE(), @PostedByUserId)", conn)) {

                cmd.Parameters.AddWithValue("@JobTitle", title);
                cmd.Parameters.AddWithValue("@JobDescription", description);
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.Parameters.AddWithValue("@Barangay", barangay);
                cmd.Parameters.AddWithValue("@PayMin", payMin);
                cmd.Parameters.AddWithValue("@PayMax", payMax);
                cmd.Parameters.AddWithValue("@PayRate", payRate);
                cmd.Parameters.AddWithValue("@Tags", tags);
                cmd.Parameters.AddWithValue("@Slots", slots);
                cmd.Parameters.AddWithValue("@PostedByUserId", Session["UserId"]);

                try {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    Response.Redirect("~/Pages/HanapTrabaho.aspx?posted=success", false);
                    HttpContext.Current.ApplicationInstance.CompleteRequest();
                }
                catch { ShowMessage("error", "Nagkaroon ng error sa server."); }
            }
        }

        private string CleanTitle(string i) => Regex.Replace(i.Trim(), @"[^\w\s\-\.\,\/]", "");
        private string CleanDescription(string i) => Regex.Replace(i.Trim(), @"<[^>]*>", "");
        private decimal ParseDecimal(string i) => decimal.TryParse(Regex.Replace(i ?? "0", @"[^\d\.]", ""), out decimal r) ? r : 0;
        private string SanitizeText(string i, int l) => (i ?? "").Length > l ? i.Substring(0, l) : i;
        private void ShowMessage(string t, string m) { pnlPostMessage.Visible = true; pnlPostMessage.CssClass = $"form-alert {t}"; lblPostMessage.Text = m; }
    }
}