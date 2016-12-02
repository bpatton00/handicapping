using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;


/// <summary>
/// Summary description for handicapping
/// </summary>
public class handicapping
{
	public handicapping()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static void CalculateExoticsData(Int64 raceid)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        //get the entries for each race 
        string sql = "SELECT entries.name, entries.post, entries.ccrank, entries.ccpoints, entries.livelongshot, entries.ccscore, entry_results.finish, entry_results.finalodds, races.exacta, races.trifecta FROM entries INNER JOIN entry_results ON entries.id = entry_results.entryid INNER JOIN races ON entries.raceid = races.id AND entry_results.raceid = races.id INNER JOIN tracks ON races.track = tracks.id WHERE (entry_results.finish <= 4) AND (entry_results.raceid = '" + raceid + "') ORDER BY entries.raceid, entry_results.finish";
            SqlCommand myCommand = new SqlCommand(sql, con);
            con.Open();

            SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
            DataTable dt = new DataTable();
            dt.Load(myReader);
            DataSet ds = new DataSet();
            ds.Tables.Add(dt);
            con.Close();


            string sql_upd = "";
            if (Convert.ToDouble(ds.Tables[0].Rows[0]["exacta"]) > 0)
            {
                //perfect ex
                if (Convert.ToInt16(ds.Tables[0].Rows[0]["ccrank"]) == 1 && Convert.ToInt16(ds.Tables[0].Rows[1]["ccrank"]) == 2)
                {
                    sql_upd = "UPDATE races SET ex_cold = 1 WHERE id = '" + raceid + "'";
                    SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                    con.Open();
                    myCommand_upd.ExecuteNonQuery();
                    con.Close();
                }
                //ex box
                if (Convert.ToInt16(ds.Tables[0].Rows[0]["ccrank"]) <= 2 && Convert.ToInt16(ds.Tables[0].Rows[1]["ccrank"]) <= 2)
                {
                    sql_upd = "UPDATE races SET ex_box = 1 WHERE id = '" + raceid + "'";
                    SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                    con.Open();
                    myCommand_upd.ExecuteNonQuery();
                    con.Close();
                }
                //ex box + 1
                if (Convert.ToInt16(ds.Tables[0].Rows[0]["ccrank"]) <= 3 && Convert.ToInt16(ds.Tables[0].Rows[1]["ccrank"]) <= 3)
                {
                    sql_upd = "UPDATE races SET ex_boxplusone = 1 WHERE id = '" + raceid + "'";
                    SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                    con.Open();
                    myCommand_upd.ExecuteNonQuery();
                    con.Close();
                }
            }
            if (Convert.ToDouble(ds.Tables[0].Rows[0]["trifecta"]) > 0)
            {
                //perfect tri
                if (Convert.ToInt16(ds.Tables[0].Rows[0]["ccrank"]) == 1 && Convert.ToInt16(ds.Tables[0].Rows[1]["ccrank"]) == 2 && Convert.ToInt16(ds.Tables[0].Rows[2]["ccrank"]) == 3)
                {
                    sql_upd = "UPDATE races SET tri_cold = 1 WHERE id = '" + raceid + "'";
                    SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                    con.Open();
                    myCommand_upd.ExecuteNonQuery();
                    con.Close();
                }

                //tri box
                if (Convert.ToInt16(ds.Tables[0].Rows[0]["ccrank"]) <= 3 && Convert.ToInt16(ds.Tables[0].Rows[1]["ccrank"]) <= 3 && Convert.ToInt16(ds.Tables[0].Rows[2]["ccrank"]) <= 3)
                {
                    sql_upd = "UPDATE races SET tri_box = 1 WHERE id = '" + raceid + "'";
                    SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                    con.Open();
                    myCommand_upd.ExecuteNonQuery();
                    con.Close();
                }

                //tri box + 1
                if (Convert.ToInt16(ds.Tables[0].Rows[0]["ccrank"]) <= 4 && Convert.ToInt16(ds.Tables[0].Rows[1]["ccrank"]) <= 4 && Convert.ToInt16(ds.Tables[0].Rows[2]["ccrank"]) <= 4)
                {
                    sql_upd = "UPDATE races SET tri_boxplusone = 1 WHERE id = '" + raceid + "'";
                    SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                    con.Open();
                    myCommand_upd.ExecuteNonQuery();
                    con.Close();
                }
            }
        

    }

    public static void CalculateExoticsData_ByTrack(string abbrev)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        //loop through ALL results from the specified track
        string sql_races = "SELECT DISTINCT raceid FROM entry_results INNER JOIN races ON races.id = entry_results.raceid INNER JOIN tracks ON tracks.id = races.track WHERE abbrev = '" + abbrev + "'";
        SqlCommand myCommand_races = new SqlCommand(sql_races, con);
        con.Open();

        SqlDataReader myReader_races = myCommand_races.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt_races = new DataTable();
        dt_races.Load(myReader_races);
        DataSet ds_races = new DataSet();
        ds_races.Tables.Add(dt_races);
        con.Close();

        foreach (DataRow dr_race in ds_races.Tables[0].Rows)
        {
            //get the entries for each race 
            string sql = "SELECT entries.name, entries.post, entries.ccrank, entries.ccpoints, entries.livelongshot, entries.ccscore, entry_results.finish, entry_results.finalodds, races.exacta, races.trifecta FROM entries INNER JOIN entry_results ON entries.id = entry_results.entryid INNER JOIN races ON entries.raceid = races.id AND entry_results.raceid = races.id INNER JOIN tracks ON races.track = tracks.id WHERE (entry_results.finish <= 4) AND (entry_results.raceid = '" + dr_race["raceid"] + "') ORDER BY entries.raceid, entry_results.finish";
            SqlCommand myCommand = new SqlCommand(sql, con);
            con.Open();

            SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
            DataTable dt = new DataTable();
            dt.Load(myReader);
            DataSet ds = new DataSet();
            ds.Tables.Add(dt);
            con.Close();


            string sql_upd = "";
            if (Convert.ToDouble(ds.Tables[0].Rows[0]["exacta"]) > 0)
            {
                //perfect ex
                if (Convert.ToInt16(ds.Tables[0].Rows[0]["ccrank"]) == 1 && Convert.ToInt16(ds.Tables[0].Rows[1]["ccrank"]) == 2)
                {
                    sql_upd = "UPDATE races SET ex_cold = 1 WHERE id = '" + dr_race["raceid"] + "'";
                    SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                    con.Open();
                    myCommand_upd.ExecuteNonQuery();
                    con.Close();
                }
                //ex box
                if (Convert.ToInt16(ds.Tables[0].Rows[0]["ccrank"]) <= 2 && Convert.ToInt16(ds.Tables[0].Rows[1]["ccrank"]) <= 2)
                {
                    sql_upd = "UPDATE races SET ex_box = 1 WHERE id = '" + dr_race["raceid"] + "'";
                    SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                    con.Open();
                    myCommand_upd.ExecuteNonQuery();
                    con.Close();
                }
                //ex box + 1
                if (Convert.ToInt16(ds.Tables[0].Rows[0]["ccrank"]) <= 3 && Convert.ToInt16(ds.Tables[0].Rows[1]["ccrank"]) <= 3)
                {
                    sql_upd = "UPDATE races SET ex_boxplusone = 1 WHERE id = '" + dr_race["raceid"] + "'";
                    SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                    con.Open();
                    myCommand_upd.ExecuteNonQuery();
                    con.Close();
                }
            }
            if (Convert.ToDouble(ds.Tables[0].Rows[0]["trifecta"]) > 0)
            {
                //perfect tri
                if (Convert.ToInt16(ds.Tables[0].Rows[0]["ccrank"]) == 1 && Convert.ToInt16(ds.Tables[0].Rows[1]["ccrank"]) == 2 && Convert.ToInt16(ds.Tables[0].Rows[2]["ccrank"]) == 3)
                {
                    sql_upd = "UPDATE races SET tri_cold = 1 WHERE id = '" + dr_race["raceid"] + "'";
                    SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                    con.Open();
                    myCommand_upd.ExecuteNonQuery();
                    con.Close();
                }

                //tri box
                if (Convert.ToInt16(ds.Tables[0].Rows[0]["ccrank"]) <= 3 && Convert.ToInt16(ds.Tables[0].Rows[1]["ccrank"]) <= 3 && Convert.ToInt16(ds.Tables[0].Rows[2]["ccrank"]) <= 3)
                {
                    sql_upd = "UPDATE races SET tri_box = 1 WHERE id = '" + dr_race["raceid"] + "'";
                    SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                    con.Open();
                    myCommand_upd.ExecuteNonQuery();
                    con.Close();
                }

                //tri box + 1
                if (Convert.ToInt16(ds.Tables[0].Rows[0]["ccrank"]) <= 4 && Convert.ToInt16(ds.Tables[0].Rows[1]["ccrank"]) <= 4 && Convert.ToInt16(ds.Tables[0].Rows[2]["ccrank"]) <= 4)
                {
                    sql_upd = "UPDATE races SET tri_boxplusone = 1 WHERE id = '" + dr_race["raceid"] + "'";
                    SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                    con.Open();
                    myCommand_upd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }

    }

    public static double GetAccuracy(Int64 raceid, bool strong, int ccrank)
    {
        double acc = 0;
        double ccscore = 1.0;
        try {         
        if (strong) { ccscore = .19; }
        //check accuracy of picks based on strength, ccrank, and track
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        //first get track the race is being held at
        string abbrev = races.GetTrackAbbrev(raceid);
        string sql = "SELECT COUNT(DISTINCT races.id) as races, SUM(CASE WHEN (officialfinish = 1 AND entries.ccrank = '" + ccrank + "') THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN ccscore >= '" + ccscore + "' and ccrank = '" + ccrank + "' THEN 1 ELSE 0 END) as strong_races, SUM(CASE WHEN (officialfinish = 1 AND entries.ccrank = '" + ccrank + "' AND entries.ccscore >= '" + ccscore + "') THEN 1 ELSE 0 END) as strong_winners, SUM(CASE WHEN (officialfinish <= 3 AND entries.ccrank = '" + ccrank + "') THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN entry_results.officialfinish = 1 AND ccrank = '" + ccrank + "' THEN entry_results.winpayoff ELSE 0 END) as winpays, SUM(CASE WHEN entry_results.officialfinish <= 1 AND ccrank = '" + ccrank + "' THEN (entry_results.winpayoff + entry_results.placepayoff + entry_results.showpayoff) ELSE 0 END) as boardpays, SUM(CASE WHEN entry_results.officialfinish = 1 AND ccrank = '" + ccrank + "' AND ccscore >= '" + ccscore + "' THEN entry_results.winpayoff ELSE 0 END) as strong_toppick_winpays, SUM(CASE WHEN entry_results.officialfinish <= 1 AND ccrank = '" + ccrank + "' AND ccscore >= '" + ccscore + "' THEN (entry_results.winpayoff + entry_results.placepayoff + entry_results.showpayoff) ELSE 0 END) as strong_toppick_boardpays FROM entry_results INNER JOIN entries ON entries.id = entry_results.entryid INNER JOIN races ON entries.raceid = races.id INNER JOIN tracks on races.track = tracks.id WHERE tracks.abbrev = '" + abbrev + "' GROUP BY tracks.abbrev ";
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        con.Close();
        if (!strong) { acc = Math.Round(Convert.ToDouble(ds.Tables[0].Rows[0]["winners"]) / Convert.ToDouble(ds.Tables[0].Rows[0]["races"]),2); }
        if (strong) { acc = Math.Round(Convert.ToDouble(ds.Tables[0].Rows[0]["strong_winners"]) / Convert.ToDouble(ds.Tables[0].Rows[0]["strong_races"]),2); }
        }
        catch { }
        return acc;
    }

    public static double GetTopAvgClass(Int64 raceid)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        string sql = "SELECT TOP (1) e.name, e.program, races.rdate, races.rtime, tracks.abbrev, races.rnum, (SELECT AVG(classratin) AS Expr1 FROM (SELECT TOP (10) classratin FROM pp WHERE (rtype <> 'SCR') AND (entryid = e.id) ORDER BY rdate DESC) AS derivedtbl_1) AS avgclass FROM entries AS e INNER JOIN races ON e.raceid = races.id INNER JOIN tracks ON tracks.id = races.track WHERE (e.raceid = '" + raceid + "') AND (e.scratched = 'False') ORDER BY avgclass DESC";
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
            try
            {
                double cl1 = Convert.ToDouble(ds.Tables[0].Rows[0]["avgclass"]);
                return cl1;
            }
            catch { return 0; }
        }
        return 0;
    }

    public static double GetTopAvgSR(Int64 raceid)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        string sql = "SELECT TOP (1) e.name, e.program, races.rdate, races.rtime, tracks.abbrev, races.rnum, (SELECT AVG(sr) AS Expr1 FROM (SELECT TOP (10) sr FROM pp WHERE (sr > 0) AND (rtype <> 'SCR') AND (entryid = e.id) ORDER BY rdate DESC) AS derivedtbl_1) AS avgrating FROM entries AS e INNER JOIN races ON e.raceid = races.id INNER JOIN tracks ON tracks.id = races.track WHERE (e.raceid = '" + raceid + "') AND (e.scratched = 'False') ORDER BY avgrating DESC";
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
            try
            {
                double sr1 = Convert.ToDouble(ds.Tables[0].Rows[0]["avgrating"]);
                return sr1;
            }
            catch { return 0; }
        }
        return 0;
    }

    public static double GetTopLastSR(Int64 raceid)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        string sql = "SELECT TOP (1) *, (SELECT name FROM entries WHERE entries.id = entryid) AS name, (SELECT program FROM entries WHERE entries.id = entryid) AS program FROM (SELECT ROW_NUMBER() OVER (PARTITION BY ENTRYID ORDER BY rdate DESC) AS RowNum, SR, rdate, entryid FROM pp WHERE entryid IN (SELECT id FROM entries WHERE raceid = '" + raceid + "') AND (rtype <> 'SCR')) mytable WHERE rownum < 2 ORDER BY SR DESC";
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
            try
            {
                double sr1 = Convert.ToDouble(ds.Tables[0].Rows[0]["SR"]);
                return sr1;
            }
            catch { return 0; }
        }
        return 0;
    }

}