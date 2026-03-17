using System;
using System.Configuration;
using System.Data.SqlClient;

namespace GROUP6_ANGAT
{
    public partial class Signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            string fullName = (txtFullName.Text ?? string.Empty).Trim();
            string email = (txtEmail.Text ?? string.Empty).Trim().ToLowerInvariant();
            string password = (txtPassword.Text ?? string.Empty).Trim();
            string confirm = (txtConfirmPassword.Text ?? string.Empty).Trim();

            if (string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblSignupMessage.Text = "Paki-kumpleto ang lahat ng field.";
                return;
            }

            if (!string.Equals(password, confirm, StringComparison.Ordinal))
            {
                lblSignupMessage.Text = "Hindi magkatugma ang password.";
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"INSERT INTO Users (FullName, Email, Password, CreatedAt, IsActive)
                                                     VALUES (@FullName, @Email, @Password, GETDATE(), 1)", conn))
            {
                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 2627 || ex.Number == 2601)
                    {
                        lblSignupMessage.Text = "Email ay ginagamit na. Gumamit ng iba.";
                    }
                    else
                    {
                        lblSignupMessage.Text = "Nagkaroon ng error. Subukan ulit.";
                    }
                    return;
                }
            }

            lblSignupMessage.Text = "Matagumpay ang pag-sign up! Maaari ka nang mag-login.";
        }
    }
}
