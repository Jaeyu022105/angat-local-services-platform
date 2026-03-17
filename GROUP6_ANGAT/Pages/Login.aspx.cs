using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace GROUP6_ANGAT
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            string email = (txtLoginEmail.Text ?? string.Empty).Trim().ToLowerInvariant();
            string password = (txtLoginPassword.Text ?? string.Empty).Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblLoginMessage.Text = "Paki-kumpleto ang email at password.";
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"SELECT UserId, FullName, Password
                                                    FROM Users 
                                                    WHERE Email = @Email AND IsActive = 1", conn))
            {
                cmd.Parameters.AddWithValue("@Email", email);

                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader(CommandBehavior.SingleRow))
                {
                    if (!reader.Read())
                    {
                        lblLoginMessage.Text = "Walang account na tumutugma sa email na ito.";
                        return;
                    }

                    string storedPassword = reader["Password"].ToString();
                    if (!string.Equals(password, storedPassword, StringComparison.Ordinal))
                    {
                        lblLoginMessage.Text = "Maling password. Subukan ulit.";
                        return;
                    }

                    Session["UserId"] = reader["UserId"];
                    Session["UserName"] = reader["FullName"];
                    Session["UserEmail"] = email;
                }
            }

            string returnUrl = Request.QueryString["returnUrl"];
            if (!string.IsNullOrWhiteSpace(returnUrl) && returnUrl.StartsWith("/", StringComparison.Ordinal))
            {
                Response.Redirect(returnUrl);
                return;
            }

            Response.Redirect("~/");
        }
    }
}
