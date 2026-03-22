using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace GROUP6_ANGAT
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool isLoggedIn = Session["UserId"] != null;
            phLoggedIn.Visible = isLoggedIn;
            phLoggedOut.Visible = !isLoggedIn;
            phSideLoggedIn.Visible = isLoggedIn;
            phSideLoggedOut.Visible = !isLoggedIn;

            if (isLoggedIn)
            {
                MarkNotificationAsReadFromQuery();
                LoadNotifications();
            }
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/");
        }

        private void MarkNotificationAsReadFromQuery()
        {
            if (Session["UserId"] == null)
            {
                return;
            }

            int notificationId;
            if (!int.TryParse(Request.QueryString["notifId"], out notificationId))
            {
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                    UPDATE Notifications
                    SET IsRead = 1
                    WHERE NotificationId = @NotificationId
                    AND UserId = @UserId
                    AND IsRead = 0", conn))
            {
                cmd.Parameters.AddWithValue("@NotificationId", notificationId);
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }


        protected void BtnMarkAllNotifRead_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(@"
                UPDATE Notifications
                SET IsRead = 1
                WHERE UserId = @UserId AND IsRead = 0", conn))
            {
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            LoadNotifications();
        }
        protected void TmrNotifications_Tick(object sender, EventArgs e)
        {
            LoadNotifications();
        }
        protected string ResolveNotificationUrl(object notificationIdObj, object targetUrlObj)
        {
            string targetUrl = targetUrlObj == null ? "" : targetUrlObj.ToString().Trim();

            if (string.IsNullOrWhiteSpace(targetUrl))
            {
                targetUrl = "~/Pages/Profile.aspx";
            }

            int notificationId;
            if (notificationIdObj != null && int.TryParse(notificationIdObj.ToString(), out notificationId))
            {
                string separator = targetUrl.Contains("?") ? "&" : "?";
                targetUrl = targetUrl + separator + "notifId=" + notificationId;
            }

            return ResolveUrl(targetUrl);
        }



        protected string GetNotificationItemClass(object isReadObj)
        {
            bool isRead = false;

            if (isReadObj != null)
            {
                bool.TryParse(isReadObj.ToString(), out isRead);
            }

            return isRead ? "read" : "unread";
        }

        protected string GetRelativeNotificationTime(object createdAtObj)
        {
            DateTime createdAt;

            if (createdAtObj == null || !DateTime.TryParse(createdAtObj.ToString(), out createdAt))
            {
                return string.Empty;
            }

            TimeSpan ts = DateTime.UtcNow - createdAt;

            if (ts.TotalMinutes < 1)
                return "Ngayon lang";
            if (ts.TotalHours < 1)
                return Math.Max(1, (int)Math.Floor(ts.TotalMinutes)) + " min ago";
            if (ts.TotalDays < 1)
                return Math.Max(1, (int)Math.Floor(ts.TotalHours)) + " hr ago";
            if (ts.TotalDays < 7)
                return Math.Max(1, (int)Math.Floor(ts.TotalDays)) + " day ago";

            return createdAt.AddHours(8).ToString("MMM dd");
        }

        private void LoadNotifications()
        {
            if (Session["UserId"] == null)
            {
                return;
            }

            DataTable notifications = new DataTable();
            int unreadCount = 0;
            string connString = ConfigurationManager.ConnectionStrings["AngatDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                using (SqlCommand countCmd = new SqlCommand(@"
                    SELECT COUNT(*)
                    FROM Notifications
                    WHERE UserId = @UserId AND IsRead = 0", conn))
                {
                    countCmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    unreadCount = Convert.ToInt32(countCmd.ExecuteScalar());
                }

                using (SqlCommand listCmd = new SqlCommand(@"
                    SELECT NotificationId, Title, Message, NotificationType, TargetUrl, IsRead, CreatedAt
                    FROM Notifications
                    WHERE UserId = @UserId
                    ORDER BY CreatedAt DESC", conn))
                {
                    listCmd.Parameters.AddWithValue("@UserId", Session["UserId"]);
                    using (SqlDataAdapter adapter = new SqlDataAdapter(listCmd))
                    {
                        adapter.Fill(notifications);
                    }
                }
            }

            phUnreadBadge.Visible = unreadCount > 0;
            lblUnread.Text = unreadCount > 9 ? "9+" : unreadCount.ToString();
            lblNotificationSummary.Text = unreadCount > 0
                ? unreadCount + " unread notification" + (unreadCount == 1 ? "" : "s")
                : "Latest account updates";

            btnMarkAllNotifRead.Visible = unreadCount > 0;
            pnlNoNotifications.Visible = notifications.Rows.Count == 0;
            rptNotifications.DataSource = notifications;
            rptNotifications.DataBind();
        }
    }
}
