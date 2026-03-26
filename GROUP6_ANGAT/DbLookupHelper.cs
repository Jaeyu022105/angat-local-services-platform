using System;
using System.Data;
using System.Data.SqlClient;

namespace GROUP6_ANGAT {
    public static class DbLookupHelper {
        private static SqlCommand CreateCommand(SqlConnection conn, SqlTransaction tx, string sql) {
            return tx == null ? new SqlCommand(sql, conn) : new SqlCommand(sql, conn, tx);
        }

        public static int EnsureBarangayId(SqlConnection conn, SqlTransaction tx, string barangayName) {
            string name = (barangayName ?? "").Trim();
            if (string.IsNullOrEmpty(name)) name = "Unknown";
            using (SqlCommand cmd = CreateCommand(conn, tx, @"
                IF NOT EXISTS (SELECT 1 FROM Barangays WHERE BarangayName = @Name)
                    INSERT INTO Barangays (BarangayName) VALUES (@Name);
                SELECT BarangayId FROM Barangays WHERE BarangayName = @Name;")) {
                cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 80).Value = name;
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        public static int EnsureCategoryId(SqlConnection conn, SqlTransaction tx, string categoryName, string categoryType) {
            string name = (categoryName ?? "").Trim();
            string type = (categoryType ?? "").Trim();
            if (string.IsNullOrEmpty(name)) name = "Unknown";
            if (string.IsNullOrEmpty(type)) type = "General";
            using (SqlCommand cmd = CreateCommand(conn, tx, @"
                IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = @Name AND CategoryType = @Type)
                    INSERT INTO Categories (CategoryName, CategoryType) VALUES (@Name, @Type);
                SELECT CategoryId FROM Categories WHERE CategoryName = @Name AND CategoryType = @Type;")) {
                cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 60).Value = name;
                cmd.Parameters.Add("@Type", SqlDbType.NVarChar, 20).Value = type;
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        public static int EnsureRateTypeId(SqlConnection conn, SqlTransaction tx, string rateLabel, string rateContext) {
            string label = (rateLabel ?? "").Trim();
            string context = (rateContext ?? "").Trim();
            if (string.IsNullOrEmpty(label)) label = "per day";
            if (string.IsNullOrEmpty(context)) context = "General";
            using (SqlCommand cmd = CreateCommand(conn, tx, @"
                IF NOT EXISTS (SELECT 1 FROM RateTypes WHERE RateLabel = @Label AND RateContext = @Context)
                    INSERT INTO RateTypes (RateLabel, RateContext) VALUES (@Label, @Context);
                SELECT RateTypeId FROM RateTypes WHERE RateLabel = @Label AND RateContext = @Context;")) {
                cmd.Parameters.Add("@Label", SqlDbType.NVarChar, 20).Value = label;
                cmd.Parameters.Add("@Context", SqlDbType.NVarChar, 20).Value = context;
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        public static int EnsureRoleId(SqlConnection conn, SqlTransaction tx, string roleName) {
            string name = (roleName ?? "").Trim();
            if (string.IsNullOrEmpty(name)) name = "User";
            using (SqlCommand cmd = CreateCommand(conn, tx, @"
                IF NOT EXISTS (SELECT 1 FROM Roles WHERE RoleName = @Name)
                    INSERT INTO Roles (RoleName) VALUES (@Name);
                SELECT RoleId FROM Roles WHERE RoleName = @Name;")) {
                cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 20).Value = name;
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }
    }
}
