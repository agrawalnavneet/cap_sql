using System;
using System.Data;
using Microsoft.Data.SqlClient;

class Assig
{
    public static void assig()
    {
        string connectionString =
            "Server=localhost,1433;" +
            "Database=assignment;" +
            "User Id=sa;" +
            "Password=StrongPassword@123;" +
            "TrustServerCertificate=True;";

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();
// uses .ExecuteScalar
            string countQuery = "SELECT COUNT(*) FROM dbo.Students WHERE IsHostel = 1";
            SqlCommand countCmd = new SqlCommand(countQuery, con);

            int hostelCount = Convert.ToInt32(countCmd.ExecuteScalar());

            if (hostelCount > 5)
            { // use ExecuteNonQuery
                string deleteQuery = "DELETE FROM dbo.Students WHERE Category = 'Backlog'";
                SqlCommand deleteCmd = new SqlCommand(deleteQuery, con);

                int rows = deleteCmd.ExecuteNonQuery();
                Console.WriteLine(rows + " students deleted.");
            }
            else
            { // uses ExecuteReader
                string selectQuery = "SELECT * FROM dbo.Students";
                SqlCommand selectCmd = new SqlCommand(selectQuery, con);

                SqlDataReader reader = selectCmd.ExecuteReader();

                while (reader.Read())
                {
                    Console.WriteLine(
                        reader["Id"] + " " +
                        reader["Name"] + " " +
                        reader["Category"]
                    );
                }

                reader.Close();
            }
        }
    }
}
