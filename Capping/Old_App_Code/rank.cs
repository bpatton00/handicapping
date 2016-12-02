using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for rank
/// </summary>
public class rank
{
    public class MyVars
    {
        public long entryid = new long();
        public double score = new double();
        public int points = new int();
        public bool longshot = new bool();
        public bool toplastsr = new bool();
        public bool topavgsr = new bool();
        public bool topclass = new bool();
        public bool classdrop = new bool();
        public bool openlengthwin = new bool();
        public int winstreak = new int();
        public double marginofdefeat = new double();
        public bool improving = new bool();
    }

	public rank()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static void CreateRankings(Int64 raceid)
    {
        List<MyVars> racevars = new List<MyVars>();
            
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
  
            double racetoplastsr = handicapping.GetTopLastSR(raceid); //GET TOP LAST SR in the race
            double avgsr = handicapping.GetTopAvgSR(raceid); //GET TOP AVG SR in the race
            double avgclass = handicapping.GetTopAvgClass(raceid); //GET TOP AVG CLASS in the race

            string sql_entries = "SELECT entries.*, races.todays_cls FROM pp INNER JOIN entries ON pp.id = entries.id INNER JOIN races ON races.id = entries.raceid WHERE (raceid = '" + raceid + "') AND (scratched = 'False') ";
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
                 bool hlongshot = false;
                 bool toplastsr = false; 
                 bool topavgsr = false;
                 bool topclass = false;
                 bool classdrop = false;
                 bool improving = false;
                 bool openlengthwin = false;
                 int winstreak = entries.WinStreak(Convert.ToInt64(dr_entry["id"]));
                 double marginofdefeat = entries.GetLastRaceLengths(Convert.ToInt64(dr_entry["id"]));

                    double odds = shared.FracToDouble(dr_entry["morningline"].ToString());
                    
                    //use this to calculate positive angles
                    int points = 0;
                    int points_avail = 0;


            /***********   6 POINTS   *********/
            //if horse was close in the last race and this is a notable drop in class 
            if ((entries.GetLastRaceLengths(Convert.ToInt64(dr_entry["id"])) <= 1.5) && (entries.GetLastRaceClass(Convert.ToInt64(dr_entry["id"])) > (Convert.ToDouble(dr_entry["todays_cls"]) + 4))) { points += 4; classdrop = true; }
            points_avail += 6;

            /***********   4 POINTS   *********/
            //won by open lengths last race and it was equal or better class
            if (entries.GetLastRaceLengths(Convert.ToInt64(dr_entry["id"])) <= -2.0 && (entries.GetLastRaceClass(Convert.ToInt64(dr_entry["id"])) > (Convert.ToDouble(dr_entry["todays_cls"]) )) ) { points += 4; }
                    points_avail += 4;

            /***********   3 POINTS   *********/
                    if (entries.ImprovedLastTwoStarts(Convert.ToInt64(dr_entry["id"]))) { points += 3; improving = true; }
                    points_avail += 3;

                    //perfect over dist/surf
                    if ((Convert.ToDouble(dr_entry["DST_SRF_wins"]) / Convert.ToDouble(dr_entry["DST_SRF_starts"])) == .100) { points += 3; }
                    points_avail += 3;
                   
                    //hot horse - 2 or more wins in a row
                    if (winstreak >= 2) { points++; }
                    if (winstreak >= 3) { points++; }
                    if (winstreak >= 4) { points++; }
                    points_avail += 3;

                //trainer > .60
                if ((Convert.ToDouble(dr_entry["trainer_30_wins"]) / Convert.ToDouble(dr_entry["trainer_30_starts"])) >= .60) { points+=3; }
                points_avail += 3;

                
                //TOP SR
                if (entries.GetLastSR(Convert.ToInt64(dr_entry["id"])) >= racetoplastsr) { points += 3; toplastsr = true; }
                points_avail += 3;

            /***********   2 POINTS   *********/
            //Distance/Surface
            if ((Convert.ToDouble(dr_entry["DST_SRF_wins"]) / Convert.ToDouble(dr_entry["DST_SRF_starts"])) >= .30) { points += 2; }                    
                    points_avail += 2; 

                    //roi
                    if (!string.IsNullOrEmpty(dr_entry["JOCK_TRAN_roi"].ToString()))
                    {
                        double jock_tran_roi = Convert.ToDouble(dr_entry["JOCK_TRAN_roi"]);
                        if (Convert.ToDouble(dr_entry["JOCK_TRAN_starts"]) >= 2)
                        {
                            if (jock_tran_roi >= .30) { points++; }
                            if (jock_tran_roi >= .40) { points++; }
                        }
                    }
                    points_avail += 2;

                    //won by open lengths last race
                    if (entries.GetLastRaceLengths(Convert.ToInt64(dr_entry["id"])) <= -2.0) { points += 2; openlengthwin = true; }
                    points_avail += 2;

                    //trainer / jock 
                    double jock_tran_pct = (Convert.ToDouble(dr_entry["JOCK_TRAN_wins"]) / Convert.ToDouble(dr_entry["JOCK_TRAN_starts"]));
                    if (jock_tran_pct >= .30) { points++; }
                    if (jock_tran_pct >= .50) { points += 1; }
                    points_avail += 2;
                    

                    //TOP Average SR
                    if (entries.GetAVGSR(Convert.ToInt64(dr_entry["id"])) >= avgsr ) { points+=2; topavgsr = true; }
                    points_avail+=2;
                    //TOP Class 
                    if (entries.GetAVGClass(Convert.ToInt64(dr_entry["id"])) >= avgclass) { points+=2; topclass = true; }
                    points_avail+=2;

            /***********   1 POINT   *********/
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

                    //Competitive Average SR
                    if (entries.GetAVGSR(Convert.ToInt64(dr_entry["id"])) >= (avgsr - 5)) { points++; }
                    points_avail++;
                    //Competitve Class 
                    if (entries.GetAVGClass(Convert.ToInt64(dr_entry["id"])) >= (avgclass - 5)) { points++; }
                    points_avail++;
                    //competitive for the race 
                    if (entries.GetAVGClass(Convert.ToInt64(dr_entry["id"])) >= (Convert.ToDouble(dr_entry["todays_cls"]) - 5)) { points++; }
                    points_avail++;

                    //Competitive last SR
                    if (entries.GetLastSR(Convert.ToInt64(dr_entry["id"])) >= (avgsr)) { points++; }
                    points_avail++;


                    //remove points for bad things
                    //Non-Competitive Average SR
                    if (entries.GetAVGSR(Convert.ToInt64(dr_entry["id"])) < (avgsr - 6)) { points--; }
                    //up in class
                    if (entries.GetAVGClass(Convert.ToInt64(dr_entry["id"])) < (avgclass - 6)) { points--; }
                    //cold jockey
                    if ((Convert.ToDouble(dr_entry["jockey_30_wins"]) / Convert.ToDouble(dr_entry["jockey_30_starts"])) <= .14) { points--; }
                    //cold trainer
                    if ((Convert.ToDouble(dr_entry["trainer_30_wins"]) / Convert.ToDouble(dr_entry["trainer_30_starts"])) <= .14) { points--; }
                    //has tried but not won over distance /srf or low %
                    if ( (Convert.ToDouble(dr_entry["DST_SRF_wins"])  < 1 && Convert.ToDouble(dr_entry["DST_SRF_starts"]) > 0 ) || (Convert.ToDouble(dr_entry["DST_SRF_wins"]) / Convert.ToDouble(dr_entry["DST_SRF_starts"])) <= .20) { points--; }
                    //has tried but not won at the track or low %
                    if ((Convert.ToDouble(dr_entry["AT_TRK_wins"]) < 1 && Convert.ToDouble(dr_entry["AT_TRK_starts"]) > 0) || (Convert.ToDouble(dr_entry["AT_TRK_wins"]) / Convert.ToDouble(dr_entry["AT_TRK_starts"])) <= .20) { points--; }
                    //has not won for a while
                    if (entries.LossStreak(Convert.ToInt64(dr_entry["id"])) >= 2) { points--; }
                        

                    //************************************
                    //save for sorting
                    double hscore = Math.Round(Convert.ToDouble(points) / Convert.ToDouble(points_avail), 2);
                    
                    if (points >= (points_avail / 5) && odds >= 5) { hlongshot = true; }
                    racevars.Add(new MyVars { entryid = Convert.ToInt64(dr_entry["id"]), score = hscore, points = points, longshot = hlongshot, classdrop = classdrop, topclass = topclass, topavgsr = topavgsr, toplastsr = toplastsr, marginofdefeat = marginofdefeat, openlengthwin = openlengthwin, winstreak = winstreak, improving = improving });
            }
            racevars.Sort(delegate(MyVars mv1, MyVars mv2) { return mv2.points.CompareTo(mv1.points); });
            int rank = 1;
            foreach (MyVars h in racevars)
            {                
                string sql_upd = "UPDATE entries SET ccrank = " + rank + ", ccscore = " + h.score + ", livelongshot = '" + h.longshot + "', classdrop = '" + h.classdrop + "', topclass = '" + h.topclass + "', topavgsr = '"+ h.topavgsr + "', toplastsr = '" + h.toplastsr + "', marginofdefeat = '" + h.marginofdefeat + "', openlengthwin ='" + h.openlengthwin + "', winstreak = '" + h.winstreak + "', ccpoints = " + h.points + ", improving = '" + h.improving + "' WHERE id = " + h.entryid + "";
                rank++;
                SqlCommand myCommand_upd = new SqlCommand(sql_upd, con);
                con.Open();
                myCommand_upd.ExecuteNonQuery();
                con.Close();
            }

            //update scratched horses, remove rankings and any other flags
            string sql_scr = "UPDATE entries SET ccrank = 0, ccscore = 0, livelongshot = 0, ccpoints = 0 WHERE scratched = 1";
            SqlCommand myCommand_scr = new SqlCommand(sql_scr, con);
            con.Open();
            myCommand_scr.ExecuteNonQuery();
            con.Close();

        racevars.Clear();

    }
}