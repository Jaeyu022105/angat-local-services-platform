using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GROUP6_ANGAT
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string message = txtMessage.Text.Trim();

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(message))
            {
                pnlContactMessage.Visible = true;
                pnlContactMessage.CssClass = "form-alert error";
                lblContactMessage.Text = "Paki-kumpleto ang lahat ng field.";
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "INSERT INTO ContactMessages (SenderName, SenderEmail, MessageBody) VALUES (@Name, @Email, @Message)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Message", message);

                    conn.Open();
                    cmd.ExecuteNonQuery(); 
                }
            }

            txtName.Text = "";
            txtEmail.Text = "";
            txtMessage.Text = "";

            pnlContactMessage.Visible = true;
            pnlContactMessage.CssClass = "form-alert success";
            lblContactMessage.Text = "Salamat! Ang iyong mensahe ay naipadala na sa aming grupo.";
        }
    }
}
