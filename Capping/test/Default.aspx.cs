using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml.Serialization;
using System.IO;
using System.Xml;
using System.Data.SqlClient;
using System.Globalization;


public partial class test_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Write(races.GetTrackTimeOffset(1));
        TimeSpan timespan = new TimeSpan(12,25,0);
        DateTime time = DateTime.Today.Add(timespan);
        DateTime convertedtime = shared.ConvertDateTimeToLocalTime(time, Convert.ToInt64(1), user_functions.GetTimeOffset("271195a8-154f-4051-98bf-410f5a680da0"));
        string displayTime = convertedtime.ToString("h:mm tt"); // It will give "03:00 AM"
        Response.Write("<br/>" + displayTime);

        //get full list of races
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        //go through in order (horse that finished 1st, 2nd, 3rd) then set all as processed
        string sql = "SELECT id FROM races WHERE ropen = 'False'";
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();
        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        con.Close();
        foreach (DataRow dr in ds.Tables[0].Rows)  //foreach winner (allows for dead heats)
        {
            picks.ProcessPicks(Convert.ToInt64(dr["id"])); //process picks for all of these races
        }
    }
 
}