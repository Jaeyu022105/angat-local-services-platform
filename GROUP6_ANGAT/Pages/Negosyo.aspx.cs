using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

namespace GROUP6_ANGAT.Pages
{
    public partial class Directory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDirectory();
            }
        }

        private void LoadDirectory()
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT d.BusinessName, d.Category, d.Barangay, d.AddressLine, d.OwnerName, d.ContactNumber,
                       d.MapEmbedUrl, d.Hours, d.Tags, d.Status,
                       COALESCE(NULLIF(LTRIM(RTRIM(d.OwnerName)), ''), u.FullName) AS OwnerDisplay
                FROM DirectoryBusinesses d
                LEFT JOIN Users u ON d.UserId = u.UserId
                WHERE d.IsActive = 1
                ORDER BY d.CreatedAt DESC", conn))
            {
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    rptDirectory.DataSource = reader;
                    rptDirectory.DataBind();
                }
            }
        }

        protected string BuildSearchText(object nameObj, object tagsObj, object barangayObj, object categoryObj, object addressObj, object ownerObj)
        {
            string address = (addressObj ?? "").ToString();
            string owner = (ownerObj ?? "").ToString();
            string extra = (address + " " + owner).Trim();
            return GROUP6_ANGAT.DisplayHelper.GetSearchText(nameObj, tagsObj, barangayObj, categoryObj, extra);
        }

        protected string GetAddressValue(object addressObj, object barangayObj)
        {
            string address = (addressObj ?? "").ToString().Trim();
            if (!string.IsNullOrWhiteSpace(address))
            {
                return address;
            }

            string barangay = (barangayObj ?? "").ToString().Trim();
            if (string.IsNullOrWhiteSpace(barangay))
            {
                return "Bi\u00f1an";
            }

            return "Brgy. " + barangay + ", Bi\u00f1an";
        }

        protected string EncodeAttr(object value)
        {
            string text = value == null ? "" : value.ToString();
            return HttpUtility.HtmlAttributeEncode(text);
        }

        protected string GetDisplayLocation(object addressObj, object barangayObj)
        {
            string address = (addressObj ?? "").ToString().Trim();
            if (!string.IsNullOrWhiteSpace(address))
            {
                return HttpUtility.HtmlEncode(address);
            }

            string barangay = (barangayObj ?? "").ToString().Trim();
            if (string.IsNullOrWhiteSpace(barangay))
            {
                return "Bi\u00f1an";
            }

            return "Brgy. " + HttpUtility.HtmlEncode(barangay) + ", Bi\u00f1an";
        }

        protected string GetOwnerDisplay(object ownerObj)
        {
            string owner = (ownerObj ?? "").ToString().Trim();
            return string.IsNullOrWhiteSpace(owner) ? "—" : HttpUtility.HtmlEncode(owner);
        }

        protected string GetHoursBadge(object hoursObj)
        {
            string hours = (hoursObj ?? "").ToString().Trim();
            if (string.IsNullOrWhiteSpace(hours))
            {
                return string.Empty;
            }

            string safe = HttpUtility.HtmlEncode(hours);
            return $"<span class=\"badge badge-blue\"><i class='bx bx-time-five'></i> {safe}</span>";
        }

        protected string GetCategoryIconClass(object categoryObj)
        {
            string cat = (categoryObj ?? "").ToString().ToLowerInvariant();
            if (cat.Contains("sari"))
            {
                return "bx-store";
            }
            if (cat.Contains("carinderia") || cat.Contains("food"))
            {
                return "bx-restaurant";
            }
            if (cat.Contains("ukay"))
            {
                return "bx-closet";
            }
            if (cat.Contains("agrivet") || cat.Contains("palengke"))
            {
                return "bx-leaf";
            }

            return "bx-wrench";
        }

        protected string GetCategoryIconStyle(object categoryObj)
        {
            string cat = (categoryObj ?? "").ToString().ToLowerInvariant();
            if (cat.Contains("sari"))
            {
                return "color: #0d9e6e; background: #e6f7f1;";
            }
            if (cat.Contains("carinderia") || cat.Contains("food"))
            {
                return "color: #b45309; background: #fef3c7;";
            }
            if (cat.Contains("ukay"))
            {
                return "color: #be123c; background: #ffe4e6;";
            }
            if (cat.Contains("agrivet") || cat.Contains("palengke"))
            {
                return "color: #14b8a6; background: #ccfbf1;";
            }

            return "color: #1d4ed8; background: #dbeafe;";
        }

        protected string GetCategoryBadgeClass(object categoryObj)
        {
            string cat = (categoryObj ?? "").ToString().ToLowerInvariant();
            if (cat.Contains("carinderia") || cat.Contains("food"))
            {
                return "badge-amber";
            }
            if (cat.Contains("ukay"))
            {
                return "badge-rose";
            }
            if (cat.Contains("agrivet") || cat.Contains("palengke"))
            {
                return "badge-teal";
            }
            if (cat.Contains("sari"))
            {
                return "badge-teal";
            }

            return "badge-blue";
        }

        protected string GetStatusStyle(object statusObj)
        {
            string status = (statusObj ?? "").ToString().ToLowerInvariant();
            if (status.Contains("sarado") || status.Contains("closed"))
            {
                return "color: #be123c; font-weight: bold;";
            }

            return "color: #0d9e6e; font-weight: bold;";
        }
    }
}
