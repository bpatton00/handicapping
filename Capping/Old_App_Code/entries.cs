using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;

/// <summary>
/// Summary description for entries
/// </summary>
public class entries
{
	public entries()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static int GetStartCount(Int64 entryid)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        string sql = "SELECT COUNT(id) as rcount FROM pp WHERE entryid = '" + entryid + "' AND rtype <> 'SCR' ";
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        con.Close();
      
        return Convert.ToInt32(ds.Tables[0].Rows[0]["rcount"]);
    }
    public static int WinStreak(Int64 entryid)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        string sql = "SELECT posfin FROM pp WHERE entryid = '" + entryid + "' AND rtype <> 'SCR' ORDER BY rdate DESC";
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        con.Close();
        int numwins = 0;
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            if (Convert.ToInt16(dr["posfin"]) == 1) { numwins++; }
            else { return numwins; }
        }
        return numwins;
    }
    public static int LossStreak(Int64 entryid)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        string sql = "SELECT posfin FROM pp WHERE entryid = '" + entryid + "' AND rtype <> 'SCR' ORDER BY rdate DESC";
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        con.Close();
        int numloss = 0;
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            if (Convert.ToInt16(dr["posfin"]) != 1) { numloss++; }
            else { return numloss; }
        }
        return numloss;
    }
    public static bool BeatenFav(Int64 entryid)
    {
        try
        {
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
            string sql = "SELECT posfin, favorite FROM pp WHERE entryid = '" + entryid + "' AND rtype <> 'SCR' ORDER BY rdate DESC";
            SqlCommand myCommand = new SqlCommand(sql, con);
            con.Open();

            SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
            DataTable dt = new DataTable();
            dt.Load(myReader);
            DataSet ds = new DataSet();
            ds.Tables.Add(dt);
            con.Close();
            int fin = Convert.ToInt16(ds.Tables[0].Rows[0]["posfin"]);
            bool favorite = Convert.ToBoolean(ds.Tables[0].Rows[0]["favorite"]);
            if (fin > 1 && favorite) { return true; }
        }
        catch { }
        return false;
    }
    public static double GetLastRaceLengths(Int64 entryid)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        string sql = "SELECT TOP(1) lenbackfin FROM pp WHERE entryid = '" + entryid + "' AND (rtype <> 'SCR') ORDER BY rdate DESC";
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        con.Close();
        try
        {
            return Math.Round(Convert.ToDouble(ds.Tables[0].Rows[0]["lenbackfin"]) / 100, 2);
        }
        catch { return 0.0; }
    }
    public static double GetAVGSR(Int64 entryid)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        string sql = "SELECT AVG(sr) AS avgrating FROM (SELECT TOP (10) sr FROM pp WHERE (sr > 0) AND (rtype <> 'SCR') AND (entryid = '" + entryid + "') ORDER BY rdate DESC) AS derivedtbl_1";
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        con.Close();
        if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["avgrating"].ToString()))
        {
            double sr1 = Convert.ToDouble(ds.Tables[0].Rows[0]["avgrating"]);
            return sr1;
        }
        return 0;
    }
    public static double GetAVGClass(Int64 entryid)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        string sql = "SELECT AVG(classratin) AS avgrating FROM (SELECT TOP (10) classratin FROM pp WHERE (rtype <> 'SCR') AND (entryid = '" + entryid + "') ORDER BY rdate DESC) AS derivedtbl_1";
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        con.Close();
        if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["avgrating"].ToString()))
        {
            double cr1 = Convert.ToDouble(ds.Tables[0].Rows[0]["avgrating"]);
            return cr1;
        }
        return 0;
    }
    public static double GetLastSR(Int64 entryid)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        string sql = "SELECT TOP(1) SR FROM pp WHERE pp.entryid = '" + entryid + "' AND (rtype <> 'SCR') AND (sr > 0) ORDER BY rdate DESC";
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        con.Close();
        if (ds.Tables[0].Rows.Count > 0)
        {
            double sr1 = Convert.ToDouble(ds.Tables[0].Rows[0]["SR"]);
            return sr1;
        }
        return 0;
    }
    public static double GetLastRaceClass(Int64 entryid)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        string sql = "SELECT TOP(1) classratin FROM pp WHERE pp.entryid = '" + entryid + "' AND (rtype <> 'SCR') ORDER BY rdate DESC";
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        con.Close();
        if (ds.Tables[0].Rows.Count > 0)
        {
            double cr1 = Convert.ToDouble(ds.Tables[0].Rows[0]["classratin"]);
            return cr1;
        }
        return 0;
    }

    public static bool ImprovedLastTwoStarts(Int64 entryid)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        string sql = "SELECT sr FROM pp WHERE entryid = '" + entryid + "' AND rtype <> 'SCR' ORDER BY rdate DESC";
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        con.Close();
        int prevsr = 0;
        bool fastersr = true;
        int count = 0;
        while (fastersr)
        {
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                //goes backwards so have to work down
                //76
                //55
                if (Convert.ToInt16(dr["sr"]) <= prevsr - 4) { prevsr = Convert.ToInt16(dr["sr"]); count++; }
                else { fastersr = false;}
            }
            fastersr = false;
        }
        if (count >= 2) { return true; }
        return false;
    }
    public static string GetHorseName(Int64 entryid)
    {
        string name = "";
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        string sql = "SELECT name FROM entries WHERE id = '" + entryid + "' ";
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        con.Close();
        name = Convert.ToString(ds.Tables[0].Rows[0]["name"]);
        return name;
    }
    public static System.Drawing.Color SetSRColor(Int32 sr)
    {
        System.Drawing.Color clr = new System.Drawing.Color();
        if(sr >= 100) { clr = System.Drawing.Color.Red; }
        if (sr >= 85 && sr < 100) { clr = System.Drawing.Color.Orange;  }
        if (sr >= 70 && sr < 85) { clr = (Color)System.Drawing.ColorTranslator.FromHtml("#666666"); ; }
        if (sr < 70) { clr = System.Drawing.Color.Blue;  }


        return clr;
    }
}