using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace GROUP6_ANGAT {
    public partial class Signup : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnSignup_Click(object sender, EventArgs e) {
            string fullName = (txtFullName.Text ?? "").Trim();
            string phone = (txtPhone.Text ?? "").Trim();
            string email = (txtEmail.Text ?? "").Trim().ToLowerInvariant();
            string barangay = ddlBarangay.SelectedValue;
            string address = (txtAddress.Text ?? "").Trim();
            string password = (txtPassword.Text ?? "").Trim();
            string confirm = (txtConfirmPassword.Text ?? "").Trim();

            // Required field checks
            if (string.IsNullOrEmpty(fullName)) {
                ShowError("Pakiusap ilagay ang inyong buong pangalan."); return;
            }
            if (string.IsNullOrEmpty(phone)) {
                ShowError("Pakiusap ilagay ang inyong mobile number."); return;
            }
            if (!IsValidPhone(phone)) {
                ShowError("Invalid na format ng mobile number. Gamitin: 09XXXXXXXXX o +639XXXXXXXXX"); return;
            }
            if (!string.IsNullOrEmpty(email) && !IsValidEmail(email)) {
                ShowError("Invalid na format ng email address."); return;
            }
            if (string.IsNullOrEmpty(barangay)) {
                ShowError("Pakiusap piliin ang inyong barangay."); return;
            }
            if (string.IsNullOrEmpty(address)) {
                ShowError("Pakiusap ilagay ang inyong address."); return;
            }
            if (string.IsNullOrEmpty(password)) {
                ShowError("Pakiusap ilagay ang password."); return;
            }
            if (password.Length < 6) {
                ShowError("Ang password ay dapat hindi bababa sa 6 na karakter."); return;
            }
            if (!string.Equals(password, confirm, StringComparison.Ordinal)) {
                ShowError("Hindi magkatugma ang password."); return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                INSERT INTO Users 
                (FullName, Phone, Email, Password, Barangay, AddressLine, CreatedAt, IsActive, Role, ProfileImagePath)
                VALUES 
                (@FullName, @Phone, @Email, @Password, @Barangay, @AddressLine, GETDATE(), 1, 'User', '~/Images/default-icon.jpg')", conn))
                {
                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@Phone", phone);
                cmd.Parameters.AddWithValue("@Email", string.IsNullOrEmpty(email) ? (object)DBNull.Value : email);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.Parameters.AddWithValue("@Barangay", barangay);
                cmd.Parameters.AddWithValue("@AddressLine", address);

                try {
                    conn.Open();
                    cmd.ExecuteNonQuery();
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
                        ShowError("Nagkaroon ng error. Subukan ulit.");
                    }
                    return;
                }
            }

            //change that when they are successfully registered, they will be redirected to the login page
            Response.Redirect("Login.aspx?signup=success");
        }

        private bool IsValidPhone(string phone) {
            return Regex.IsMatch(phone, @"^(09|\+639)\d{9}$");
        }

        private bool IsValidEmail(string email) {
            return Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$");
        }

        private void ShowError(string message) {
            lblSignupMessage.CssClass = "login-helper error";
            lblSignupMessage.Text = message;
        }
    }
}