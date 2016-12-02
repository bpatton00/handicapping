using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Security;

public partial class ascx_tips : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
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
        DisplayTable.Columns.AddRange(new DataColumn[8] { new DataColumn("Date", typeof(string)), new DataColumn("Time", typeof(string)), new DataColumn("Race", typeof(string)), new DataColumn("Horse", typeof(string)), new DataColumn("Odds", typeof(string)), new DataColumn("Rank", typeof(string)), new DataColumn("Strength", typeof(string)), new DataColumn("Pick Accuracy", typeof(string)) });
        foreach (DataRow dr_races in ds_races.Tables[0].Rows)
        {
            DateTime rdate = Convert.ToDateTime(dr_races["rdate"]);
            TimeSpan timespan = (TimeSpan)dr_races["rtime"];
            DateTime time = DateTime.Today.Add(timespan);
            DateTime convertedtime = shared.ConvertDateTimeToLocalTime(time, Convert.ToInt64(dr_races["trackid"]), user_functions.GetTimeOffset(Membership.GetUser().ProviderUserKey.ToString()));
            string displayTime = convertedtime.ToString("h:mm tt"); // It will give "03:00 AM"

            string sql_entries = "SELECT program, post, name, ccrank, ccscore, ccpoints, livelongshot, morningline FROM [entries] WHERE ([raceid] = " + dr_races["id"] + ") ORDER BY ccrank";
            SqlCommand myCommand_entries = new SqlCommand(sql_entries, con);
            con.Open();

            SqlDataReader myReader_entries = myCommand_entries.ExecuteReader(CommandBehavior.CloseConnection);
            DataTable dt_entries = new DataTable();
            dt_entries.Load(myReader_entries);
            DataSet ds_entries = new DataSet();
            ds_entries.Tables.Add(dt_entries);
            con.Close();
            
            if( Convert.ToDouble(ds_entries.Tables[0].Rows[0]["ccscore"]) >= (Convert.ToDouble(ds_entries.Tables[0].Rows[1]["ccscore"]) + .10) )
            {
                int ccrank = Convert.ToInt16(ds_entries.Tables[0].Rows[0]["ccrank"]);
                double ccscore = Convert.ToDouble(ds_entries.Tables[0].Rows[0]["ccscore"]);
                int ccpoints = Convert.ToInt16(ds_entries.Tables[0].Rows[0]["ccpoints"]);
                
                double strong_accuracy = handicapping.GetAccuracy(Convert.ToInt64(dr_races["id"]), true, ccrank);
                DisplayTable.Rows.Add(rdate.ToShortDateString(), displayTime, dr_races["abbrev"].ToString() + " #" + dr_races["rnum"].ToString(), ds_entries.Tables[0].Rows[0]["name"].ToString(), ds_entries.Tables[0].Rows[0]["morningline"], ccrank, ccscore.ToString("p0"), strong_accuracy.ToString("p0"));                    
            }   
            
        }
        GridViewTips.DataSource = DisplayTable;
        GridViewTips.DataBind();
    }
}