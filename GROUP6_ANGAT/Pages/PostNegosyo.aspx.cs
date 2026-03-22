using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;
using System.Linq;


namespace GROUP6_ANGAT {
    public partial class PostNegosyo : System.Web.UI.Page {
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
                PopulateHourDropdowns();

                // ADD THESE 3 LINES
                string editId = Request.QueryString["edit"];
                if (!string.IsNullOrEmpty(editId))
                    LoadExistingNegosyo(editId);

                // Only pre-fill name/phone if NOT editing
                if (string.IsNullOrEmpty(editId))
                {
                    if (Session["UserName"] != null)
                        txtOwnerName.Text = Session["UserName"].ToString();
                    if (Session["UserPhone"] != null)
                    {
                        txtContactNumber.Text = Session["UserPhone"].ToString();
                        lblPhoneHint.Text = "Ginagamit ang inyong registered na number. Pwede mo itong baguhin.";
                    }
                }
            }
        }

        private void PopulateHourDropdowns() {
            ddlOpenHour.Items.Clear();
            ddlCloseHour.Items.Clear();

            for (int h = 0; h < 24; h++) {
                string suffix = h < 12 ? "AM" : "PM";
                int hour12 = h == 0 ? 12 : h > 12 ? h - 12 : h;
                string label = hour12 + ":00 " + suffix;
                ddlOpenHour.Items.Add(new ListItem(label, label));
                ddlCloseHour.Items.Add(new ListItem(label, label));
            }

            // Default: 6:00 AM open, 10:00 PM close
            ddlOpenHour.SelectedValue = "6:00 AM";
            ddlCloseHour.SelectedValue = "10:00 PM";
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

            // ── SANITIZE ──
            string name = CleanTitle(txtBusinessName.Text);
            string category = SanitizeText(ddlCategory.SelectedValue, 60);
            string barangay = SanitizeText(ddlBarangay.SelectedValue, 60);
            string address = SanitizeText(txtAddressLine.Text, 255);
            string ownerName = SanitizeText(txtOwnerName.Text, 100);
            string contact = SanitizeText(txtContactNumber.Text, 20);
            string days = BuildDaysString();
            string time = GetSelectedTime();
            string hours = days + " | " + time; string mapUrl = NormalizeMapUrl(txtMapEmbedUrl.Text);
            string tags = SanitizeText(hfTags.Value, 300);

            // ── VALIDATE ──
            if (string.IsNullOrEmpty(name)) { ShowMessage("error", "Pakiusap ilagay ang Pangalan ng Negosyo."); return; }
            if (name.Length < 3) { ShowMessage("error", "Ang pangalan ng negosyo ay dapat hindi bababa sa 3 karakter."); return; }
            if (string.IsNullOrEmpty(category)) { ShowMessage("error", "Pakiusap piliin ang Kategorya."); return; }
            if (string.IsNullOrEmpty(barangay)) { ShowMessage("error", "Pakiusap piliin ang Barangay."); return; }
            if (string.IsNullOrEmpty(address) || address.Length < 5) { ShowMessage("error", "Pakiusap ilagay ang eksaktong address ng negosyo."); return; }
            if (string.IsNullOrEmpty(contact))
            {
                contact = Session["UserPhone"]?.ToString() ?? "";
                if (string.IsNullOrEmpty(contact)) { ShowMessage("error", "Pakiusap ilagay ang Contact Number."); return; }
            }
            if (!Regex.IsMatch(contact, @"^(09|\+639)\d{9}$")) { ShowMessage("error", "Invalid na format ng contact number. Gamitin: 09XXXXXXXXX"); return; }
            if (string.IsNullOrEmpty(hours)) { ShowMessage("error", "Pakiusap piliin ang oras ng operasyon. Siguraduhing hindi magkapareho ang opening at closing time."); return; }
            if (string.IsNullOrEmpty(tags)) { ShowMessage("error", "Pakiusap pumili ng kahit isang tag."); return; }

            if (string.IsNullOrEmpty(ownerName))
                ownerName = Session["UserName"]?.ToString() ?? "";
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            string editId = Request.QueryString["edit"];

            if (!string.IsNullOrEmpty(editId))
            {
                // ── UPDATE ──
                using (SqlConnection conn = new SqlConnection(connString))
                using (SqlCommand cmd = new SqlCommand(@"
            UPDATE Negosyo SET
                BusinessName  = @BusinessName,
                Category      = @Category,
                Barangay      = @Barangay,
                AddressLine   = @AddressLine,
                OwnerName     = @OwnerName,
                ContactNumber = @ContactNumber,
                Hours         = @Hours,
                Tags          = @Tags,
                MapEmbedUrl   = @MapEmbedUrl
            WHERE NegosyoId = @NegosyoId AND UserId = @UserId", conn))
                {
                    cmd.Parameters.Add("@BusinessName", SqlDbType.NVarChar, 150).Value = name;
                    cmd.Parameters.Add("@Category", SqlDbType.NVarChar, 60).Value = category;
                    cmd.Parameters.Add("@Barangay", SqlDbType.NVarChar, 60).Value = barangay;
                    cmd.Parameters.Add("@AddressLine", SqlDbType.NVarChar, 255).Value = address;
                    cmd.Parameters.Add("@OwnerName", SqlDbType.NVarChar, 100).Value = string.IsNullOrEmpty(ownerName) ? (object)DBNull.Value : ownerName;
                    cmd.Parameters.Add("@ContactNumber", SqlDbType.NVarChar, 20).Value = contact;
                    cmd.Parameters.Add("@Hours", SqlDbType.NVarChar, 150).Value = hours;
                    cmd.Parameters.Add("@Tags", SqlDbType.NVarChar, 300).Value = string.IsNullOrEmpty(tags) ? (object)DBNull.Value : tags;
                    cmd.Parameters.Add("@MapEmbedUrl", SqlDbType.NVarChar, 500).Value = string.IsNullOrEmpty(mapUrl) ? (object)DBNull.Value : mapUrl;
                    cmd.Parameters.Add("@NegosyoId", SqlDbType.Int).Value = editId;
                    cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = Session["UserId"];

                    try { conn.Open(); cmd.ExecuteNonQuery(); }
                    catch (SqlException) { ShowMessage("error", "Nagkaroon ng error sa server. Subukan ulit."); return; }
                }
                Response.Redirect("~/Pages/Profile.aspx?tab=businesslistings");

            }
            else
            {
                // ── INSERT ──
                using (SqlConnection conn = new SqlConnection(connString))
                using (SqlCommand cmd = new SqlCommand(@"
                INSERT INTO Negosyo
                    (BusinessName, Category, Barangay, AddressLine, OwnerName, ContactNumber,
                     Hours, Tags, MapEmbedUrl, Status, IsActive, CreatedAt, UserId)
                VALUES
                    (@BusinessName, @Category, @Barangay, @AddressLine, @OwnerName, @ContactNumber,
                     @Hours, @Tags, @MapEmbedUrl, 'Bukas Ngayon', 1, GETDATE(), @UserId)", conn))
                {
                    cmd.Parameters.Add("@BusinessName", SqlDbType.NVarChar, 150).Value = name;
                    cmd.Parameters.Add("@Category", SqlDbType.NVarChar, 60).Value = category;
                    cmd.Parameters.Add("@Barangay", SqlDbType.NVarChar, 60).Value = barangay;
                    cmd.Parameters.Add("@AddressLine", SqlDbType.NVarChar, 255).Value = address;
                    cmd.Parameters.Add("@OwnerName", SqlDbType.NVarChar, 100).Value = string.IsNullOrEmpty(ownerName) ? (object)DBNull.Value : ownerName;
                    cmd.Parameters.Add("@ContactNumber", SqlDbType.NVarChar, 20).Value = contact;
                    cmd.Parameters.Add("@Hours", SqlDbType.NVarChar, 150).Value = hours;
                    cmd.Parameters.Add("@Tags", SqlDbType.NVarChar, 300).Value = string.IsNullOrEmpty(tags) ? (object)DBNull.Value : tags;
                    cmd.Parameters.Add("@MapEmbedUrl", SqlDbType.NVarChar, 500).Value = string.IsNullOrEmpty(mapUrl) ? (object)DBNull.Value : mapUrl;
                    cmd.Parameters.Add("@UserId", SqlDbType.Int).Value = Session["UserId"];

                    try { conn.Open(); cmd.ExecuteNonQuery(); }
                    catch (SqlException) { ShowMessage("error", "Nagkaroon ng error sa server. Subukan ulit."); return; }
                }

                Response.Redirect("~/Pages/Negosyo.aspx?posted=success");
            }
        }
        // for updating in profile page
        private void LoadExistingNegosyo(string NegosyoId)
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
        SELECT BusinessName, Category, Barangay, AddressLine, OwnerName,
               ContactNumber, Hours, Tags, MapEmbedUrl
        FROM Negosyo
        WHERE NegosyoId = @NegosyoId AND UserId = @UserId", conn))
            {
                cmd.Parameters.AddWithValue("@NegosyoId", NegosyoId);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtBusinessName.Text = reader["BusinessName"].ToString();
                        txtAddressLine.Text = reader["AddressLine"].ToString();
                        txtOwnerName.Text = reader["OwnerName"].ToString();
                        txtContactNumber.Text = reader["ContactNumber"].ToString();
                        txtMapEmbedUrl.Text = reader["MapEmbedUrl"].ToString();
                        hfTags.Value = reader["Tags"].ToString();

                        // Set category dropdown
                        if (ddlCategory.Items.FindByValue(reader["Category"].ToString()) != null)
                            ddlCategory.SelectedValue = reader["Category"].ToString();

                        // Set barangay dropdown
                        if (ddlBarangay.Items.FindByValue(reader["Barangay"].ToString()) != null)
                            ddlBarangay.SelectedValue = reader["Barangay"].ToString();

                        // Parse hours — format is "Weekdays | 6:00 AM - 10:00 PM"
                        string hours = reader["Hours"].ToString();
                        if (hours.Contains("|"))
                        {
                            string timePart = hours.Split('|')[1].Trim();
                            if (timePart.Contains(" - "))
                            {
                                string[] times = timePart.Split(new string[] { " - " }, StringSplitOptions.None);
                                if (ddlOpenHour.Items.FindByValue(times[0].Trim()) != null)
                                    ddlOpenHour.SelectedValue = times[0].Trim();
                                if (ddlCloseHour.Items.FindByValue(times[1].Trim()) != null)
                                    ddlCloseHour.SelectedValue = times[1].Trim();
                            }
                        }

                        // Store hours and tags in hidden fields so JS can read them
                        hfHours.Value = hours;
                    }
                }
            }
        }
        // ── HELPERS ──
        private string CleanTitle(string input) {
            if (string.IsNullOrWhiteSpace(input)) return "";
            input = Regex.Replace(input.Trim(), @"\s+", " ");
            input = Regex.Replace(input, @"[^\w\s\-\.\,\'\/]", "");
            return System.Globalization.CultureInfo.CurrentCulture
                .TextInfo.ToTitleCase(input.ToLower());
        }

        private string SanitizeText(string input, int maxLength) {
            if (string.IsNullOrWhiteSpace(input)) return "";
            input = input.Trim();
            return input.Length > maxLength ? input.Substring(0, maxLength) : input;
        }

        private bool IsUserRole() {
            if (Session["UserId"] == null) return false;
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand("SELECT Role FROM Users WHERE UserId = @UserId", conn)) {
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                object r = cmd.ExecuteScalar();
                return string.Equals(r?.ToString() ?? "", "User", StringComparison.OrdinalIgnoreCase);
            }
        }

        private void ShowMessage(string type, string message) {
            pnlPostMessage.Visible = true;
            pnlPostMessage.CssClass = $"form-alert {type}";
            lblPostMessage.Text = message;
        }

        private string NormalizeMapUrl(string raw) {
            string text = (raw ?? "").Trim();
            if (string.IsNullOrWhiteSpace(text)) return "";
            if (text.IndexOf("<iframe", StringComparison.OrdinalIgnoreCase) >= 0) {
                Match m = Regex.Match(text, "src\\s*=\\s*\"([^\"]+)\"", RegexOptions.IgnoreCase);
                if (m.Success) return m.Groups[1].Value.Trim();
                m = Regex.Match(text, "src\\s*=\\s*'([^']+)'", RegexOptions.IgnoreCase);
                if (m.Success) return m.Groups[1].Value.Trim();
            }
            return text;
        }

        private string BuildDaysString() {
            // Get selected days from the checkboxes
            string[] selectedDays = Request.Form.GetValues("dayCheck");
            if (selectedDays == null || selectedDays.Length == 0)
                return "Hindi tinukoy";

            // Convert numeric values to day names
            string[] dayNames = { "Lunes", "Martes", "Miyerkules", "Huwebes", "Biyernes", "Sabado", "Linggo" };
            List<int> selected = new List<int>();

            foreach (string val in selectedDays) {
                if (int.TryParse(val, out int dayIndex))
                    selected.Add(dayIndex);
            }

            if (selected.Count == 0) return "Hindi tinukoy";
            if (selected.Count == 7) return "Araw-araw";

            selected.Sort();

            // Check if it's weekdays only (Mon-Fri = 0-4)
            var weekdays = new List<int> { 0, 1, 2, 3, 4 };
            if (selected.Count == 5 && selected.SequenceEqual(weekdays))
                return "Weekdays (Lunes - Biyernes)";

            // Check if it's weekends only (Sat-Sun = 5-6)
            var weekends = new List<int> { 5, 6 };
            if (selected.Count == 2 && selected.SequenceEqual(weekends))
                return "Weekends (Sabado - Linggo)";

            // Build custom day range
            List<string> dayStrings = new List<string>();
            int i = 0;
            while (i < selected.Count) {
                int start = selected[i];
                int end = selected[i];
                while (i + 1 < selected.Count && selected[i + 1] == selected[i] + 1) {
                    i++;
                    end = selected[i];
                }

                if (end - start >= 2)
                    dayStrings.Add(dayNames[start] + " - " + dayNames[end]);
                else if (end - start == 1)
                    dayStrings.Add(dayNames[start] + ", " + dayNames[end]);
                else
                    dayStrings.Add(dayNames[start]);
                i++;
            }

            return string.Join(", ", dayStrings);
        }

        private string GetSelectedTime() {
            string openHour = SanitizeText(ddlOpenHour.SelectedValue, 30);
            string closeHour = SanitizeText(ddlCloseHour.SelectedValue, 30);

            if (string.IsNullOrEmpty(openHour) || string.IsNullOrEmpty(closeHour))
                return "Hindi tinukoy";

            if (openHour == closeHour)
                return "Buong araw";

            return openHour + " - " + closeHour;
        }
    }
}
