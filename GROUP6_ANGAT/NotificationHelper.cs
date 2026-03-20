using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace GROUP6_ANGAT
{
    public static class NotificationHelper
    {
        public static bool TryCreateNotification(SqlConnection conn, int userId, string title, string message, string type, string targetUrl)
        {
            if(conn == null) 
                throw new ArgumentNullException(nameof(conn));

            if (userId <= 0 || string.IsNullOrWhiteSpace(title) || string.IsNullOrWhiteSpace(message))
            {
                return false;
            }

            bool openedHere = false;

            if(conn.State!= ConnectionState.Open)
            {
                conn.Open();
                openedHere=true;
            }
            try
            {
                using (SqlCommand cmd = new SqlCommand(@"INSERT INTO Notifications
                    (UserId, Title, Message, NotificationType, TargetUrl, IsRead, CreatedAt)
                    VALUES (@UserId, @Title, @Message, @NotificationType, @TargetUrl, 0, GETDATE())", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@Title", TrimTo(title, 120));
                    cmd.Parameters.AddWithValue("@Message", TrimTo(message, 300));
                    cmd.Parameters.AddWithValue("@NotificationType", TrimTo(type, 50));
                    cmd.Parameters.AddWithValue("@TargetUrl", TrimTo(string.IsNullOrWhiteSpace(targetUrl) ? "~/Pages/Profile.aspx" : targetUrl, 260));
                    cmd.ExecuteNonQuery();
                    return true;
                }
            }
            finally
            {
                if (openedHere)
                {
                    conn.Close();
                }
            }
        }
        private static string TrimTo(string value, int maxLength)
        {
            string safe = value ?? string.Empty;
            return safe.Length <= maxLength ? safe : safe.Substring(0, maxLength);
        }
    }
}