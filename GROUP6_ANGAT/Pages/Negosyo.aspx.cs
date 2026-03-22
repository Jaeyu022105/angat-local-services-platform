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
        protected string GetStatusStyle(object stat) => (stat ?? "").ToString().ToLower().Contains("sarado") ? "color: #be123c; font-weight: bold;" : "color: #0d9e6e; font-weight: bold;";
    }
}