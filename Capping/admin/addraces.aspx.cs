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


public partial class admin_addraces : System.Web.UI.Page
{

    /*Stats Array List
     
     
     * 25 LIFE  
     * 24 LAST_YEAR
     * 40 THIS_YEAR
     * 
     *  4 AT_TRK
     *      12 AT_TRK_CRS
     *       7 AT_TRK_DSTT
     *  1 AT_DIST_CRS
     * 20 DIST_SURF
     *  
     * 17 DIRT
     *      34 MUD
     * 42 TURF
     *      39 SOFT TURF
     *      
     * 35 OFF_CLAIM1
     * 36 OFF_CLAIM2
     * 
     * 21 JOCK_HORSE
     * 22 JOCK_TRAN
     * 41 TRAN_HORSE
     */

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void LoadXML(string xmlfile)
    {
        List<Int64> racesadded = new List<Int64>();
        string trackscheduled = "";
        DateTime tourndate = DateTime.Now;
        

        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);

        XmlSerializer ser = new XmlSerializer(typeof(data));
        data rdata;
        string path = Server.MapPath("~/admin/xml/" + xmlfile);
        using (XmlReader reader = XmlReader.Create(path))
        {
            rdata = (data)ser.Deserialize(reader);
        }
        for (int i = 0; i < rdata.racedata.Length; i++)
        {
            if (rdata.racedata[i] != null)
            {
                string racename = rdata.racedata[i].race;
                string racetext = rdata.racedata[i].race_text;
                string racecat = rdata.racedata[i].stk_clm_md;
                string track = races.GetTrackID(rdata.racedata[i].track).ToString(); //need to cast this as the integer based on the abbreviation and the mathcing id from tracks               
                string courseid = rdata.racedata[i].course_id;
                string country = rdata.racedata[i].country;
                string racedate = rdata.racedata[i].race_date;
                string posttime = rdata.racedata[i].post_time;
                string racenum = rdata.racedata[i].raceord;
                string age_restr = rdata.racedata[i].age_restr;
                string purse = rdata.racedata[i].purse;
                string distance = rdata.racedata[i].dist_disp;
                string dist_unit = rdata.racedata[i].dist_unit;
                string surface = rdata.racedata[i].surface;
                string rtype = rdata.racedata[i].stk_clm_md;
                string todays_class = rdata.racedata[i].todays_cls;
                decimal partim = rdata.racedata[i].partim;
                int claimamt = Convert.ToInt32(rdata.racedata[i].claimamt);
                //save data for use later when naming tournament -- use first post time as closing time for tourn
                if (i == 0)
                {
                    trackscheduled = rdata.racedata[i].track.ToString();
                    string time = posttime;
                    if (time.Length < 7) { time = "0" + time; }
                    tourndate = DateTime.ParseExact(racedate + " " + time, "yyyyMMdd hh:mmtt", CultureInfo.InvariantCulture);
                }

                //create the database entry for this race                
                SqlCommand cmd = new SqlCommand("SP_AddRace", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@rdesc", racename));
                cmd.Parameters.Add(new SqlParameter("@rdate", racedate));
                cmd.Parameters.Add(new SqlParameter("@rtime", posttime));
                cmd.Parameters.Add(new SqlParameter("@track", track));
                cmd.Parameters.Add(new SqlParameter("@distance", distance));
                cmd.Parameters.Add(new SqlParameter("@surface", surface));
                cmd.Parameters.Add(new SqlParameter("@purse", purse));
                cmd.Parameters.Add(new SqlParameter("@rinfo", racetext));
                cmd.Parameters.Add(new SqlParameter("@rnum", racenum));
                cmd.Parameters.Add(new SqlParameter("@rtype", rtype));
                cmd.Parameters.Add(new SqlParameter("@claimamt", claimamt));
                cmd.Parameters.Add(new SqlParameter("@todays_cls", todays_class));
                cmd.Parameters.Add(new SqlParameter("@age_restr", age_restr));
                cmd.Parameters.Add(new SqlParameter("@partime", partim));
                
                SqlParameter retValue = cmd.Parameters.Add("return", SqlDbType.Int);
                retValue.Direction = ParameterDirection.ReturnValue;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                Int64 newraceid = Convert.ToInt64(retValue.Value);
                racesadded.Add(newraceid);
                //use the inserted ID to create entries
                if (newraceid > 0)
                {
                    //for each horse in the race
                    for (int z = 0; z < rdata.racedata[i].horsedata.Length; z++)
                    {
                        string horsename = rdata.racedata[i].horsedata[z].horse_name;
                        string jockey = rdata.racedata[i].horsedata[z].jockey.jock_disp;
                        string owner = rdata.racedata[i].horsedata[z].owner_name;
                        string ml = rdata.racedata[i].horsedata[z].morn_odds;
                        string price = rdata.racedata[i].horsedata[z].price;                        
                        string trainer = rdata.racedata[i].horsedata[z].trainer.tran_disp;
                        string program = rdata.racedata[i].horsedata[z].program;
                        string post = rdata.racedata[i].horsedata[z].pp; ;
                        string power = rdata.racedata[i].horsedata[z].power.ToString();
                        string sirename = rdata.racedata[i].horsedata[z].sire.sirename.ToString();
                        string damname = rdata.racedata[i].horsedata[z].dam.damname.ToString();
                        int studfee = Convert.ToInt32(rdata.racedata[i].horsedata[z].sire.stud_fee);
                        int claimprice = Convert.ToInt32(rdata.racedata[i].horsedata[z].claimprice);
                        string horsex = rdata.racedata[i].horsedata[z].sex;
                        string med = rdata.racedata[i].horsedata[z].med;
                        string equip = rdata.racedata[i].horsedata[z].equip;
                        string color = rdata.racedata[i].horsedata[z].color;

                        //addtl items
                        int bought_fr = Convert.ToInt16(rdata.racedata[i].horsedata[z].bought_fr);
                        string pwr_symb = "";
                        try { pwr_symb = rdata.racedata[i].horsedata[z].power_symb.ToString(); }
                        catch{}
                        //****************Horse Stats**********************
                        //LIFETIME
                        int LIFE_starts = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[25].starts);
                        int LIFE_wins = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[25].wins);
                        int LIFE_places = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[25].places);
                        int LIFE_shows = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[25].shows);
                        string LIFE_roi = rdata.racedata[i].horsedata[z].stats_data[25].roi;
                        string LIFE_earnings = rdata.racedata[i].horsedata[z].stats_data[25].earnings;
                        //TY Stats
                        int TY_starts = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[40].starts);
                        int TY_wins = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[40].wins);
                        int TY_places = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[40].places);
                        int TY_shows = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[40].shows);
                        string TY_roi = rdata.racedata[i].horsedata[z].stats_data[40].roi;
                        string TY_earnings = rdata.racedata[i].horsedata[z].stats_data[40].earnings;
                        //distance + course
                        int DST_CRS_starts = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[1].starts);
                        int DST_CRS_wins = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[1].wins);
                        int DST_CRS_places = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[1].places);
                        int DST_CRS_shows = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[1].shows);
                        string DST_CRS_roi = rdata.racedata[i].horsedata[z].stats_data[1].roi;
                        string DST_CRS_earnings = rdata.racedata[i].horsedata[z].stats_data[1].earnings;
                        //distance + surface
                        int DST_SRF_starts = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[20].starts);
                        int DST_SRF_wins = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[20].wins);
                        int DST_SRF_places = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[20].places);
                        int DST_SRF_shows = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[20].shows);
                        string DST_SRF_roi = rdata.racedata[i].horsedata[z].stats_data[20].roi;
                        string DST_SRF_earnings = rdata.racedata[i].horsedata[z].stats_data[20].earnings;
                        //at track
                        int AT_TRK_starts = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[4].starts);
                        int AT_TRK_wins = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[4].wins);
                        int AT_TRK_places = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[4].places);
                        int AT_TRK_shows = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[4].shows);
                        string AT_TRK_roi = rdata.racedata[i].horsedata[z].stats_data[4].roi;
                        string AT_TRK_earnings = rdata.racedata[i].horsedata[z].stats_data[4].earnings;
                        //dirt
                        int DIRT_starts = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[17].starts);
                        int DIRT_wins = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[17].wins);
                        int DIRT_places = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[17].places);
                        int DIRT_shows = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[17].shows);
                        string DIRT_roi = rdata.racedata[i].horsedata[z].stats_data[17].roi;
                        string DIRT_earnings = rdata.racedata[i].horsedata[z].stats_data[17].earnings;
                        //mud
                        int MUD_starts = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[34].starts);
                        int MUD_wins = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[34].wins);
                        int MUD_places = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[34].places);
                        int MUD_shows = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[34].shows);
                        string MUD_roi = rdata.racedata[i].horsedata[z].stats_data[34].roi;
                        string MUD_earnings = rdata.racedata[i].horsedata[z].stats_data[34].earnings;
                        //turf
                        int TURF_starts = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[42].starts);
                        int TURF_wins = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[42].wins);
                        int TURF_places = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[42].places);
                        int TURF_shows = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[42].shows);
                        string TURF_roi = rdata.racedata[i].horsedata[z].stats_data[42].roi;
                        string TURF_earnings = rdata.racedata[i].horsedata[z].stats_data[42].earnings;
                        //soft turf
                        int SOFT_TURF_starts = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[39].starts);
                        int SOFT_TURF_wins = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[39].wins);
                        int SOFT_TURF_places = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[39].places);
                        int SOFT_TURF_shows = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[39].shows);
                        string SOFT_TURF_roi = rdata.racedata[i].horsedata[z].stats_data[39].roi;
                        string SOFT_TURF_earnings = rdata.racedata[i].horsedata[z].stats_data[39].earnings;
                        //offclaim1
                        int OFF_CLM1_starts = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[35].starts);
                        int OFF_CLM1_wins = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[35].wins);
                        int OFF_CLM1_places = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[35].places);
                        int OFF_CLM1_shows = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[35].shows);
                        string OFF_CLM1_roi = rdata.racedata[i].horsedata[z].stats_data[35].roi;
                        string OFF_CLM1_earnings = rdata.racedata[i].horsedata[z].stats_data[35].earnings;
                        //offclaim2
                        int OFF_CLM2_starts = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[36].starts);
                        int OFF_CLM2_wins = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[36].wins);
                        int OFF_CLM2_places = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[36].places);
                        int OFF_CLM2_shows = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[36].shows);
                        string OFF_CLM2_roi = rdata.racedata[i].horsedata[z].stats_data[36].roi;
                        string OFF_CLM2_earnings = rdata.racedata[i].horsedata[z].stats_data[36].earnings;

                        //Trainer Jockey
                        int JOCK_TRAN_starts = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[22].starts);
                        int JOCK_TRAN_wins = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[22].wins);
                        int JOCK_TRAN_places = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[22].places);
                        int JOCK_TRAN_shows = Convert.ToInt32(rdata.racedata[i].horsedata[z].stats_data[22].shows);
                        string JOCK_TRAN_roi = rdata.racedata[i].horsedata[z].stats_data[22].roi;
                        string JOCK_TRAN_earnings = rdata.racedata[i].horsedata[z].stats_data[22].earnings;

                        //LAST 30 days data
                        int jockey_30_starts = Convert.ToInt32(rdata.racedata[i].horsedata[z].jockey.stats_data[0].starts);
                        int jockey_30_wins = Convert.ToInt32(rdata.racedata[i].horsedata[z].jockey.stats_data[0].wins);
                        int jockey_30_places = Convert.ToInt32(rdata.racedata[i].horsedata[z].jockey.stats_data[0].places);
                        int jockey_30_shows = Convert.ToInt32(rdata.racedata[i].horsedata[z].jockey.stats_data[0].shows);
                        string jockey_30_roi = rdata.racedata[i].horsedata[z].jockey.stats_data[0].roi;
                        int trainer_30_starts = Convert.ToInt32(rdata.racedata[i].horsedata[z].trainer.stats_data[0].starts);
                        int trainer_30_wins = Convert.ToInt32(rdata.racedata[i].horsedata[z].trainer.stats_data[0].wins);
                        int trainer_30_places = Convert.ToInt32(rdata.racedata[i].horsedata[z].trainer.stats_data[0].places);
                        int trainer_30_shows = Convert.ToInt32(rdata.racedata[i].horsedata[z].trainer.stats_data[0].shows);
                        string trainer_30_roi = rdata.racedata[i].horsedata[z].trainer.stats_data[0].roi;

                        //insert using newraceid
                        SqlCommand cmd_horse = new SqlCommand("SP_AddRaceEntry", con);
                        cmd_horse.CommandType = CommandType.StoredProcedure;
                        cmd_horse.Parameters.Add(new SqlParameter("@raceid", Convert.ToInt64(newraceid)));
                        cmd_horse.Parameters.Add(new SqlParameter("@name", horsename));
                        cmd_horse.Parameters.Add(new SqlParameter("@post", post));
                        cmd_horse.Parameters.Add(new SqlParameter("@program", program));
                        cmd_horse.Parameters.Add(new SqlParameter("@morningline", ml));
                        cmd_horse.Parameters.Add(new SqlParameter("@jockey", jockey));
                        cmd_horse.Parameters.Add(new SqlParameter("@trainer", trainer));
                        cmd_horse.Parameters.Add(new SqlParameter("@owner", owner));
                        cmd_horse.Parameters.Add(new SqlParameter("@sirename", sirename));
                        cmd_horse.Parameters.Add(new SqlParameter("@damname", damname));
                        cmd_horse.Parameters.Add(new SqlParameter("@studfee", studfee));
                        cmd_horse.Parameters.Add(new SqlParameter("@claimprice", claimprice));
                        cmd_horse.Parameters.Add(new SqlParameter("@horsesex", horsex));
                        cmd_horse.Parameters.Add(new SqlParameter("@med", med));
                        cmd_horse.Parameters.Add(new SqlParameter("@equip", equip));
                        cmd_horse.Parameters.Add(new SqlParameter("@color", color));
                        cmd_horse.Parameters.Add(new SqlParameter("@power", power));
                        cmd_horse.Parameters.Add(new SqlParameter("@pwr_symb", pwr_symb));                        
                        cmd_horse.Parameters.Add(new SqlParameter("@bought_fr", bought_fr));
                        cmd_horse.Parameters.Add(new SqlParameter("@jockey_30_starts", jockey_30_starts));
                        cmd_horse.Parameters.Add(new SqlParameter("@jockey_30_wins", jockey_30_wins));
                        cmd_horse.Parameters.Add(new SqlParameter("@jockey_30_places", jockey_30_places));
                        cmd_horse.Parameters.Add(new SqlParameter("@jockey_30_shows", jockey_30_shows));
                        cmd_horse.Parameters.Add(new SqlParameter("@jockey_30_roi", jockey_30_roi));
                        cmd_horse.Parameters.Add(new SqlParameter("@trainer_30_starts", trainer_30_starts));
                        cmd_horse.Parameters.Add(new SqlParameter("@trainer_30_wins", trainer_30_wins));
                        cmd_horse.Parameters.Add(new SqlParameter("@trainer_30_places", trainer_30_places));
                        cmd_horse.Parameters.Add(new SqlParameter("@trainer_30_shows", trainer_30_shows));
                        cmd_horse.Parameters.Add(new SqlParameter("@trainer_30_roi", trainer_30_roi));
                        //horse stats
                        cmd_horse.Parameters.Add(new SqlParameter("@LIFE_starts", LIFE_starts));
                        cmd_horse.Parameters.Add(new SqlParameter("@LIFE_wins", LIFE_wins));
                        cmd_horse.Parameters.Add(new SqlParameter("@LIFE_places", LIFE_places));
                        cmd_horse.Parameters.Add(new SqlParameter("@LIFE_shows", LIFE_shows));
                        cmd_horse.Parameters.Add(new SqlParameter("@LIFE_roi", LIFE_roi));
                        cmd_horse.Parameters.Add(new SqlParameter("@LIFE_earnings", LIFE_earnings));
                        cmd_horse.Parameters.Add(new SqlParameter("@TY_starts", TY_starts));
                        cmd_horse.Parameters.Add(new SqlParameter("@TY_wins", TY_wins));
                        cmd_horse.Parameters.Add(new SqlParameter("@TY_places", TY_places));
                        cmd_horse.Parameters.Add(new SqlParameter("@TY_shows", TY_shows));
                        cmd_horse.Parameters.Add(new SqlParameter("@TY_roi", TY_roi));
                        cmd_horse.Parameters.Add(new SqlParameter("@TY_earnings", TY_earnings));
                        cmd_horse.Parameters.Add(new SqlParameter("@DST_CRS_starts", DST_CRS_starts));
                        cmd_horse.Parameters.Add(new SqlParameter("@DST_CRS_wins", DST_CRS_wins));
                        cmd_horse.Parameters.Add(new SqlParameter("@DST_CRS_places", DST_CRS_places));
                        cmd_horse.Parameters.Add(new SqlParameter("@DST_CRS_shows", DST_CRS_shows));
                        cmd_horse.Parameters.Add(new SqlParameter("@DST_CRS_roi", DST_CRS_roi));
                        cmd_horse.Parameters.Add(new SqlParameter("@DST_CRS_earnings", DST_CRS_earnings));
                        cmd_horse.Parameters.Add(new SqlParameter("@JOCK_TRAN_starts", JOCK_TRAN_starts));
                        cmd_horse.Parameters.Add(new SqlParameter("@JOCK_TRAN_wins", JOCK_TRAN_wins));
                        cmd_horse.Parameters.Add(new SqlParameter("@JOCK_TRAN_places", JOCK_TRAN_places));
                        cmd_horse.Parameters.Add(new SqlParameter("@JOCK_TRAN_shows", JOCK_TRAN_shows));
                        cmd_horse.Parameters.Add(new SqlParameter("@JOCK_TRAN_roi", JOCK_TRAN_roi));
                        cmd_horse.Parameters.Add(new SqlParameter("@JOCK_TRAN_earnings", JOCK_TRAN_earnings));
                        /*added 7/31/14 */
                        cmd_horse.Parameters.Add(new SqlParameter("@DST_SRF_starts", DST_SRF_starts));
                        cmd_horse.Parameters.Add(new SqlParameter("@DST_SRF_wins", DST_SRF_wins));
                        cmd_horse.Parameters.Add(new SqlParameter("@DST_SRF_places", DST_SRF_places));
                        cmd_horse.Parameters.Add(new SqlParameter("@DST_SRF_shows", DST_SRF_shows));
                        cmd_horse.Parameters.Add(new SqlParameter("@DST_SRF_roi", DST_SRF_roi));
                        cmd_horse.Parameters.Add(new SqlParameter("@DST_SRF_earnings", DST_SRF_earnings));
                        
                        cmd_horse.Parameters.Add(new SqlParameter("@AT_TRK_starts", AT_TRK_starts));
                        cmd_horse.Parameters.Add(new SqlParameter("@AT_TRK_wins", AT_TRK_wins));
                        cmd_horse.Parameters.Add(new SqlParameter("@AT_TRK_places", AT_TRK_places));
                        cmd_horse.Parameters.Add(new SqlParameter("@AT_TRK_shows", AT_TRK_shows));
                        cmd_horse.Parameters.Add(new SqlParameter("@AT_TRK_roi", AT_TRK_roi));
                        cmd_horse.Parameters.Add(new SqlParameter("@AT_TRK_earnings", AT_TRK_earnings));

                        cmd_horse.Parameters.Add(new SqlParameter("@DIRT_starts", DIRT_starts));
                        cmd_horse.Parameters.Add(new SqlParameter("@DIRT_wins", DIRT_wins));
                        cmd_horse.Parameters.Add(new SqlParameter("@DIRT_places", DIRT_places));
                        cmd_horse.Parameters.Add(new SqlParameter("@DIRT_shows", DIRT_shows));
                        cmd_horse.Parameters.Add(new SqlParameter("@DIRT_roi", DIRT_roi));
                        cmd_horse.Parameters.Add(new SqlParameter("@DIRT_earnings", DIRT_earnings));
                        
                        cmd_horse.Parameters.Add(new SqlParameter("@MUD_starts", MUD_starts));
                        cmd_horse.Parameters.Add(new SqlParameter("@MUD_wins", MUD_wins));
                        cmd_horse.Parameters.Add(new SqlParameter("@MUD_places", MUD_places));
                        cmd_horse.Parameters.Add(new SqlParameter("@MUD_shows", MUD_shows));
                        cmd_horse.Parameters.Add(new SqlParameter("@MUD_roi", MUD_roi));
                        cmd_horse.Parameters.Add(new SqlParameter("@MUD_earnings", MUD_earnings));
                        
                        cmd_horse.Parameters.Add(new SqlParameter("@TURF_starts", TURF_starts));
                        cmd_horse.Parameters.Add(new SqlParameter("@TURF_wins", TURF_wins));
                        cmd_horse.Parameters.Add(new SqlParameter("@TURF_places", TURF_places));
                        cmd_horse.Parameters.Add(new SqlParameter("@TURF_shows", TURF_shows));
                        cmd_horse.Parameters.Add(new SqlParameter("@TURF_roi", TURF_roi));
                        cmd_horse.Parameters.Add(new SqlParameter("@TURF_earnings", TURF_earnings));     
                        
                        cmd_horse.Parameters.Add(new SqlParameter("@SOFT_TURF_starts", SOFT_TURF_starts));
                        cmd_horse.Parameters.Add(new SqlParameter("@SOFT_TURF_wins", SOFT_TURF_wins));
                        cmd_horse.Parameters.Add(new SqlParameter("@SOFT_TURF_places", SOFT_TURF_places));
                        cmd_horse.Parameters.Add(new SqlParameter("@SOFT_TURF_shows", SOFT_TURF_shows));
                        cmd_horse.Parameters.Add(new SqlParameter("@SOFT_TURF_roi", SOFT_TURF_roi));
                        cmd_horse.Parameters.Add(new SqlParameter("@SOFT_TURF_earnings", SOFT_TURF_earnings));     
                        
                        cmd_horse.Parameters.Add(new SqlParameter("@OFF_CLM1_starts", OFF_CLM1_starts));
                        cmd_horse.Parameters.Add(new SqlParameter("@OFF_CLM1_wins", OFF_CLM1_wins));
                        cmd_horse.Parameters.Add(new SqlParameter("@OFF_CLM1_places", OFF_CLM1_places));
                        cmd_horse.Parameters.Add(new SqlParameter("@OFF_CLM1_shows", OFF_CLM1_shows));
                        cmd_horse.Parameters.Add(new SqlParameter("@OFF_CLM1_roi", OFF_CLM1_roi));
                        cmd_horse.Parameters.Add(new SqlParameter("@OFF_CLM1_earnings", OFF_CLM1_earnings));              
                          
                        cmd_horse.Parameters.Add(new SqlParameter("@OFF_CLM2_starts", OFF_CLM2_starts));
                        cmd_horse.Parameters.Add(new SqlParameter("@OFF_CLM2_wins", OFF_CLM2_wins));
                        cmd_horse.Parameters.Add(new SqlParameter("@OFF_CLM2_places", OFF_CLM2_places));
                        cmd_horse.Parameters.Add(new SqlParameter("@OFF_CLM2_shows", OFF_CLM2_shows));
                        cmd_horse.Parameters.Add(new SqlParameter("@OFF_CLM2_roi", OFF_CLM2_roi));
                        cmd_horse.Parameters.Add(new SqlParameter("@OFF_CLM2_earnings", OFF_CLM2_earnings));        

                        SqlParameter horse_retValue = cmd_horse.Parameters.Add("return", SqlDbType.Int);
                        horse_retValue.Direction = ParameterDirection.ReturnValue;
                        con.Open();
                        cmd_horse.ExecuteNonQuery();
                        con.Close();
                        Int64 newentryid = Convert.ToInt64(horse_retValue.Value);

                        //Past Performance Data
                        try
                        {
                            if (rdata.racedata[i].horsedata[z].ppdata.Length > 0)
                            {
                                for (int p = 0; p < rdata.racedata[i].horsedata[z].ppdata.Length; p++)
                                {
                                    string pp_rdate = rdata.racedata[i].horsedata[z].ppdata[p].racedate;
                                    string pp_rtype = rdata.racedata[i].horsedata[z].ppdata[p].racetype;
                                    int pp_distance = Convert.ToInt32(rdata.racedata[i].horsedata[z].ppdata[p].distance);
                                    string pp_disttype = rdata.racedata[i].horsedata[z].ppdata[p].disttype;
                                    int pp_purse = Convert.ToInt32(rdata.racedata[i].horsedata[z].ppdata[p].purse);
                                    int pp_classratin = Convert.ToInt32(rdata.racedata[i].horsedata[z].ppdata[p].classratin);
                                    string pp_courseid = rdata.racedata[i].horsedata[z].ppdata[p].courseid;
                                    string pp_surface = rdata.racedata[i].horsedata[z].ppdata[p].surface;

                                    string pp_posfin = rdata.racedata[i].horsedata[z].ppdata[p].positionfi;
                                    decimal pp_lenbackfin = rdata.racedata[i].horsedata[z].ppdata[p].lenbackfin;
                                    decimal pp_horsetimef = rdata.racedata[i].horsedata[z].ppdata[p].horsetimef;
                                    string pp_sr = rdata.racedata[i].horsedata[z].ppdata[p].speedfigur;
                                    string pp_pace = rdata.racedata[i].horsedata[z].ppdata[p].pacefigure;
                                    string pp_pace2 = rdata.racedata[i].horsedata[z].ppdata[p].pacefigur2;
                                    string pp_winsr = rdata.racedata[i].horsedata[z].ppdata[p].winnersspe;

                                    string pp_trackname = rdata.racedata[i].horsedata[z].ppdata[p].trackname;
                                    string pp_tcode = rdata.racedata[i].horsedata[z].ppdata[p].trackcode;
                                    string pp_track = races.GetTrackID(pp_tcode).ToString();
                                    string pp_trackcond = rdata.racedata[i].horsedata[z].ppdata[p].trackcondi;
                                    string pp_tvar = rdata.racedata[i].horsedata[z].ppdata[p].trackvaria;

                                    string pp_post = rdata.racedata[i].horsedata[z].ppdata[p].postpositi;
                                    string pp_weight = rdata.racedata[i].horsedata[z].ppdata[p].weightcarr;
                                    string pp_favorite = rdata.racedata[i].horsedata[z].ppdata[p].favorite;
                                    decimal pp_posttimeod = rdata.racedata[i].horsedata[z].ppdata[p].posttimeod;
                                    string pp_shortcomme = rdata.racedata[i].horsedata[z].ppdata[p].shortcomme;
                                    string pp_longcommen = rdata.racedata[i].horsedata[z].ppdata[p].longcommen;
                                    string pp_abbrevcond = rdata.racedata[i].horsedata[z].ppdata[p].abbrevcond;
                                    string pp_complineho = rdata.racedata[i].horsedata[z].ppdata[p].complineho;
                                    decimal pp_complinele = rdata.racedata[i].horsedata[z].ppdata[p].complinele;
                                    string pp_complineh2 = rdata.racedata[i].horsedata[z].ppdata[p].complineh2;
                                    decimal pp_complinel2 = rdata.racedata[i].horsedata[z].ppdata[p].complinel2;
                                    string pp_complineh3 = rdata.racedata[i].horsedata[z].ppdata[p].complineh3;
                                    decimal pp_complinel3 = rdata.racedata[i].horsedata[z].ppdata[p].complinel3;

                                    int claimed = Convert.ToInt16(rdata.racedata[i].horsedata[z].ppdata[p].horseclaim);

                                    //insert into pp table using entryid as the link
                                    SqlCommand cmd_pp = new SqlCommand("SP_AddPP", con);
                                    cmd_pp.CommandType = CommandType.StoredProcedure;
                                    cmd_pp.Parameters.Add(new SqlParameter("@entryid", newentryid));
                                    cmd_pp.Parameters.Add(new SqlParameter("@rdate", pp_rdate));
                                    cmd_pp.Parameters.Add(new SqlParameter("@rtype", pp_rtype));
                                    cmd_pp.Parameters.Add(new SqlParameter("@purse", pp_purse));
                                    cmd_pp.Parameters.Add(new SqlParameter("@classratin", pp_classratin));
                                    cmd_pp.Parameters.Add(new SqlParameter("@distance", pp_distance));
                                    cmd_pp.Parameters.Add(new SqlParameter("@disttype", pp_disttype));
                                    cmd_pp.Parameters.Add(new SqlParameter("@courseid", pp_courseid));
                                    cmd_pp.Parameters.Add(new SqlParameter("@surface", pp_surface));
                                    cmd_pp.Parameters.Add(new SqlParameter("@posfin", pp_posfin));
                                    cmd_pp.Parameters.Add(new SqlParameter("@lenbackfin", pp_lenbackfin));
                                    cmd_pp.Parameters.Add(new SqlParameter("@horsetimef", pp_horsetimef));
                                    cmd_pp.Parameters.Add(new SqlParameter("@sr", pp_sr));
                                    cmd_pp.Parameters.Add(new SqlParameter("@pace", pp_pace));
                                    cmd_pp.Parameters.Add(new SqlParameter("@pace2", pp_pace2));
                                    cmd_pp.Parameters.Add(new SqlParameter("@winsr", pp_winsr));
                                    cmd_pp.Parameters.Add(new SqlParameter("@trackname", pp_trackname));
                                    cmd_pp.Parameters.Add(new SqlParameter("@tcode", pp_tcode));
                                    cmd_pp.Parameters.Add(new SqlParameter("@track", pp_track));
                                    cmd_pp.Parameters.Add(new SqlParameter("@trackcond", pp_trackcond));
                                    cmd_pp.Parameters.Add(new SqlParameter("@tvar", pp_tvar));
                                    cmd_pp.Parameters.Add(new SqlParameter("@post", pp_post));
                                    cmd_pp.Parameters.Add(new SqlParameter("@weight", pp_weight));
                                    cmd_pp.Parameters.Add(new SqlParameter("@favorite", pp_favorite));
                                    cmd_pp.Parameters.Add(new SqlParameter("@odds", pp_posttimeod));
                                    cmd_pp.Parameters.Add(new SqlParameter("@shortcomme", pp_shortcomme));
                                    cmd_pp.Parameters.Add(new SqlParameter("@longcommen", pp_longcommen));
                                    cmd_pp.Parameters.Add(new SqlParameter("@abbrevcond", pp_abbrevcond));
                                    cmd_pp.Parameters.Add(new SqlParameter("@complineho", pp_complineho));
                                    cmd_pp.Parameters.Add(new SqlParameter("@complinele", pp_complinele));
                                    cmd_pp.Parameters.Add(new SqlParameter("@complineh2", pp_complineh2));
                                    cmd_pp.Parameters.Add(new SqlParameter("@complinel2", pp_complinel2));
                                    cmd_pp.Parameters.Add(new SqlParameter("@complineh3", pp_complineh3));
                                    cmd_pp.Parameters.Add(new SqlParameter("@complinel3", pp_complinel3));
                                    cmd_pp.Parameters.Add(new SqlParameter("@claimed", claimed));
                                    con.Open();
                                    cmd_pp.ExecuteNonQuery();
                                    con.Close();
                                }
                            }
                        }
                        catch (Exception ex) { shared.SaveError("pastperf", ex.ToString()); con.Close(); }

                        //workout data
                        try
                        {
                            if (rdata.racedata[i].horsedata[z].workoutdata.Length > 0)
                            {
                                for (int p = 0; p < rdata.racedata[i].horsedata[z].workoutdata.Length; p++)
                                {
                                    int worknum = Convert.ToInt32(rdata.racedata[i].horsedata[z].workoutdata[p].worknum);
                                    int daysback = Convert.ToInt32(rdata.racedata[i].horsedata[z].workoutdata[p].days_back);
                                    string worktext = rdata.racedata[i].horsedata[z].workoutdata[p].worktext;
                                    int work_rank = Convert.ToInt32(rdata.racedata[i].horsedata[z].workoutdata[p].ranking);
                                    int work_rankgroup = Convert.ToInt32(rdata.racedata[i].horsedata[z].workoutdata[p].rank_group);
                                    DateTime w_dt = tourndate.AddDays(-1 * daysback);

                                    //breakout the worktext to correct fields
                                    //5D(FT)FG :102.0B
                                    //5T // turf
                                    //5D / 5I / 5F dirt
                                    //5E all weather
                                    string w_dist = worktext.Substring(0, 1);
                                    string w_surface = worktext.Substring(1, 1);
                                    if (w_surface == "D" || w_surface == "I" || w_surface == "F") { w_surface = "D"; }
                                    string w_trackcond = worktext.Substring(3, 2);
                                    //find the . in the string             
                                    char[] delimiterChars = { ':' };
                                    string[] split_text = worktext.Split(delimiterChars);
                                    split_text[1] = split_text[1].TrimStart();

                                    string w_trackabbv = split_text[0].Substring(6, (split_text[0].Length - 6)); w_trackabbv.Trim();

                                    int targetindex = split_text[1].IndexOf(".");
                                    string w_time = split_text[1].Substring(0, targetindex + 2);
                                    string w_type = "";
                                    try
                                    {
                                        w_type = split_text[1].Substring(targetindex + 2);
                                    }
                                    catch { }
                                    SqlCommand cmd_wk = new SqlCommand("SP_AddWork", con);
                                    cmd_wk.CommandType = CommandType.StoredProcedure;
                                    cmd_wk.Parameters.Add(new SqlParameter("@entryid", newentryid));
                                    cmd_wk.Parameters.Add(new SqlParameter("@wdate", w_dt.ToShortDateString()));
                                    cmd_wk.Parameters.Add(new SqlParameter("@wnum", worknum));

                                    cmd_wk.Parameters.Add(new SqlParameter("@wrank", work_rank));
                                    cmd_wk.Parameters.Add(new SqlParameter("@wgroup", work_rankgroup));
                                    cmd_wk.Parameters.Add(new SqlParameter("@dist", w_dist));
                                    cmd_wk.Parameters.Add(new SqlParameter("@surface", w_surface));
                                    cmd_wk.Parameters.Add(new SqlParameter("@trackcond", w_trackcond));
                                    cmd_wk.Parameters.Add(new SqlParameter("@trackabbv", w_trackabbv));
                                    cmd_wk.Parameters.Add(new SqlParameter("@time", w_time));
                                    cmd_wk.Parameters.Add(new SqlParameter("@wtype", w_type));
                                    con.Open();
                                    cmd_wk.ExecuteNonQuery();
                                    con.Close();

                                }
                            }
                        }
                        catch (Exception ex) {  shared.SaveError("works", ex.ToString()); con.Close(); }

                    }
                    //after all horses are loaded run the rankings
                    rank.CreateRankings(Convert.ToInt64(newraceid));
                }
            }
        }

        Response.Write("<br/> Races and Horses Loaded.");

        //after loading the races need to autobuild a tournament w/ all the races from that card
        //make sure this card hasn't already been loaded
                
        string sql = "SELECT COUNT(ID) as tcount FROM tournaments WHERE LTRIM(RTRIM(name)) = '" + trackscheduled + " " + tourndate.DayOfWeek.ToString() + "' AND tdate = '" + tourndate + "'";
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        con.Close();
        if (Convert.ToInt16(ds.Tables[0].Rows[0]["tcount"]) == 0)
        {
            races.BuildTournCard_RaceList(racesadded, 15.00, trackscheduled + " " + tourndate.DayOfWeek.ToString(), tourndate, 50);
        }


        
    }

    protected void ULComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        AjaxControlToolkit.AsyncFileUpload fileupload = (AjaxControlToolkit.AsyncFileUpload)sender;
        //Upload files
        if (fileupload.HasFile)
        {
            //use newly created id to name file
            string newfilename = Path.GetFileNameWithoutExtension(fileupload.FileName);
            string savepath = Server.MapPath("~/admin/xml/");
            string extension = Path.GetExtension(fileupload.FileName);

            string newfile = shared.SaveFile(fileupload.PostedFile, newfilename, savepath, extension);
            LoadXML(newfile);
        }
    }

   
   
}