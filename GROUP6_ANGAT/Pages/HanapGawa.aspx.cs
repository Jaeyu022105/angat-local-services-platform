using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web;

namespace GROUP6_ANGAT.Pages
{
    public partial class HanapGawa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool isLoggedIn = Session["UserId"] != null;
            phServiceLoggedIn.Visible = isLoggedIn;
            phServiceLoggedOut.Visible = !isLoggedIn;

            if (!IsPostBack)
            {
                LoadServices();
            }
        }

        private void LoadServices()
        {
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"SELECT ServiceId, ServiceTitle, ServiceLocation, ServiceRate, ServiceTags, ServiceDescription, Status,
                                                            DateLabel, IconClass, IconBg, IconColor, Barangay, Category, PostedAt
                                                     FROM Services
                                                     WHERE IsActive = 1
                                                     ORDER BY PostedAt DESC", conn))
            {
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    rptServices.DataSource = reader;
                    rptServices.DataBind();
                }
            }
        }

        protected string GetTagsHtml(object tagsObj, object categoryObj)
        {
            string tagsRaw = tagsObj == null ? string.Empty : tagsObj.ToString();
            if (string.IsNullOrWhiteSpace(tagsRaw))
            {
                return string.Empty;
            }

            string category = categoryObj == null ? string.Empty : categoryObj.ToString();

            string[] tags = tagsRaw.Split(new[] { '|' }, StringSplitOptions.RemoveEmptyEntries);
            var sb = new StringBuilder();

            for (int i = 0; i < tags.Length; i++)
            {
                string rawTag = tags[i].Trim();
                if (rawTag.Length == 0)
                {
                    continue;
                }
                string tag = HttpUtility.HtmlEncode(rawTag);
                string css = GetTagClassForTag(rawTag, category);
                sb.AppendFormat("<span class=\"badge {0}\">{1}</span>", css, tag);
            }

            return sb.ToString();
        }

        protected string GetTagClassForTag(string tag, string category)
        {
            string normalized = (tag ?? string.Empty).ToLowerInvariant();
            if (normalized.Contains("urgent"))
            {
                return "tag-rose";
            }
            if (normalized.Contains("repair"))
            {
                return "tag-blue";
            }
            if (normalized.Contains("install") || normalized.Contains("wiring"))
            {
                return "tag-teal";
            }

            return GetTagClass(category);
        }

        protected string GetTagClass(object categoryObj)
        {
            string category = categoryObj == null ? string.Empty : categoryObj.ToString().ToLowerInvariant();
            if (category.Contains("karpintero") || category.Contains("carpentry"))
            {
                return "tag-amber";
            }
            if (category.Contains("tubero") || category.Contains("plumb"))
            {
                return "tag-blue";
            }
            if (category.Contains("electric"))
            {
                return "tag-teal";
            }
            if (category.Contains("aircon") || category.Contains("appliance"))
            {
                return "tag-mint";
            }
            if (category.Contains("mananahi") || category.Contains("tailor") || category.Contains("sew"))
            {
                return "tag-rose";
            }
            return "tag-violet";
        }

        protected string GetSearchText(object titleObj, object locationObj, object tagsObj, object barangayObj, object categoryObj)
        {
            string title = titleObj == null ? "" : titleObj.ToString();
            string location = locationObj == null ? "" : locationObj.ToString();
            string tags = tagsObj == null ? "" : tagsObj.ToString().Replace("|", " ");
            string barangay = barangayObj == null ? "" : barangayObj.ToString();
            string category = categoryObj == null ? "" : categoryObj.ToString();
            return (title + " " + location + " " + tags + " " + barangay + " " + category).Trim();
        }

        protected string GetStatusClass(object statusObj)
        {
            string status = statusObj == null ? "" : statusObj.ToString().ToLowerInvariant();
            if (status.Contains("busy"))
            {
                return "badge-rose";
            }
            if (status.Contains("available") || status.Contains("bukas"))
            {
                return "badge-green";
            }
            return "badge-teal";
        }

        protected string GetRateDisplay(object rateObj)
        {
            string rate = rateObj == null ? "" : rateObj.ToString();
            if (string.IsNullOrWhiteSpace(rate))
            {
                return "";
            }

            if (rate.Contains("?"))
            {
                rate = rate.Replace("?", "\u20B1");
            }

            if (rate.Contains("\u00E2\u201A\u00B1"))
            {
                rate = rate.Replace("\u00E2\u201A\u00B1", "\u20B1");
            }

            if (!rate.Contains("\u20B1") && !rate.StartsWith("PHP", StringComparison.OrdinalIgnoreCase))
            {
                rate = "\u20B1" + rate.TrimStart();
            }

            return HttpUtility.HtmlEncode(rate);
        }

        protected string GetRateSortValue(object rateObj)
        {
            string rate = rateObj == null ? "" : rateObj.ToString();
            if (string.IsNullOrWhiteSpace(rate))
            {
                return "0";
            }

            string cleaned = rate.Replace(",", "");
            int max = 0;
            string current = "";
            foreach (char c in cleaned)
            {
                if (char.IsDigit(c))
                {
                    current += c;
                }
                else
                {
                    if (current.Length > 0)
                    {
                        int val;
                        if (int.TryParse(current, out val) && val > max)
                        {
                            max = val;
                        }
                        current = "";
                    }
                }
            }
            if (current.Length > 0)
            {
                int val;
                if (int.TryParse(current, out val) && val > max)
                {
                    max = val;
                }
            }

            return max.ToString();
        }

        protected string GetPostedValue(object postedObj)
        {
            if (postedObj == null)
            {
                return "0";
            }

            DateTime posted;
            if (DateTime.TryParse(postedObj.ToString(), out posted))
            {
                return posted.ToFileTimeUtc().ToString();
            }

            return "0";
        }

        protected void BtnRequestService_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx?returnUrl=/Pages/HanapGawa.aspx");
                return;
            }

            int serviceId;
            if (!int.TryParse(hfServiceId.Value, out serviceId))
            {
                pnlServiceApplyMessage.Visible = true;
                pnlServiceApplyMessage.CssClass = "form-alert error";
                lblServiceApplyMessage.Text = "Piliin muna ang serbisyo bago mag-request.";
                return;
            }

            string title = (hfServiceTitle.Value ?? string.Empty).Trim();
            string location = (hfServiceLocation.Value ?? string.Empty).Trim();
            string rate = (hfServiceRate.Value ?? string.Empty).Trim();
            string tags = (hfServiceTags.Value ?? string.Empty).Trim();
            string desc = (hfServiceDesc.Value ?? string.Empty).Trim();

            if (string.IsNullOrEmpty(title))
            {
                pnlServiceApplyMessage.Visible = true;
                pnlServiceApplyMessage.CssClass = "form-alert error";
                lblServiceApplyMessage.Text = "Piliin muna ang serbisyo bago mag-request.";
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                using (SqlCommand ownerCmd = new SqlCommand(@"SELECT PostedByUserId FROM Services WHERE ServiceId = @ServiceId", conn))
                {
                    ownerCmd.Parameters.AddWithValue("@ServiceId", serviceId);
                    object ownerId = ownerCmd.ExecuteScalar();
                    if (ownerId != null && ownerId != DBNull.Value && ownerId.ToString() == Session["UserId"].ToString())
                    {
                        pnlServiceApplyMessage.Visible = true;
                        pnlServiceApplyMessage.CssClass = "form-alert error";
                        lblServiceApplyMessage.Text = "Hindi ka maaaring mag-request sa sariling listing.";
                        return;
                    }
                }

                using (SqlCommand existsCmd = new SqlCommand(@"SELECT TOP 1 RequestId, Status 
                                                               FROM ServiceRequests 
                                                               WHERE UserId = @UserId AND ServiceId = @ServiceId
                                                               ORDER BY RequestedAt DESC", conn))
                {
                    existsCmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    existsCmd.Parameters.AddWithValue("@ServiceId", serviceId);

                    using (SqlDataReader reader = existsCmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int requestId = Convert.ToInt32(reader["RequestId"]);
                            string status = reader["Status"].ToString();

                            if (string.Equals(status, "Retracted", StringComparison.OrdinalIgnoreCase))
                            {
                                reader.Close();
                                using (SqlCommand updateCmd = new SqlCommand(@"UPDATE ServiceRequests
                                                                              SET Status = 'Pending',
                                                                                  RequestedAt = GETDATE(),
                                                                                  ServiceTitle = @ServiceTitle,
                                                                                  ServiceLocation = @ServiceLocation,
                                                                                  ServiceRate = @ServiceRate,
                                                                                  ServiceTags = @ServiceTags,
                                                                                  ServiceDescription = @ServiceDescription
                                                                              WHERE RequestId = @RequestId", conn))
                                {
                                    updateCmd.Parameters.AddWithValue("@ServiceTitle", title);
                                    updateCmd.Parameters.AddWithValue("@ServiceLocation", location);
                                    updateCmd.Parameters.AddWithValue("@ServiceRate", rate);
                                    updateCmd.Parameters.AddWithValue("@ServiceTags", tags);
                                    updateCmd.Parameters.AddWithValue("@ServiceDescription", desc);
                                    updateCmd.Parameters.AddWithValue("@RequestId", requestId);
                                    updateCmd.ExecuteNonQuery();
                                }

                                pnlServiceApplyMessage.Visible = true;
                                pnlServiceApplyMessage.CssClass = "form-alert success";
                                lblServiceApplyMessage.Text = "Na-submit ulit ang inyong request.";
                                ClientScript.RegisterStartupScript(this.GetType(), "scrollServiceMsg", "window.location.hash='pnlServiceApplyMessage';", true);
                                return;
                            }

                            pnlServiceApplyMessage.Visible = true;
                            pnlServiceApplyMessage.CssClass = "form-alert error";
                            lblServiceApplyMessage.Text = "May active request ka na sa serbisyong ito.";
                            return;
                        }
                    }
                }

                using (SqlCommand cmd = new SqlCommand(@"INSERT INTO ServiceRequests
                                                         (UserId, ServiceId, ServiceTitle, ServiceLocation, ServiceRate, ServiceTags, ServiceDescription, Status, RequestedAt)
                                                         VALUES (@UserId, @ServiceId, @ServiceTitle, @ServiceLocation, @ServiceRate, @ServiceTags, @ServiceDescription, 'Pending', GETDATE())", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    cmd.Parameters.AddWithValue("@ServiceId", serviceId);
                    cmd.Parameters.AddWithValue("@ServiceTitle", title);
                    cmd.Parameters.AddWithValue("@ServiceLocation", location);
                    cmd.Parameters.AddWithValue("@ServiceRate", rate);
                    cmd.Parameters.AddWithValue("@ServiceTags", tags);
                    cmd.Parameters.AddWithValue("@ServiceDescription", desc);
                    cmd.ExecuteNonQuery();
                }
            }

            pnlServiceApplyMessage.Visible = true;
            pnlServiceApplyMessage.CssClass = "form-alert success";
            lblServiceApplyMessage.Text = "Na-submit ang inyong request. Makikita ito sa inyong profile status.";

            ClientScript.RegisterStartupScript(this.GetType(), "scrollServiceMsg", "window.location.hash='pnlServiceApplyMessage';", true);
        }
    }
}
