using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace GROUP6_ANGAT {
    public partial class Login : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void BtnLogin_Click(object sender, EventArgs e) {

            // ── SANITIZE INPUTS ──
            string identifier = SanitizeText(txtLoginIdentifier.Text, maxLength: 150);
            string password = (txtLoginPassword.Text ?? "").Trim();

            // ── REQUIRED CHECKS ──
            if (string.IsNullOrEmpty(identifier) || string.IsNullOrEmpty(password)) {
                ShowError("Paki-kumpleto ang lahat ng field."); return;
            }

            // ── DETERMINE LOGIN TYPE ──
            bool isPhone = IsValidPhone(identifier);
            bool isEmail = IsValidEmail(identifier.ToLowerInvariant());

            if (!isPhone && !isEmail) {
                ShowError("Invalid na format. Ilagay ang inyong mobile number o email address."); return;
            }

            // ── PASSWORD LENGTH SANITY CHECK ──
            if (password.Length < 8 || password.Length > 255) {
                ShowError("Maling password. Subukan ulit."); return;
            }

            // ── QUERY DATABASE (parameterized — SQL injection safe) ──
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString)) {
                string query = isPhone
                    ? "SELECT UserId, FullName, Password, Phone FROM Users WHERE Phone = @Identifier AND IsActive = 1"
                    : "SELECT UserId, FullName, Password, Phone FROM Users WHERE Email = @Identifier AND IsActive = 1";

                using (SqlCommand cmd = new SqlCommand(query, conn)) {
                    if (isPhone)
                        cmd.Parameters.Add("@Identifier", SqlDbType.VarChar, 15).Value = identifier;
                    else
                        cmd.Parameters.Add("@Identifier", SqlDbType.VarChar, 150).Value = identifier.ToLowerInvariant();

                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleRow)) {
                        if (!reader.Read()) {
                            ShowError(isPhone
                                ? "Walang account na tumutugma sa mobile number na ito."
                                : "Walang account na tumutugma sa email na ito.");
                            return;
                        }

                        string storedPassword = reader["Password"].ToString();
                        if (!string.Equals(password, storedPassword, StringComparison.Ordinal)) {
                            ShowError("Maling password. Subukan ulit."); return;
                        }

                        Session["UserId"] = reader["UserId"];
                        Session["UserName"] = reader["FullName"];
                        Session["UserPhone"] = reader["Phone"];
                    }
                }
            }

            // ── REDIRECT ──
            string returnUrl = Request.QueryString["returnUrl"];
            if (!string.IsNullOrWhiteSpace(returnUrl) && returnUrl.StartsWith("/"))
                Response.Redirect(returnUrl);
            else
                Response.Redirect("~/");
        }

        // ── HELPERS ──

        private string SanitizeText(string input, int maxLength) {
            if (string.IsNullOrWhiteSpace(input)) return "";
            input = input.Trim();
            if (input.Length > maxLength) input = input.Substring(0, maxLength);
            return input;
        }

        private bool IsValidPhone(string phone) {
            return Regex.IsMatch(phone, @"^(09|\+639)\d{9}$");
        }

        private bool IsValidEmail(string email) {
            if (!Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[a-zA-Z]{2,}$"))
                return false;

            string domain = email.Split('@')[1].ToLowerInvariant();

            string[] blockedTlds = { ".local", ".test", ".internal", ".invalid", ".localhost", ".example", ".lan" };
            foreach (var tld in blockedTlds)
                if (domain.EndsWith(tld)) return false;

            if (!domain.Contains(".")) return false;

            return true;
        }

        private void ShowError(string message) {
            lblLoginMessage.CssClass = "login-helper error";
            lblLoginMessage.Text = message;
        }
    }
}