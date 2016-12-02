using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

/// <summary>
/// Summary description for races
/// </summary>
public class races
{
	public races()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static Int32 GetTrackID(string trackabbrev)
    {
        //check to see if field is set and special class is graded stakes
        string sql = "SELECT id FROM tracks WHERE LTRIM(RTRIM(abbrev)) = '" + trackabbrev.Trim() + "'";
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        try
        {
            return Convert.ToInt32(ds.Tables[0].Rows[0]["id"]);
        }
        catch
        {
            return 0;
        }
        

    }

    public static string GetTrackAbbrev(Int64 raceid)
    {
        //check to see if field is set and special class is graded stakes
        string sql = "SELECT abbrev FROM tracks INNER JOIN races ON races.track = tracks.id WHERE races.id = '" + raceid + "'";
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        try
        {
            return Convert.ToString(ds.Tables[0].Rows[0]["abbrev"]);
        }
        catch
        {
            return null;
        }
    }

    public static bool IsOpen(Int64 raceid)
    {
        //check to see if field is set and special class is graded stakes
        string sql = "SELECT ropen FROM races WHERE id = '" + raceid + "'";
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);        
        try{
            return Convert.ToBoolean(ds.Tables[0].Rows[0]["ropen"]);
        }
        catch{
            return false;
            }
        
        
    }

    public static string GetSaddleClothNumber(string program)
    {
        string newString = Regex.Replace(program, "[^.0-9]", "");
        int clothnum = Convert.ToInt16(newString);
        return clothnum.ToString("00");
    }

    public static string CombineDate(DateTime dt, TimeSpan ts)
    {
        return (dt.Add(ts).ToString());
    }

    public static void BuildTournCard_RaceList(List<Int64> racelist, double prize, string tname, DateTime tdate, int maxplayers)
    {
        if (racelist.Count > 0)
        {
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
            //create tournament                        
            SqlCommand cmd = new SqlCommand("SP_AddTourn", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@tname", tname));
            cmd.Parameters.Add(new SqlParameter("@prize", prize));
            cmd.Parameters.Add(new SqlParameter("@tdate", tdate));
            cmd.Parameters.Add(new SqlParameter("@isopen", 1));
            cmd.Parameters.Add(new SqlParameter("@maxplayers", maxplayers));
            SqlParameter retValue = cmd.Parameters.Add("return", SqlDbType.Int);
            retValue.Direction = ParameterDirection.ReturnValue;
            con.Open();
                cmd.ExecuteNonQuery();
            con.Close();
            Int64 tournid = Convert.ToInt64(retValue.Value);

            foreach (Int64 r in racelist)
            {
                //create race in tourn
                string sql_race = "INSERT INTO racesintourn (tournid, raceid) VALUES ('" + tournid + "', '" + r + "')";
                SqlCommand myCommand_race = new SqlCommand(sql_race, con);
                con.Open();
                myCommand_race.ExecuteNonQuery();
                con.Close();
            }
        }
    }

    public static int GetTrackTimeOffset(Int64 trackid)
    {
        string sql = "SELECT timeoffset FROM tracks where id = '" + trackid + "'";
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        try
        {
            return Convert.ToInt16(ds.Tables[0].Rows[0]["timeoffset"]);
        }
        catch
        {
            return 0;
        }

    }
}