using System;
using System.Data;
using Microsoft.Data.SqlClient;

class EXEC
{
    public static void exec()
    {
        string connectionString =
            "Data Source=localhost,1433;" +
            "Initial Catalog=execute_non_query;" +
            "User Id=sa;" +
            "Password=StrongPassword@123;" +
            "TrustServerCertificate=True;";

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                using (SqlCommand cmd = new SqlCommand("dbo.InsertStudent", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Id", 1);
                    cmd.Parameters.AddWithValue("@Name", "Navneet");
                    cmd.Parameters.AddWithValue("@Age", 22);

                    int rows = cmd.ExecuteNonQuery();
                    Console.WriteLine("Rows affected: " + rows);
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.Message);
        }
    }
}
