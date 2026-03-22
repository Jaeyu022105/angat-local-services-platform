using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

namespace GROUP6_ANGAT.Pages {
    public partial class Directory : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (!IsPostBack) {
                LoadDirectory();

                // Show success message if posted
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
                       COALESCE(NULLIF(LTRIM(RTRIM(d.OwnerName)), ''), u.FullName) AS OwnerDisplay,
                       d.CreatedAt
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
            string hours = (hoursObj ?? "").ToString().Trim();
            if (string.IsNullOrWhiteSpace(hours)) return "Hindi tinukoy";
            string[] parts = hours.Split('|');
            return parts.Length > 0 ? parts[0].Trim() : "Hindi tinukoy";
        }

        protected string GetTimePart(object hoursObj) {
            string hours = (hoursObj ?? "").ToString().Trim();
            if (string.IsNullOrWhiteSpace(hours)) return "Hindi tinukoy";
            string[] parts = hours.Split('|');
            return parts.Length > 1 ? parts[1].Trim() : "Hindi tinukoy";
        }

        protected string BuildSearchText(object nameObj, object tagsObj, object barangayObj, object categoryObj, object addressObj, object ownerObj) {
            string name = (nameObj ?? "").ToString();
            string address = (addressObj ?? "").ToString();
            string owner = (ownerObj ?? "").ToString();
            string extra = (name + " " + address + " " + owner).Trim();
            return GROUP6_ANGAT.DisplayHelper.GetSearchText(nameObj, tagsObj, barangayObj, categoryObj, extra);
        }

        protected string GetAddressValue(object addressObj, object barangayObj) {
            string address = (addressObj ?? "").ToString().Trim();
            if (!string.IsNullOrWhiteSpace(address)) {
                return address;
            }

            string barangay = (barangayObj ?? "").ToString().Trim();
            if (string.IsNullOrWhiteSpace(barangay)) {
                return "Biñan";
            }

            return "Brgy. " + barangay + ", Biñan";
        }

        protected string EncodeAttr(object value) {
            string text = value == null ? "" : value.ToString();
            return HttpUtility.HtmlAttributeEncode(text);
        }

        // MODIFIED: This function will now be called with 'null' for addressObj
        // when displaying the location on the listing card, ensuring only Barangay is shown.
        // It still supports showing full address if needed elsewhere.
        protected string GetDisplayLocation(object addressObj, object barangayObj) {
            string address = (addressObj ?? "").ToString().Trim();
            if (!string.IsNullOrWhiteSpace(address)) {
                return HttpUtility.HtmlEncode(address);
            }

            string barangay = (barangayObj ?? "").ToString().Trim();
            if (string.IsNullOrWhiteSpace(barangay)) {
                return "Biñan";
            }

            return "Brgy. " + HttpUtility.HtmlEncode(barangay) + ", Biñan";
        }

        protected string GetOwnerDisplay(object ownerNameObj, object ownerDisplayObj) {
            string ownerName = (ownerNameObj ?? "").ToString().Trim();
            string ownerDisplay = (ownerDisplayObj ?? "").ToString().Trim();

            if (!string.IsNullOrWhiteSpace(ownerName)) {
                return HttpUtility.HtmlEncode(ownerName);
            }

            if (!string.IsNullOrWhiteSpace(ownerDisplay)) {
                return HttpUtility.HtmlEncode(ownerDisplay);
            }

            return "—";
        }

        protected string GetHoursBadge(object hoursObj) {
            string hours = (hoursObj ?? "").ToString().Trim();
            if (string.IsNullOrWhiteSpace(hours)) return string.Empty;

            // Format: "Lunes - Biyernes | 6:00 AM - 10:00 PM"
            string[] parts = hours.Split('|');
            if (parts.Length == 2) {
                string days = HttpUtility.HtmlEncode(parts[0].Trim());
                string time = HttpUtility.HtmlEncode(parts[1].Trim());
                return "<span class=\"badge badge-teal\"><i class='bx bx-calendar'></i> " + days + "</span> " +
                       "<span class=\"badge badge-blue\"><i class='bx bx-time-five'></i> " + time + "</span>";
            }

            string safe = HttpUtility.HtmlEncode(hours);
            return "<span class=\"badge badge-blue\"><i class='bx bx-time-five'></i> " + safe + "</span>";
        }

