using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for user_functions
/// </summary>
public class user_functions
{
    public static int maxentries = 1;

	public user_functions()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static int Tourn_NumEntries(string userid, Int64 tournid)
    {
        string sql = "SELECT id FROM tourn_entry WHERE userid = '" + userid + "' AND tournid = '" + tournid + "'";
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        int entries = ds.Tables[0].Rows.Count;
        try
        {
            return entries;
        }
        catch
        {
            return 0;
        }
    }

    public static string GetTournamentName(Int64 tournid)
    {
        string sql = "SELECT name FROM tournaments WHERE id = '" + tournid + "'";
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        return ds.Tables[0].Rows[0]["name"].ToString();
    }

    public static bool EnterTourn(string userid, Int64 tournid)
    {
        if (Tourn_NumEntries(userid, tournid) < maxentries)
        {
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
            string sql = "INSERT INTO tourn_entry (userid, tournid) VALUES ('" + userid + "', '" + tournid + "') ";
            SqlCommand myCommand = new SqlCommand(sql, con);
            con.Open();
            myCommand.ExecuteNonQuery();
            con.Close();

            return true;
        }

        return false;
    }

    public static string SaveSelection(string userid, Int64 tournid, Int64 raceid, Int64 tourn_entry , int program, Int64 entryid)
    {

        //first check to see if user already has a pick for this race/tourn -- if so, update, else insert
        try
        {
            if (UserHasMadePick(userid, tournid, raceid, tourn_entry))
            {
                SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
                string sql = "UPDATE picks SET program = '" + program + "', raceid = '" + raceid + "', userid = '" + userid + "', tourn_entry = '" + tourn_entry + "', entryid = '" + entryid + "' WHERE raceid = '" + raceid + "' AND userid = '" + userid + "' AND tourn_entry = '" + tourn_entry + "' ";
                SqlCommand myCommand = new SqlCommand(sql, con);
                con.Open();
                myCommand.ExecuteNonQuery();
                con.Close();
                return "Your picks have been updated." ;
            }
            else
            {
                SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
                string sql = "INSERT INTO picks (program, raceid, userid, tourn_entry, entryid) VALUES ('" + program + "', '" + raceid + "', '" + userid + "', '" + tourn_entry + "', '" + entryid + "') ";
                SqlCommand myCommand = new SqlCommand(sql, con);
                con.Open();
                myCommand.ExecuteNonQuery();
                con.Close();
                return "Your picks have been saved.";
            }
           
        }
        catch (Exception ex) { return ex.ToString(); }
    }

    public static bool UserHasMadePick(string userid, Int64 tournid, Int64 raceid, Int64 tourn_entry)
    {
        try
        {
            string sql = "SELECT id FROM picks WHERE raceid = '" + raceid + "' AND userid = '" + userid + "' AND tourn_entry = '" + tourn_entry + "'";
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
            SqlCommand myCommand = new SqlCommand(sql, con);
            con.Open();

            SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
            DataTable dt = new DataTable();
            dt.Load(myReader);
            DataSet ds = new DataSet();
            ds.Tables.Add(dt);
            if (ds.Tables[0].Rows.Count > 0)
            {
                return true;
            }
            else { return false; }
        }
        catch { }

        return false;
    }

    public static int ProgramSelected(string userid, Int64 tournid, Int64 raceid, Int64 tourn_entry)
    {
        string sql = "SELECT * FROM picks WHERE raceid = '" + raceid + "' AND userid = '" + userid + "' AND tourn_entry = '" + tourn_entry + "'";
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        if (ds.Tables[0].Rows.Count > 0)
        {
            int post = Convert.ToInt32(ds.Tables[0].Rows[0]["program"]);

            return post;
        }
        else { return 0; }
    }

    public static int GetTimeOffset(string userid)
    {
        string sql = "SELECT timezoneoffset FROM aspnet_Membership WHERE userid = '" + userid + "' ";
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        try { return Convert.ToInt16(ds.Tables[0].Rows[0]["timezoneoffset"]); }
        catch { return 0;}
    }
}