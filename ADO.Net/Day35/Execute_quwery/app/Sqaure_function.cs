using System;
using Microsoft.Data.SqlClient;

class Square
{
    public static void square()
    {
        string cs =
            "Data Source=localhost,1433;" +
            "Initial Catalog=SquareDB;" +
            "User Id=sa;" +
            "Password=StrongPassword@123;" +
            "TrustServerCertificate=True;";

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            SqlCommand cmd =
                new SqlCommand("SELECT dbo.SquareNumber(@num)", con);

            cmd.Parameters.AddWithValue("@num", 6);

            int result = (int)cmd.ExecuteScalar();

            Console.WriteLine("Square = " + result);
        }
    }
}