        protected string GetCategoryIconClass(object categoryObj) {
            string cat = (categoryObj ?? "").ToString().ToLowerInvariant();
            if (cat.Contains("sari-sari")) return "bx-store";
            if (cat.Contains("kainan") || cat.Contains("panaderya")) return "bx-dish";
            if (cat.Contains("damit") || cat.Contains("ukay")) return "bx-closet";
            if (cat.Contains("gamit") || cat.Contains("regalo")) return "bx-gift";
            if (cat.Contains("computer") || cat.Contains("printing")) return "bx-desktop";
            if (cat.Contains("electronics") || cat.Contains("repair")) return "bx-wrench";
            if (cat.Contains("laundry")) return "bx-water";
            if (cat.Contains("salon") || cat.Contains("barbershop")) return "bx-cut";
            if (cat.Contains("hardware") || cat.Contains("construction")) return "bx-hard-hat";
            if (cat.Contains("gamot") || cat.Contains("halaman")) return "bx-leaf";
            if (cat.Contains("veterinary") || cat.Contains("pet")) return "bx-dog";
            return "bx-store-alt";
        }

        protected string GetCategoryIconStyle(object categoryObj) {
            string cat = (categoryObj ?? "").ToString().ToLowerInvariant();
            if (cat.Contains("sari-sari")) return "color: #0d9e6e; background: #e6f7f1;";
            if (cat.Contains("kainan") || cat.Contains("panaderya")) return "color: #b45309; background: #fef3c7;";
            if (cat.Contains("damit") || cat.Contains("ukay")) return "color: #be123c; background: #ffe4e6;";
            if (cat.Contains("gamit") || cat.Contains("regalo")) return "color: #7c3aed; background: #ede9fe;";
            if (cat.Contains("computer") || cat.Contains("printing")) return "color: #1d4ed8; background: #dbeafe;";
            if (cat.Contains("electronics") || cat.Contains("repair")) return "color: #0369a1; background: #e0f2fe;";
            if (cat.Contains("laundry")) return "color: #0891b2; background: #cffafe;";
            if (cat.Contains("salon") || cat.Contains("barbershop")) return "color: #db2777; background: #fce7f3;";
            if (cat.Contains("hardware") || cat.Contains("construction")) return "color: #92400e; background: #fef3c7;";
            if (cat.Contains("gamot") || cat.Contains("halaman")) return "color: #14b8a6; background: #ccfbf1;";
            if (cat.Contains("veterinary") || cat.Contains("pet")) return "color: #16a34a; background: #dcfce7;";
            return "color: #0d9e6e; background: #e6f7f1;";
        }

        protected string GetCategoryBadgeClass(object categoryObj) {
            string cat = (categoryObj ?? "").ToString().ToLowerInvariant();
            if (cat.Contains("kainan") || cat.Contains("panaderya")) return "badge-amber";
            if (cat.Contains("damit") || cat.Contains("ukay")) return "badge-rose";
            if (cat.Contains("gamit") || cat.Contains("regalo")) return "badge-violet";
            if (cat.Contains("computer") || cat.Contains("printing")) return "badge-blue";
            if (cat.Contains("electronics") || cat.Contains("repair")) return "badge-blue";
            if (cat.Contains("laundry")) return "badge-teal";
            if (cat.Contains("salon") || cat.Contains("barbershop")) return "badge-rose";
            if (cat.Contains("hardware") || cat.Contains("construction")) return "badge-amber";
            if (cat.Contains("gamot") || cat.Contains("halaman")) return "badge-teal";
            if (cat.Contains("veterinary") || cat.Contains("pet")) return "badge-teal";
            return "badge-teal";
        }

        protected string GetStatusStyle(object statusObj) {
            string status = (statusObj ?? "").ToString().ToLowerInvariant();
            if (status.Contains("sarado") || status.Contains("closed")) {
                return "color: #be123c; font-weight: bold;";
            }
            return "color: #0d9e6e; font-weight: bold;";
        }
    }
}