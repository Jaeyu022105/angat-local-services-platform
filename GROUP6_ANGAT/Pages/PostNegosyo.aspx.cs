using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace GROUP6_ANGAT
{
    public partial class PostNegosyo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx?returnUrl=/Pages/PostNegosyo.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (!IsUserRole())
                {
                    ShowMessage("error", "Ang page na ito ay para sa mga USERS lamang.");
                    btnPostNegosyo.Enabled = false;
                    return;
                }

                if (Session["UserName"] != null && string.IsNullOrWhiteSpace(txtOwnerName.Text))
                {
                    txtOwnerName.Text = Session["UserName"].ToString();
                }
            }
        }

        protected void BtnPostNegosyo_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx?returnUrl=/Pages/PostNegosyo.aspx");
                return;
            }

            if (!IsUserRole())
            {
                ShowMessage("error", "Ang page na ito ay para sa mga USERS lamang.");
                return;
            }

            string name = (txtBusinessName.Text ?? "").Trim();
            string category = ddlCategory.SelectedValue;
            string barangay = (txtBarangay.Text ?? "").Trim();
            string address = (txtAddressLine.Text ?? "").Trim();
            string ownerName = (txtOwnerName.Text ?? "").Trim();
            string contactNumber = (txtContactNumber.Text ?? "").Trim();
            string hours = (txtHours.Text ?? "").Trim();
            string mapEmbedUrl = NormalizeMapEmbedUrl(txtMapEmbedUrl.Text);
            string tags = (txtTags.Text ?? "").Trim();
            string status = ddlStatus.SelectedValue;

            if (string.IsNullOrWhiteSpace(name) || string.IsNullOrWhiteSpace(category) || string.IsNullOrWhiteSpace(barangay))
            {
                ShowMessage("error", "Paki-kumpleto ang Pangalan ng Negosyo, Kategorya, at Barangay.");
                return;
            }

            if (string.IsNullOrWhiteSpace(ownerName) && Session["UserName"] != null)
            {
                ownerName = Session["UserName"].ToString();
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                INSERT INTO DirectoryBusinesses
                    (BusinessName, Category, Barangay, AddressLine, OwnerName, ContactNumber, Hours, Tags, MapEmbedUrl, Status, IsActive, CreatedAt, UserId)
                VALUES
                    (@BusinessName, @Category, @Barangay, @AddressLine, @OwnerName, @ContactNumber, @Hours, @Tags, @MapEmbedUrl, @Status, 1, GETDATE(), @UserId)", conn))
            {
                cmd.Parameters.AddWithValue("@BusinessName", name);
                cmd.Parameters.AddWithValue("@Category", category);
                cmd.Parameters.AddWithValue("@Barangay", barangay);
                cmd.Parameters.AddWithValue("@AddressLine", string.IsNullOrWhiteSpace(address) ? (object)DBNull.Value : address);
                cmd.Parameters.AddWithValue("@OwnerName", string.IsNullOrWhiteSpace(ownerName) ? (object)DBNull.Value : ownerName);
                cmd.Parameters.AddWithValue("@ContactNumber", string.IsNullOrWhiteSpace(contactNumber) ? (object)DBNull.Value : contactNumber);
                cmd.Parameters.AddWithValue("@Hours", string.IsNullOrWhiteSpace(hours) ? (object)DBNull.Value : hours);
                cmd.Parameters.AddWithValue("@Tags", string.IsNullOrWhiteSpace(tags) ? (object)DBNull.Value : tags);
                cmd.Parameters.AddWithValue("@MapEmbedUrl", string.IsNullOrWhiteSpace(mapEmbedUrl) ? (object)DBNull.Value : mapEmbedUrl);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            ShowMessage("success", "Nairehistro na ang inyong negosyo! Makikita ito sa Directory.");

            txtBusinessName.Text = "";
            txtBarangay.Text = "";
            txtAddressLine.Text = "";
            txtOwnerName.Text = Session["UserName"] != null ? Session["UserName"].ToString() : "";
            txtContactNumber.Text = "";
            txtHours.Text = "";
            txtMapEmbedUrl.Text = "";
            txtTags.Text = "";
            ddlStatus.SelectedIndex = 0;
        }

        private bool IsUserRole()
        {
            if (Session["UserId"] == null)
            {
                return false;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand("SELECT Role FROM Users WHERE UserId = @UserId", conn))
            {
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                object roleObj = cmd.ExecuteScalar();
                string role = roleObj == null ? "" : roleObj.ToString();
                return string.Equals(role, "User", StringComparison.OrdinalIgnoreCase);
            }
        }

        private void ShowMessage(string type, string message)
        {
            pnlPostMessage.Visible = true;
            pnlPostMessage.CssClass = $"form-alert {type}";
            lblPostMessage.Text = message;
        }

        private string NormalizeMapEmbedUrl(string raw)
        {
            string text = (raw ?? "").Trim();
            if (string.IsNullOrWhiteSpace(text))
            {
                return "";
            }

            if (text.IndexOf("<iframe", StringComparison.OrdinalIgnoreCase) >= 0)
            {
                Match match = Regex.Match(text, "src\\s*=\\s*\"([^\"]+)\"", RegexOptions.IgnoreCase);
                if (match.Success)
                {
                    return match.Groups[1].Value.Trim();
                }

                match = Regex.Match(text, "src\\s*=\\s*'([^']+)'", RegexOptions.IgnoreCase);
                if (match.Success)
                {
                    return match.Groups[1].Value.Trim();
                }
            }

            return text;
        }
    }
}
