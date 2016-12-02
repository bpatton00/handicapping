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

public partial class test_Default_m : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ButtonUpdatePicks_Click(object sender, EventArgs e)
    {
        int counter = 0;
        //for each entry_result
        string sql = "SELECT * FROM entry_results ";
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            //run the code that will now run every time one of these rows is created
            if (Convert.ToInt16(dr["officialfinish"]) == 1)
            {
                string sql_upd = "UPDATE picks SET payout = " + (Convert.ToDouble(dr["winpayoff"]) + Convert.ToDouble(dr["placepayoff"])) + ", processed = 'True' WHERE entryid = " + dr["entryid"] + " AND pick_type = 1";
                SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                con.Open();
                myCommand_upd.ExecuteNonQuery();
                con.Close();
                sql_upd = "UPDATE picks SET payout = " + Convert.ToDouble(dr["winpayoff"]) + ", processed = 'True' WHERE entryid = " + dr["entryid"] + " AND pick_type = 2";
                myCommand_upd = new SqlCommand(sql_upd, con);
                con.Open();
                myCommand_upd.ExecuteNonQuery();
                con.Close();
                sql_upd = "UPDATE picks SET payout = " + Convert.ToDouble(dr["placepayoff"]) + ", processed = 'True' WHERE entryid = " + dr["entryid"] + " AND pick_type = 3";
                myCommand_upd = new SqlCommand(sql_upd, con);
                con.Open();
                myCommand_upd.ExecuteNonQuery();
                con.Close();
                sql_upd = "UPDATE picks SET payout = " + Convert.ToDouble(dr["showpayoff"]) + ", processed = 'True' WHERE entryid = " + dr["entryid"] + " AND pick_type = 4";
                myCommand_upd = new SqlCommand(sql_upd, con);
                con.Open();
                myCommand_upd.ExecuteNonQuery();
                con.Close();
            }
            if (Convert.ToInt16(dr["officialfinish"]) == 2)
            {
                string sql_upd = "UPDATE picks SET payout = " + Convert.ToDouble(dr["placepayoff"]) + ", processed = 'True' WHERE entryid = " + dr["entryid"] + " AND (pick_type = 3 or pick_type = 1)";
                SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                con.Open();
                myCommand_upd.ExecuteNonQuery();
                con.Close();
                sql_upd = "UPDATE picks SET payout = " + Convert.ToDouble(dr["showpayoff"]) + ", processed = 'True' WHERE entryid = " + dr["entryid"] + " AND pick_type = 4";
                myCommand_upd = new SqlCommand(sql_upd, con);
                con.Open();
                myCommand_upd.ExecuteNonQuery();
                con.Close();
            }
            if (Convert.ToInt16(dr["officialfinish"]) == 3)
            {
                string sql_upd = "UPDATE picks SET payout = " + Convert.ToDouble(dr["showpayoff"]) + ", processed = 'True' WHERE entryid = " + dr["entryid"] + " AND pick_type = 4";
                SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                con.Open();
                myCommand_upd.ExecuteNonQuery();
                con.Close();
            }
            if (Convert.ToInt16(dr["officialfinish"]) >= 3)
            {
                string sql_upd = "UPDATE picks SET payout = 0, processed = 'True' WHERE entryid = " + dr["entryid"];
                SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                con.Open();
                myCommand_upd.ExecuteNonQuery();
                con.Close();
            }
            counter++;
        }

        Response.Write(counter + " results processed.");
    }
}