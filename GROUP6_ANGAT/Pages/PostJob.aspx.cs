using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
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
            using (SqlConnection conn = new SqlConnection(connString)) {
                try {
                    conn.Open();
                    using (SqlTransaction tx = conn.BeginTransaction()) {
                        int categoryId = DbLookupHelper.EnsureCategoryId(conn, tx, category, "Job");
                        int barangayId = DbLookupHelper.EnsureBarangayId(conn, tx, barangay);
                        int rateTypeId = DbLookupHelper.EnsureRateTypeId(conn, tx, payRate, "Job");

                        using (SqlCommand cmd = new SqlCommand(@"
                INSERT INTO Jobs (JobTitle, JobDescription, CategoryId, BarangayId, PayMin, PayMax, PayRateTypeId, Status, Slots, IsActive, PostedAt, PostedByUserId)
                OUTPUT INSERTED.JobId
                VALUES (@JobTitle, @JobDescription, @CategoryId, @BarangayId, @PayMin, @PayMax, @PayRateTypeId, 'Available', @Slots, 1, GETDATE(), @PostedByUserId)", conn, tx)) {

                            cmd.Parameters.AddWithValue("@JobTitle", title);
                            cmd.Parameters.AddWithValue("@JobDescription", description);
                            cmd.Parameters.AddWithValue("@CategoryId", categoryId);
                            cmd.Parameters.AddWithValue("@BarangayId", barangayId);
                            cmd.Parameters.AddWithValue("@PayMin", payMin);
                            cmd.Parameters.AddWithValue("@PayMax", payMax);
                            cmd.Parameters.AddWithValue("@PayRateTypeId", rateTypeId);
                            cmd.Parameters.AddWithValue("@Slots", slots);
                            cmd.Parameters.AddWithValue("@PostedByUserId", Session["UserId"]);

                            int jobId = Convert.ToInt32(cmd.ExecuteScalar());
                            SaveJobTags(conn, tx, jobId, tags);
                        }
                        tx.Commit();
                    }

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

        private IEnumerable<string> ParseTags(string raw) {
            return (raw ?? "")
                .Split(new[] { '|' }, StringSplitOptions.RemoveEmptyEntries)
                .Select(t => t.Trim())
                .Where(t => t.Length > 0)
                .Distinct(StringComparer.OrdinalIgnoreCase);
        }

        private int EnsureTag(SqlConnection conn, SqlTransaction tx, string tag) {
            using (SqlCommand cmd = new SqlCommand(@"
                IF NOT EXISTS (SELECT 1 FROM Tags WHERE TagName = @TagName)
                    INSERT INTO Tags (TagName) VALUES (@TagName);
                SELECT TagId FROM Tags WHERE TagName = @TagName;", conn, tx)) {
                cmd.Parameters.Add("@TagName", SqlDbType.NVarChar, 100).Value = tag;
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        private void SaveJobTags(SqlConnection conn, SqlTransaction tx, int jobId, string rawTags) {
            foreach (string tag in ParseTags(rawTags)) {
                int tagId = EnsureTag(conn, tx, tag);
                using (SqlCommand linkCmd = new SqlCommand(@"
                    IF NOT EXISTS (SELECT 1 FROM JobTags WHERE JobId = @JobId AND TagId = @TagId)
                        INSERT INTO JobTags (JobId, TagId) VALUES (@JobId, @TagId);", conn, tx)) {
                    linkCmd.Parameters.Add("@JobId", SqlDbType.Int).Value = jobId;
                    linkCmd.Parameters.Add("@TagId", SqlDbType.Int).Value = tagId;
                    linkCmd.ExecuteNonQuery();
                }
            }
        }
    }
}
