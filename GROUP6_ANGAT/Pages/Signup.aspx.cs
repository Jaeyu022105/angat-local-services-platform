using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace GROUP6_ANGAT {
    public partial class Signup : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnSignup_Click(object sender, EventArgs e) {

            // ── SANITIZE INPUTS ──
            string fullName = SanitizeText(txtFullName.Text, maxLength: 100);
            string phone = SanitizeText(txtPhone.Text, maxLength: 15);
            string email = SanitizeText(txtEmail.Text, maxLength: 150).ToLowerInvariant();
            string barangay = SanitizeText(ddlBarangay.SelectedValue, maxLength: 60);
            string address = SanitizeText(txtAddress.Text, maxLength: 255);
            string password = (txtPassword.Text ?? "").Trim();
            string confirm = (txtConfirmPassword.Text ?? "").Trim();

            // ── REQUIRED FIELD CHECKS ──
            if (string.IsNullOrEmpty(fullName)) {
                ShowError("Pakiusap ilagay ang inyong buong pangalan."); return;
            }
            if (fullName.Length < 2) {
                ShowError("Ang pangalan ay dapat hindi bababa sa 2 karakter."); return;
            }
            if (!Regex.IsMatch(fullName, @"^[\p{L}\s\.\-']+$")) {
                ShowError("Ang pangalan ay dapat letra at espasyo lang."); return;
            }

            // ── PHONE VALIDATION ──
            if (string.IsNullOrEmpty(phone)) {
                ShowError("Pakiusap ilagay ang inyong mobile number."); return;
            }
            if (!IsValidPhone(phone)) {
                ShowError("Invalid na format ng mobile number. Gamitin: 09XXXXXXXXX o +639XXXXXXXXX"); return;
            }

            // ── EMAIL VALIDATION (optional field but strict if provided) ──
            if (!string.IsNullOrEmpty(email) && !IsValidEmail(email)) {
                ShowError("Invalid na email address. Gumamit ng tunay na email (hal. ikaw@gmail.com)."); return;
            }

            // ── BARANGAY VALIDATION ──
            if (string.IsNullOrEmpty(barangay) || barangay == "0") {
                ShowError("Pakiusap piliin ang inyong barangay."); return;
            }

            // ── ADDRESS VALIDATION ──
            if (string.IsNullOrEmpty(address)) {
                ShowError("Pakiusap ilagay ang inyong address."); return;
            }
            if (address.Length < 5) {
                ShowError("Pakiusap ilagay ang kumpletong address."); return;
            }

            // ── PASSWORD VALIDATION ──
            if (string.IsNullOrEmpty(password)) {
                ShowError("Pakiusap ilagay ang password."); return;
            }
            if (password.Length < 8) {
                ShowError("Ang password ay dapat hindi bababa sa 8 na karakter."); return;
            }
            if (!Regex.IsMatch(password, @"[A-Za-z]") || !Regex.IsMatch(password, @"[0-9]")) {
                ShowError("Ang password ay dapat may letra at numero."); return;
            }
            if (!string.Equals(password, confirm, StringComparison.Ordinal)) {
                ShowError("Hindi magkatugma ang password."); return;
            }

            // ── INSERT TO DATABASE (parameterized — SQL injection safe) ──
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString)) {
                try {
                    conn.Open();
                    int barangayId = DbLookupHelper.EnsureBarangayId(conn, null, barangay);
                    int roleId = DbLookupHelper.EnsureRoleId(conn, null, "User");

                    using (SqlCommand cmd = new SqlCommand(@"
                INSERT INTO Users 
                    (FullName, Phone, Email, Password, BarangayId, AddressLine, CreatedAt, IsActive, RoleId, ProfileImagePath)
                VALUES 
                    (@FullName, @Phone, @Email, @Password, @BarangayId, @AddressLine, GETDATE(), 1, @RoleId, '~/Images/default-icon.jpg')", conn)) {

                        cmd.Parameters.Add("@FullName", System.Data.SqlDbType.NVarChar, 100).Value = fullName;
                        cmd.Parameters.Add("@Phone", System.Data.SqlDbType.VarChar, 15).Value = phone;
                        cmd.Parameters.Add("@Email", System.Data.SqlDbType.VarChar, 150).Value = string.IsNullOrEmpty(email) ? (object)DBNull.Value : email;
                        cmd.Parameters.Add("@Password", System.Data.SqlDbType.NVarChar, 255).Value = password;
                        cmd.Parameters.Add("@BarangayId", System.Data.SqlDbType.Int).Value = barangayId;
                        cmd.Parameters.Add("@AddressLine", System.Data.SqlDbType.NVarChar, 255).Value = address;
                        cmd.Parameters.Add("@RoleId", System.Data.SqlDbType.Int).Value = roleId;

                        cmd.ExecuteNonQuery();
                    }
                }
                catch (SqlException ex) {
                    if (ex.Number == 2627 || ex.Number == 2601) {
                        if (ex.Message.Contains("Phone") || ex.Message.Contains("UQ_Users_Phone"))
                            ShowError("Ang mobile number na ito ay ginagamit na. Gumamit ng iba.");
                        else if (ex.Message.Contains("Email"))
                            ShowError("Ang email na ito ay ginagamit na. Gumamit ng iba.");
                        else
                            ShowError("Duplicate entry. Subukan ng ibang details.");
                    }
                    else {
                        ShowError("Nagkaroon ng error sa server. Subukan ulit.");
                    }
                    return;
                }
            }

            Response.Redirect("~/Pages/Login.aspx?signup=success");
        }

        // ── HELPERS ──

        // Trims, removes null, enforces max length
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
            // Must match standard email format with a real TLD (letters only, 2+ chars)
            if (!Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[a-zA-Z]{2,}$"))
                return false;

            // Must have a valid-looking domain (at least one dot after @)
            string domain = email.Split('@')[1].ToLowerInvariant();

            // Block fake/internal TLDs
            string[] blockedTlds = { ".local", ".test", ".internal", ".invalid", ".localhost", ".example", ".lan" };
            foreach (var tld in blockedTlds)
                if (domain.EndsWith(tld)) return false;

            // Block single-label domains (no dot) e.g. user@angat
            if (!domain.Contains(".")) return false;

            return true;
        }

        private void ShowError(string message) {
            lblSignupMessage.CssClass = "login-helper error";
            lblSignupMessage.Text = message;
        }
    }
}
