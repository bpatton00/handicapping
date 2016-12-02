using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class ascx_winstreaks : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable DisplayTable = new DataTable();
        DisplayTable.Columns.AddRange(new DataColumn[5] { new DataColumn("Date", typeof(string)), new DataColumn("Time", typeof(string)), new DataColumn("Race", typeof(string)), new DataColumn("Horse", typeof(string)), new DataColumn("Wins", typeof(string)) });

        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        string sql = "SELECT entries.id, rdate, rtime, abbrev, rnum, entries.name FROM entries INNER JOIN races ON races.id = entries.raceid INNER JOIN tracks ON tracks.id = races.track WHERE        (CONVERT(date, races.rdate, 101) <= CONVERT(date, DATEADD(day, 1, GETDATE()), 101)) AND (CONVERT(date, races.rdate, 101) >= CONVERT(date, GETDATE(), 101)) AND (scratched = 'False') ORDER BY rdate, rtime ";
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        con.Close();
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            int wins = entries.WinStreak(Convert.ToInt64(dr["id"]));
            if (wins > 1)
            {
                DateTime rdate = Convert.ToDateTime(dr["rdate"]);
                TimeSpan timespan = (TimeSpan)dr["rtime"];
                DateTime time = DateTime.Today.Add(timespan);
                string displayTime = time.ToString("h:mm tt"); // It will give "03:00 AM"
                DisplayTable.Rows.Add(rdate.ToShortDateString(), displayTime, dr["abbrev"].ToString() + " #" + dr["rnum"].ToString(), dr["name"].ToString(), wins);
            }
            
        }
        //loop through these entries and then build a list of horses on a 2 win streak or greater
        GridViewWins.DataSource = DisplayTable;
        GridViewWins.DataBind();
        
   

    }

    
}