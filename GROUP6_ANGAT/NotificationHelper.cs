using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;

namespace GROUP6_ANGAT
{
    public static class NotificationHelper
    {
        public static void TryCreateNotification(
            SqlConnection conn,
            int userId,
            string title,
            string message,
            string notificationType,
            string targetUrl)
        {
            if (conn == null) 
                return;
            if (conn.State != ConnectionState.Open) return;

            if (userId <= 0) return;
            if (string.IsNullOrWhiteSpace(title) || string.IsNullOrWhiteSpace(message)) return;

            using (SqlCommand cmd = new SqlCommand(@"
                INSERT INTO Notifications
                (UserId, Title, Message, NotificationType, TargetUrl, IsRead, CreatedAt)
                VALUES
                (@UserId, @Title, @Message, @NotificationType, @TargetUrl, 0, GETDATE())", conn))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.Parameters.AddWithValue("@Title", title.Trim());
                cmd.Parameters.AddWithValue("@Message", message.Trim());
                cmd.Parameters.AddWithValue("@NotificationType",
                    string.IsNullOrWhiteSpace(notificationType) ? "general" : notificationType.Trim());
                cmd.Parameters.AddWithValue("@TargetUrl",
                    string.IsNullOrWhiteSpace(targetUrl) ? (object)DBNull.Value : targetUrl.Trim());

                cmd.ExecuteNonQuery();
            }
        }
    }
}
