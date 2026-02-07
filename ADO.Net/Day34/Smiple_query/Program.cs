using System;
using System.Data;
using Microsoft.Data.SqlClient;

class Program
{
    static void Main()
    {
        // Connection string (for SQL Server running on Docker / remote)
        string connectionString =
            "Data Source=localhost,1433;" +
            "Initial Catalog=Simple_query;" +
            "User Id=sa;" +
            "Password=StrongPassword@123;" +
            "TrustServerCertificate=True;";

        try
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                Console.WriteLine("Connection successful!");

                using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("sp_GetGenderCoun", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                
                cmd.Parameters.AddWithValue("@Gender", "Male");

             
                SqlParameter outParam = new SqlParameter("@TC", SqlDbType.Int);
                outParam.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(outParam);

                con.Open();
                cmd.ExecuteScalar();

                int total = Convert.ToInt32(cmd.Parameters["@TC"].Value);
                Console.WriteLine("Total Count: " + total);
            }
            }
        }
        catch (SqlException ex)
        {
            Console.WriteLine("SQL Error: " + ex.Message);
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.Message);
        }

        Console.WriteLine("Connection closed.");
    }
}
