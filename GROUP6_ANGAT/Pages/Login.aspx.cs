using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace GROUP6_ANGAT {
    public partial class Login : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void BtnLogin_Click(object sender, EventArgs e) {
            string identifier = (txtLoginIdentifier.Text ?? "").Trim();
            string password = (txtLoginPassword.Text ?? "").Trim();

            if (string.IsNullOrEmpty(identifier) || string.IsNullOrEmpty(password)) {
                lblLoginMessage.Text = "Paki-kumpleto ang lahat ng field.";
                return;
            }

            // Determine if phone or email
            bool isPhone = Regex.IsMatch(identifier, @"^(09|\+639)\d{9}$");
            bool isEmail = Regex.IsMatch(identifier, @"^[^@\s]+@[^@\s]+\.[^@\s]+$");

            if (!isPhone && !isEmail) {
                lblLoginMessage.Text = "Invalid na format. Ilagay ang inyong mobile number o email.";
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString)) {
                string query = isPhone
                    ? "SELECT UserId, FullName, Password, Phone FROM Users WHERE Phone = @Identifier AND IsActive = 1"
                    : "SELECT UserId, FullName, Password, Phone FROM Users WHERE Email = @Identifier AND IsActive = 1";

                using (SqlCommand cmd = new SqlCommand(query, conn)) {
                    cmd.Parameters.AddWithValue("@Identifier",
                        isEmail ? identifier.ToLowerInvariant() : identifier);

                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleRow)) {
                        if (!reader.Read()) {
                            lblLoginMessage.Text = isPhone
                                ? "Walang account na tumutugma sa mobile number na ito."
                                : "Walang account na tumutugma sa email na ito.";
                            return;
                        }

                        string storedPassword = reader["Password"].ToString();
                        if (!string.Equals(password, storedPassword, StringComparison.Ordinal)) {
                            lblLoginMessage.Text = "Maling password. Subukan ulit.";
                            return;
                        }

                        Session["UserId"] = reader["UserId"];
                        Session["UserName"] = reader["FullName"];
                        Session["UserPhone"] = reader["Phone"];
                    }
                }
            }

            string returnUrl = Request.QueryString["returnUrl"];
            if (!string.IsNullOrWhiteSpace(returnUrl) && returnUrl.StartsWith("/")) {
                Response.Redirect(returnUrl);
                return;
            }
            Response.Redirect("~/");
        }
    }
}