using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

namespace GROUP6_ANGAT.Pages {
    public partial class Directory : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (!IsPostBack) {
                LoadDirectory();
                if (Request.QueryString["posted"] == "success") {
                    pnlDirectoryMessage.Visible = true;
                    pnlDirectoryMessage.CssClass = "form-alert success";
                    lblDirectoryMessage.Text = "Na-rehistro na ang negosyo! Makikita ito sa directory.";
                }
            }
        }

        private void LoadDirectory() {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT d.BusinessName, d.Category, d.Barangay, d.AddressLine, 
                       d.OwnerName, d.ContactNumber, d.MapEmbedUrl, d.Hours, d.Tags, d.Status,
                       COALESCE(NULLIF(LTRIM(RTRIM(d.OwnerName)), ''), u.FullName) AS OwnerDisplay
                FROM DirectoryBusinesses d
                LEFT JOIN Users u ON d.UserId = u.UserId
                WHERE d.IsActive = 1
                ORDER BY d.CreatedAt DESC", conn)) {
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader()) {
                    rptDirectory.DataSource = reader;
                    rptDirectory.DataBind();
                }
            }
        }

        protected string GetDaysPart(object hoursObj) {
            string h = (hoursObj ?? "").ToString();
            return h.Contains("|") ? h.Split('|')[0].Trim() : h;
        }

        protected string GetTimePart(object hoursObj) {
            string h = (hoursObj ?? "").ToString();
            return h.Contains("|") ? h.Split('|')[1].Trim() : "Hindi tinukoy";
        }

        protected string BuildSearchText(object name, object tags, object brgy, object cat, object addr, object owner) {
            return string.Format("{0} {1} {2} {3} {4} {5}", name, tags, brgy, cat, addr, owner).ToLower();
        }

        protected string GetAddressValue(object addr, object brgy) {
            string a = (addr ?? "").ToString().Trim();
            string b = (brgy ?? "").ToString().Trim();
            return string.IsNullOrEmpty(a) ? "Brgy. " + b + ", Biñan" : a + ", Brgy. " + b + ", Biñan";
        }

        protected string EncodeAttr(object value) => HttpUtility.HtmlAttributeEncode((value ?? "").ToString());

        protected string GetDisplayLocation(object addr, object brgy) {
            return "Brgy. " + HttpUtility.HtmlEncode((brgy ?? "Biñan").ToString()) + ", Biñan";
        }

        protected string GetOwnerDisplay(object name, object disp) {
            string n = (name ?? "").ToString().Trim();
            return !string.IsNullOrEmpty(n) ? HttpUtility.HtmlEncode(n) : HttpUtility.HtmlEncode((disp ?? "—").ToString());
        }

        protected string GetHoursBadge(object hoursObj) {
            string h = (hoursObj ?? "").ToString();
            if (string.IsNullOrEmpty(h)) return "";
            if (h.Contains("|")) {
                var p = h.Split('|');
                return $"<span class='badge badge-teal'><i class='bx bx-calendar'></i> {p[0].Trim()}</span> <span class='badge badge-blue'><i class='bx bx-time-five'></i> {p[1].Trim()}</span>";
            }
            return $"<span class='badge badge-blue'><i class='bx bx-time-five'></i> {h}</span>";
        }

        protected string GetCategoryIconClass(object catObj) {
            string c = (catObj ?? "").ToString().ToLower();
            if (c.Contains("sari-sari")) return "bx-store";
            if (c.Contains("kainan")) return "bx-dish";
            return "bx-store-alt";
        }

        protected string GetCategoryIconStyle(object catObj) => "color: #0d9e6e; background: #e6f7f1;";
        protected string GetCategoryBadgeClass(object catObj) => "badge-teal";
        protected string GetDynamicStatus(object hoursObj) {
            string hours = (hoursObj ?? "").ToString().Trim();
            if (string.IsNullOrWhiteSpace(hours) || !hours.Contains("|")) return "Status Unknown";

            try {
                // 1. Split Hours (e.g., "Lunes - Biyernes | 8:00 AM - 10:00 PM")
                var parts = hours.Split('|');
                string daysPart = parts[0].Trim();
                string timePart = parts[1].Trim();

                // 2. Get Current PH Time
                DateTime now = TimeZoneInfo.ConvertTimeBySystemTimeZoneId(DateTime.UtcNow, "Singapore Standard Time");
                DayOfWeek today = now.DayOfWeek;
                TimeSpan currentTime = now.TimeOfDay;

                // 3. Check if Today is an Open Day
                bool isDayOpen = false;
                string[] dayNames = { "Linggo", "Lunes", "Martes", "Miyerkules", "Huwebes", "Biyernes", "Sabado" };

                if (daysPart.ToLower().Contains("araw-araw")) isDayOpen = true;
                else if (daysPart.ToLower().Contains("weekdays") && (int)today >= 1 && (int)today <= 5) isDayOpen = true;
                else if (daysPart.ToLower().Contains("weekends") && ((int)today == 0 || (int)today == 6)) isDayOpen = true;
                else {
                    // Check if today's name is mentioned in the list (e.g., "Lunes, Miyerkules")
                    foreach (var dayName in dayNames) {
                        if (daysPart.Contains(dayName) && today == (DayOfWeek)System.Array.IndexOf(dayNames, dayName)) {
                            isDayOpen = true; break;
                        }
                    }
                }

                if (!isDayOpen) return "Sarado Ngayon";

                // 4. Check if Current Time is within range
                var times = timePart.Split('-');
                if (times.Length == 2) {
                    DateTime openDT = DateTime.Parse(times[0].Trim());
                    DateTime closeDT = DateTime.Parse(times[1].Trim());

                    TimeSpan openTime = openDT.TimeOfDay;
                    TimeSpan closeTime = closeDT.TimeOfDay;

                    // Handle overnight hours (e.g., 6:00 PM - 2:00 AM)
                    if (closeTime < openTime) {
                        if (currentTime >= openTime || currentTime <= closeTime) return "Bukas Ngayon";
                    }
                    else {
                        if (currentTime >= openTime && currentTime <= closeTime) return "Bukas Ngayon";
                    }
                }
            }
            catch { return "Check Hours"; }

            return "Sarado Ngayon";
        }

        protected string GetStatusStyle(object hoursObj) {
            string status = GetDynamicStatus(hoursObj);
            return status == "Bukas Ngayon" ? "color: #0d9e6e; font-weight: bold;" : "color: #be123c; font-weight: bold;";
        }
    }
}