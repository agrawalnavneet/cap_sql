using System;
using System.Data;
using Microsoft.Data.SqlClient;

class CRUD
{
    public static void crud()
    {
        string connectionString =
            "Server=localhost,1433;" +
            "Database=LPU;" +
            "User Id=sa;" +
            "Password=StrongPassword@123;" +
            "TrustServerCertificate=True;";

        DataSet ds = new DataSet();

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();

            SqlDataAdapter da = new SqlDataAdapter("sp_GetStudents", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;

            // CommandBuilder (AUTO insert/update/delete)
            SqlCommandBuilder cb = new SqlCommandBuilder(da);

            // READ
            da.Fill(ds, "Students");

            DataTable dt = ds.Tables["Students"]!;

            // CREATE
            DataRow newRow = dt.NewRow();
            newRow["Name"] = "Arun";
            newRow["Department"] = "IT";
            dt.Rows.Add(newRow);

            // UPDATE
            if (dt.Rows.Count > 0)
                dt.Rows[0]["Department"] = "CSE";

            // DELETE
            if (dt.Rows.Count > 1)
                dt.Rows[1].Delete();

            // SAVE ALL CHANGES TO DATABASE
            da.Update(dt);
        }

        Console.WriteLine("CRUD operations completed successfully");
    }
}
