using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class ascx_sredge : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        //loop through all races in the next 48 hours
        string sql_races = "SELECT id FROM races WHERE (CONVERT(date, races.rdate, 101) <= CONVERT(date, DATEADD(day, 1, GETDATE()), 101)) AND (CONVERT(date, races.rdate, 101) >= CONVERT(date, GETDATE(), 101)) ORDER BY rdate, rtime ";
        SqlCommand myCommand_races = new SqlCommand(sql_races, con);
        con.Open();

        SqlDataReader myReader_races = myCommand_races.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt_races = new DataTable();
        dt_races.Load(myReader_races);
        DataSet ds_races = new DataSet();
        ds_races.Tables.Add(dt_races);
        con.Close();
        DataTable DisplayTable = new DataTable();
        DisplayTable.Columns.AddRange(new DataColumn[5] { new DataColumn("Date", typeof(string)), new DataColumn("Time", typeof(string)), new DataColumn("Race", typeof(string)), new DataColumn("Horse", typeof(string)), new DataColumn("SR", typeof(string)) });


        foreach (DataRow dr_races in ds_races.Tables[0].Rows)
        {
            //for each race, compare the top avg sr to the second top and if it's greater than 4pts difference - add horse to list
            string sql = "SELECT TOP (2) e.name, e.program, races.rdate, races.rtime, tracks.abbrev, races.rnum, (SELECT AVG(sr) AS Expr1 FROM (SELECT TOP (10) sr FROM pp WHERE (sr > 0) AND (rtype <> 'SCR') AND (entryid = e.id) ORDER BY rdate DESC) AS derivedtbl_1) AS avgrating FROM entries AS e INNER JOIN races ON e.raceid = races.id INNER JOIN tracks ON tracks.id = races.track WHERE (e.raceid = '" + dr_races["id"] + "') AND (e.scratched = 'False') ORDER BY avgrating DESC";
            SqlCommand myCommand = new SqlCommand(sql, con);
            con.Open();

            SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
            DataTable dt = new DataTable();
            dt.Load(myReader);
            DataSet ds = new DataSet();
            ds.Tables.Add(dt);
            con.Close();
            if (ds.Tables[0].Rows.Count > 1)
            {
                try
                {
                    //compare top two avg srs
                    double sr1 = Convert.ToDouble(ds.Tables[0].Rows[0]["avgrating"]);
                    double sr2 = Convert.ToDouble(ds.Tables[0].Rows[1]["avgrating"]);
                    if (sr1 >= (sr2 + 5))
                    {
                        DateTime rdate = Convert.ToDateTime(ds.Tables[0].Rows[0]["rdate"]);
                        TimeSpan timespan = (TimeSpan)ds.Tables[0].Rows[0]["rtime"];
                        DateTime time = DateTime.Today.Add(timespan);
                        string displayTime = time.ToString("h:mm tt"); // It will give "03:00 AM"
                        DisplayTable.Rows.Add(rdate.ToShortDateString(), displayTime, ds.Tables[0].Rows[0]["abbrev"].ToString() + " #" + ds.Tables[0].Rows[0]["rnum"].ToString(), ds.Tables[0].Rows[0]["name"].ToString(), sr1);
                    }
                }
                catch { }

            }
        }

        GridViewSR.DataSource = DisplayTable;
        GridViewSR.DataBind();

    }
}