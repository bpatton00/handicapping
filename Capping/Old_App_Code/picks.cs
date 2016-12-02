using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for picks
/// </summary>
public class picks
{
	public picks()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    //after results are entered and race is finalized, run this
    //now handled in stored procedure
    public static void ProcessPicks(Int64 raceid)
    {
        try
        {
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
            //load the values
            string sql_getpays = "SELECT winpayoff, placepayoff, showpayoff, entries.program, entryid, officialfinish FROM entry_results INNER JOIN entries ON entries.id = entry_results.entryid WHERE officialfinish <= 3 AND entry_results.raceid = '" + raceid + "'"; 
            SqlCommand myCommand_getpays = new SqlCommand(sql_getpays, con);
            con.Open();
            SqlDataReader myReader_getpays = myCommand_getpays.ExecuteReader(CommandBehavior.CloseConnection);
            DataTable dt_getpays = new DataTable();
            dt_getpays.Load(myReader_getpays);
            DataSet ds_getpays = new DataSet();
            ds_getpays.Tables.Add(dt_getpays);
            con.Close();
            foreach (DataRow dr_horses in ds_getpays.Tables[0].Rows)  //foreach winner (allows for dead heats)
            {                    
                decimal win_pay = Convert.ToDecimal(dr_horses["winpayoff"]);
                decimal place_pay = Convert.ToDecimal(dr_horses["placepayoff"]);
                decimal show_pay = Convert.ToDecimal(dr_horses["showpayoff"]);
                string program = (dr_horses["program"]).ToString();
                Int64 entryid = Convert.ToInt64(dr_horses["entryid"]);
                int horsefin = Convert.ToInt32(dr_horses["officialfinish"]);
                //get all picked
                string sql = "SELECT picks.id, pick_types.description, picks.tourn_entry FROM picks INNER JOIN pick_types ON pick_types.id = picks.pick_type WHERE raceid = '" + raceid + "' AND program = '" + program + "'";
                SqlCommand myCommand = new SqlCommand(sql, con);
                con.Open();

                SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
                DataTable dt = new DataTable();
                dt.Load(myReader);
                DataSet ds = new DataSet();
                ds.Tables.Add(dt);
                con.Close();
                foreach (DataRow dr in ds.Tables[0].Rows)  //for each winning pick
                {
   
                        decimal payout = 0;
                        //depending on the wager type, process 
                        switch (dr["description"].ToString().ToLower().Trim())
                        {
                            case "winplace":
                                //if we are paying out the winner or place
                                if (horsefin <= 2)
                                {
                                    payout = win_pay + place_pay;
                                }
                                break;
                            case "win":
                                if (horsefin == 1)
                                {
                                    payout = win_pay;
                                }
                                break;
                            case "place":
                                if (horsefin <= 2)
                                {
                                    payout = place_pay;
                                }
                                break;
                            case "show":
                                if (horsefin <= 3)
                                {
                                    payout = show_pay;
                                }
                                break;
                        }
                        //update payout on the picks- set to processed
                        string sql_upd = "UPDATE picks SET payout = " + payout + ", processed = 'True' WHERE id = '" + dr["id"] + "'";
                        SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                        con.Open();
                        myCommand_upd.ExecuteNonQuery();
                        con.Close();

                        //update tourn_entry with payout
                        string sql_upd2 = "UPDATE tourn_entry SET wager_earnings = wager_earnings + " + payout + " WHERE id = '" + dr["tourn_entry"] + "'";
                        SqlCommand myCommand_upd2 = new SqlCommand(sql_upd2, con);
                        con.Open();
                        myCommand_upd2.ExecuteNonQuery();
                        con.Close();
                    }
                
                }
            }        
            catch (Exception ex) { //shared.SaveError("picks.cs", ex.ToString()); 
        }

    }
    
    public static string GetROIIcon(double thisroi)
    {
        string icon = "";
        if (thisroi >= .60) { icon = "<i style=\"color:green\" class=\"fa fa-angle-double-up\"></i>"; }
        if (thisroi > 0 && thisroi < .60) { icon = "<i style=\"color:green\" class=\"fa fa-angle-up\"></i>"; }
        if (thisroi <= -.25) { icon = "<i style=\"color:red\" class=\"fa fa-angle-down\"></i>"; }
        return icon;
    }

}