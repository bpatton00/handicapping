using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.Security;

public partial class ascx_bestbets : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int hcount = 0;
        int tcount = 0;
        int rcount = 0;
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        //loop through all races in the next 48 hours
        string sql_races = "SELECT races.id, races.rdate, races.rtime, races.rnum, races.todays_cls, tracks.abbrev, tracks.id as trackid FROM races INNER JOIN tracks on tracks.id = races.track WHERE (CONVERT(date, races.rdate, 101) <= CONVERT(date, DATEADD(day, 1, GETDATE()), 101)) AND (CONVERT(date, races.rdate, 101) >= CONVERT(date, GETDATE(), 101)) ORDER BY rdate, rtime ";
        SqlCommand myCommand_races = new SqlCommand(sql_races, con);
        con.Open();

        SqlDataReader myReader_races = myCommand_races.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt_races = new DataTable();
        dt_races.Load(myReader_races);
        DataSet ds_races = new DataSet();
        ds_races.Tables.Add(dt_races);
        con.Close();
        DataTable DisplayTable = new DataTable();
        DisplayTable.Columns.AddRange(new DataColumn[8] { new DataColumn("Date", typeof(string)), new DataColumn("Time", typeof(string)), new DataColumn("Race", typeof(string)), new DataColumn("Horse", typeof(string)), new DataColumn("Odds", typeof(string)), new DataColumn("Rank", typeof(string)), new DataColumn("Strength", typeof(string)), new DataColumn("Accuracy", typeof(string)) });


        foreach (DataRow dr_races in ds_races.Tables[0].Rows)
        {
            rcount++;
            string sql_entries = "SELECT entries.* FROM pp INNER JOIN entries ON pp.id = entries.id INNER JOIN races ON races.id = entries.raceid WHERE (raceid = '" + dr_races["id"] + "') AND (scratched = 'False') AND (ccrank <= 2) AND (ccscore >= .10) ";
            SqlCommand myCommand_entries = new SqlCommand(sql_entries, con);
            con.Open();

            SqlDataReader myReader_entries = myCommand_entries.ExecuteReader(CommandBehavior.CloseConnection);
            DataTable dt_entries = new DataTable();
            dt_entries.Load(myReader_entries);
            DataSet ds_entries = new DataSet();
            ds_entries.Tables.Add(dt_entries);
            con.Close();
            foreach (DataRow dr_entry in ds_entries.Tables[0].Rows)
            {
                tcount++;
                double odds = shared.FracToDouble(dr_entry["morningline"].ToString());
                int ccrank = Convert.ToInt16(dr_entry["ccrank"]);
                double ccscore = Convert.ToDouble(dr_entry["ccscore"]);
                if (odds >= 5 )
                {
                    hcount++;
                    DateTime rdate = Convert.ToDateTime(dr_races["rdate"]);
                    TimeSpan timespan = (TimeSpan)dr_races["rtime"];
                    DateTime time = DateTime.Today.Add(timespan);
                    DateTime convertedtime = shared.ConvertDateTimeToLocalTime(time, Convert.ToInt64(dr_races["trackid"]), user_functions.GetTimeOffset(Membership.GetUser().ProviderUserKey.ToString()));
                    string displayTime = convertedtime.ToString("h:mm tt"); // It will give "03:00 AM"
                    double accuracy = handicapping.GetAccuracy(Convert.ToInt64(dr_races["id"]), false, ccrank);                    
                    DisplayTable.Rows.Add(rdate.ToShortDateString(), displayTime, dr_races["abbrev"].ToString() + " #" + dr_races["rnum"].ToString(), dr_entry["name"].ToString(), dr_entry["morningline"], ccrank, ccscore.ToString("p0"), accuracy.ToString("p0"));                    
                }
            }
        }
        GridViewBBets.DataSource = DisplayTable;
        GridViewBBets.DataBind();

        LabelNumAnalyzed.Text = "Price horses analyzed: " + hcount + "(" + tcount + ") <br/>Races analyzed: " + rcount;
    }


    //old code, this has been superceded by rank.cs which now does all the same functions
    protected void RemovedAnalysis()
    {
        int hcount = 0;
        int tcount = 0;
        int rcount = 0;
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        //loop through all races in the next 48 hours
        string sql_races = "SELECT races.id, races.rdate, races.rtime, races.rnum, races.todays_cls, tracks.abbrev, tracks.id as trackid FROM races INNER JOIN tracks on tracks.id = races.track WHERE (CONVERT(date, races.rdate, 101) <= CONVERT(date, DATEADD(day, 1, GETDATE()), 101)) AND (CONVERT(date, races.rdate, 101) >= CONVERT(date, GETDATE(), 101)) ORDER BY rdate, rtime ";
        SqlCommand myCommand_races = new SqlCommand(sql_races, con);
        con.Open();

        SqlDataReader myReader_races = myCommand_races.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt_races = new DataTable();
        dt_races.Load(myReader_races);
        DataSet ds_races = new DataSet();
        ds_races.Tables.Add(dt_races);
        con.Close();
        DataTable DisplayTable = new DataTable();
        DisplayTable.Columns.AddRange(new DataColumn[6] { new DataColumn("Date", typeof(string)), new DataColumn("Horse", typeof(string)), new DataColumn("Race", typeof(string)), new DataColumn("Time", typeof(string)), new DataColumn("Odds", typeof(string)), new DataColumn("Strength", typeof(string)) });


        foreach (DataRow dr_races in ds_races.Tables[0].Rows)
        {

            rcount++;
            double toplastsr = handicapping.GetTopLastSR(Convert.ToInt64(dr_races["id"])); //GET TOP LAST SR in the race
            double avgsr = handicapping.GetTopAvgSR(Convert.ToInt64(dr_races["id"])); //GET TOP AVG SR in the race
            double avgclass = handicapping.GetTopAvgClass(Convert.ToInt64(dr_races["id"])); //GET TOP AVG CLASS in the race

            string sql_entries = "SELECT entries.* FROM pp INNER JOIN entries ON pp.id = entries.id INNER JOIN races ON races.id = entries.raceid WHERE (raceid = '" + dr_races["id"] + "') AND (scratched = 'False') ";
            SqlCommand myCommand_entries = new SqlCommand(sql_entries, con);
            con.Open();

            SqlDataReader myReader_entries = myCommand_entries.ExecuteReader(CommandBehavior.CloseConnection);
            DataTable dt_entries = new DataTable();
            dt_entries.Load(myReader_entries);
            DataSet ds_entries = new DataSet();
            ds_entries.Tables.Add(dt_entries);
            con.Close();
            foreach (DataRow dr_entry in ds_entries.Tables[0].Rows)
            {
                tcount++;
                double odds = shared.FracToDouble(dr_entry["morningline"].ToString());
                if (odds > 5)
                {
                    hcount++;
                    //use this to calculate positive angles
                    int points = 0;
                    int points_avail = 0;

                    /***********   3 POINTS   *********/
                    //if horse was close in the last race and this is a notable drop in class add 3 points
                    if ((entries.GetLastRaceLengths(Convert.ToInt64(dr_entry["id"])) <= 2.5) && (entries.GetLastRaceClass(Convert.ToInt64(dr_entry["id"])) > (Convert.ToDouble(dr_races["todays_cls"]) + 4))) { points += 3; }
                    points_avail += 3;

                    /***********   2 POINTS   *********/
                    //Distance/Surface
                    if ((Convert.ToDouble(dr_entry["DST_SRF_wins"]) / Convert.ToDouble(dr_entry["DST_SRF_starts"])) >= .30) { points += 2; }
                    points_avail += 2;

                    /***********   1 POINT   *********/
                    //trainer / jock 
                    if ((Convert.ToDouble(dr_entry["JOCK_TRAN_wins"]) / Convert.ToDouble(dr_entry["JOCK_TRAN_starts"])) >= .30) { points++; }
                    points_avail++;
                    if (Convert.ToDouble(dr_entry["JOCK_TRAN_starts"]) >= 2) { if (Convert.ToDouble(dr_entry["JOCK_TRAN_roi"]) >= .30) { points++; } }
                    points_avail++;


                    //TODO - include distance and surface data individually

                    //Jockey
                    if ((Convert.ToDouble(dr_entry["jockey_30_wins"]) / Convert.ToDouble(dr_entry["jockey_30_starts"])) >= .30) { points++; }
                    points_avail++;
                    if (Convert.ToDouble(dr_entry["jockey_30_starts"]) >= 2) { if (Convert.ToDouble(dr_entry["jockey_30_roi"]) >= .30) { points++; } }
                    points_avail++;

                    //Trainer
                    if ((Convert.ToDouble(dr_entry["trainer_30_wins"]) / Convert.ToDouble(dr_entry["trainer_30_starts"])) >= .30) { points++; }
                    points_avail++;
                    if (Convert.ToDouble(dr_entry["trainer_30_starts"]) >= 2) { if (Convert.ToDouble(dr_entry["trainer_30_roi"]) >= .30) { points++; } }
                    points_avail++;
                    //hot horse - 2 or more wins in a row
                    if (entries.WinStreak(Convert.ToInt64(dr_entry["id"])) >= 2) { points++; }
                    points_avail++;
                    //won by open lengths last race
                    if (entries.GetLastRaceLengths(Convert.ToInt64(dr_entry["id"])) <= -2.0) { points++; }
                    points_avail++;
                    //Competitive SR
                    if (entries.GetAVGSR(Convert.ToInt64(dr_entry["id"])) >= (avgsr - 5)) { points++; }
                    points_avail++;
                    //Competitve Class 
                    if (entries.GetAVGClass(Convert.ToInt64(dr_entry["id"])) >= (avgclass - 5)) { points++; }
                    points_avail++;
                    //competitive for the race 
                    if (entries.GetAVGClass(Convert.ToInt64(dr_entry["id"])) >= (Convert.ToDouble(dr_races["todays_cls"]) - 5)) { points++; }
                    points_avail++;

                    //Competitive last SR
                    if (entries.GetLastSR(Convert.ToInt64(dr_entry["id"])) >= (avgsr)) { points++; }
                    points_avail++;

                    //16 possible points currently
                    if (points >= (points_avail / 3))
                    {
                        DateTime rdate = Convert.ToDateTime(dr_races["rdate"]);
                        TimeSpan timespan = (TimeSpan)dr_races["rtime"];
                        DateTime time = DateTime.Today.Add(timespan);
                        DateTime convertedtime = shared.ConvertDateTimeToLocalTime(time, Convert.ToInt64(dr_races["trackid"]), user_functions.GetTimeOffset(Membership.GetUser().ProviderUserKey.ToString()));
                        string displayTime = convertedtime.ToString("h:mm tt"); // It will give "03:00 AM"

                        DisplayTable.Rows.Add(rdate.ToShortDateString(), dr_entry["name"].ToString(), dr_races["abbrev"].ToString() + " #" + dr_races["rnum"].ToString(), displayTime, dr_entry["morningline"], points);
                    }

                }
            }
        }
        GridViewBBets.DataSource = DisplayTable;
        GridViewBBets.DataBind();
        LabelNumAnalyzed.Text = "Price horses analyzed: " + hcount + "(" + tcount + ") <br/>Races analyzed: " + rcount;
    }
    
}