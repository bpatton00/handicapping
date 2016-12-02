using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;

namespace Capping
{
    /// <summary>
    /// Summary description for results
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class results : System.Web.Services.WebService
    {

        [WebMethod]
        public List<trackresults> getRecentResults(List<string> pData)
        {
            List<trackresults> p = new List<trackresults>();

            using (SqlConnection cn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString))
            {
                string myQuery = "SELECT rdate, tracks.abbrev, COUNT(DISTINCT races.id) as races, SUM(CASE WHEN (officialfinish = 1 AND entries.ccrank = 1) THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN ccscore > .19 and ccrank = 1 THEN 1 ELSE 0 END) as strong_races, SUM(CASE WHEN (officialfinish = 1 AND entries.ccrank = 1 AND entries.ccscore > .19) THEN 1 ELSE 0 END) as strong_winners, SUM(CASE WHEN (officialfinish <= 3 AND entries.ccrank = 1) THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN entry_results.officialfinish = 1 AND ccrank = 1 THEN entry_results.winpayoff ELSE 0 END) as toppick_winpays, SUM(CASE WHEN entry_results.officialfinish <= 3 AND ccrank = 1 THEN (entry_results.winpayoff + entry_results.placepayoff + entry_results.showpayoff) ELSE 0 END) as toppick_boardpays, SUM(CASE WHEN entry_results.officialfinish = 1 AND ccrank = 1 AND ccscore > .19 THEN entry_results.winpayoff ELSE 0 END) as strong_toppick_winpays, SUM(CASE WHEN entry_results.officialfinish <= 1 AND ccrank = 1 AND ccscore > .19 THEN (entry_results.winpayoff + entry_results.placepayoff + entry_results.showpayoff) ELSE 0 END) as strong_toppick_boardpays, SUM(CASE WHEN entry_results.officialfinish = 1 AND ccrank = 1 THEN entry_results.winpayoff ELSE 0 END) as secondpick_winpays, SUM(CASE WHEN entry_results.officialfinish <= 3 AND ccrank = 2 THEN (entry_results.winpayoff + entry_results.placepayoff + entry_results.showpayoff) ELSE 0 END) as secondpick_boardpays, SUM(CASE WHEN entry_results.officialfinish = 1 AND ccrank = 2 AND ccscore > .19 THEN entry_results.winpayoff ELSE 0 END) as strong_secondpick_winpays, SUM(CASE WHEN entry_results.officialfinish <= 1 AND ccrank = 2 AND ccscore > .19 THEN (entry_results.winpayoff + entry_results.placepayoff + entry_results.showpayoff) ELSE 0 END) as strong_secondpick_boardpays FROM entry_results INNER JOIN entries ON entries.id = entry_results.entryid INNER JOIN races ON entries.raceid = races.id INNER JOIN tracks on races.track = tracks.id WHERE races.track = @track GROUP BY races.rdate, tracks.abbrev ORDER BY rdate desc";
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = myQuery;
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@track", pData[0]);
                cmd.Connection = cn;
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        trackresults trData = new trackresults();
                        trData.abbreviation = dr["abbrev"].ToString();
                        trData.races = Convert.ToInt32(dr["races"].ToString());
                        trData.winners = Convert.ToInt32(dr["winners"].ToString());
                        trData.rdate = Convert.ToDateTime(dr["rdate"].ToString()).ToShortDateString();
                        trData.toppick_winpays = Convert.ToDouble(dr["toppick_winpays"].ToString());
                        trData.toppick_boardpays = Convert.ToDouble(dr["toppick_boardpays"].ToString());
                        trData.strong_toppick_winpays = Convert.ToDouble(dr["strong_toppick_winpays"].ToString());
                        trData.strong_toppick_boardpays = Convert.ToDouble(dr["strong_toppick_boardpays"].ToString());
                        
                        trData.json = new Item { meta = dr["winners"].ToString() + " winners @" + trData.toppick_boardpays.ToString("c2"), value = trData.toppick_boardpays.ToString() };                        
                        p.Add(trData);
                    }
                }
            }
            return p;
        }

        [WebMethod]
        public List<trackresults> getRecentResultsALL(List<string> pData)
        {
            List<trackresults> p = new List<trackresults>();

            using (SqlConnection cn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString))
            {
                string myQuery = "SELECT rdate, tracks.abbrev, COUNT(DISTINCT races.id) as races, SUM(CASE WHEN (officialfinish = 1 AND entries.ccrank = 1) THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN ccscore > .19 and ccrank = 1 THEN 1 ELSE 0 END) as strong_races, SUM(CASE WHEN (officialfinish = 1 AND entries.ccrank = 1 AND entries.ccscore > .19) THEN 1 ELSE 0 END) as strong_winners, SUM(CASE WHEN (officialfinish <= 3 AND entries.ccrank = 1) THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN entry_results.officialfinish = 1 AND ccrank = 1 THEN entry_results.winpayoff ELSE 0 END) as toppick_winpays, SUM(CASE WHEN entry_results.officialfinish <= 3 AND ccrank = 1 THEN (entry_results.winpayoff + entry_results.placepayoff + entry_results.showpayoff) ELSE 0 END) as toppick_boardpays, SUM(CASE WHEN entry_results.officialfinish = 1 AND ccrank = 1 AND ccscore > .19 THEN entry_results.winpayoff ELSE 0 END) as strong_toppick_winpays, SUM(CASE WHEN entry_results.officialfinish <= 1 AND ccrank = 1 AND ccscore > .19 THEN (entry_results.winpayoff + entry_results.placepayoff + entry_results.showpayoff) ELSE 0 END) as strong_toppick_boardpays, SUM(CASE WHEN entry_results.officialfinish = 1 AND ccrank = 1 THEN entry_results.winpayoff ELSE 0 END) as secondpick_winpays, SUM(CASE WHEN entry_results.officialfinish <= 3 AND ccrank = 2 THEN (entry_results.winpayoff + entry_results.placepayoff + entry_results.showpayoff) ELSE 0 END) as secondpick_boardpays, SUM(CASE WHEN entry_results.officialfinish = 1 AND ccrank = 2 AND ccscore > .19 THEN entry_results.winpayoff ELSE 0 END) as strong_secondpick_winpays, SUM(CASE WHEN entry_results.officialfinish <= 1 AND ccrank = 2 AND ccscore > .19 THEN (entry_results.winpayoff + entry_results.placepayoff + entry_results.showpayoff) ELSE 0 END) as strong_secondpick_boardpays FROM entry_results INNER JOIN entries ON entries.id = entry_results.entryid INNER JOIN races ON entries.raceid = races.id INNER JOIN tracks on races.track = tracks.id GROUP BY races.rdate, tracks.abbrev ORDER BY rdate desc";
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = myQuery;
                cmd.CommandType = CommandType.Text;
                //cmd.Parameters.AddWithValue("@track", pData[0]);
                cmd.Connection = cn;
                cn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        trackresults trData = new trackresults();
                        trData.abbreviation = dr["abbrev"].ToString();
                        trData.races = Convert.ToInt32(dr["races"].ToString());
                        trData.winners = Convert.ToInt32(dr["winners"].ToString());
                        trData.rdate = Convert.ToDateTime(dr["rdate"].ToString()).ToShortDateString();
                        trData.toppick_winpays = Convert.ToDouble(dr["toppick_winpays"].ToString());
                        trData.toppick_boardpays = Convert.ToDouble(dr["toppick_boardpays"].ToString());
                        trData.strong_toppick_winpays = Convert.ToDouble(dr["strong_toppick_winpays"].ToString());
                        trData.strong_toppick_boardpays = Convert.ToDouble(dr["strong_toppick_boardpays"].ToString());                        
                        p.Add(trData);
                    }
                }
            }
            return p;
        }

        public class trackresults
        {
            public string abbreviation { get; set; }            
            public int races { get; set; }
            public int strongraces { get; set; }
            public int winners { get; set; }
            public int strongwinners { get; set; }            
            public int itm { get; set; }
            public double toppick_winpays { get; set; }
            public double toppick_boardpays { get; set; }
            public double strong_toppick_winpays { get; set; }
            public double strong_toppick_boardpays { get; set; }
            public Item json { get; set; }
            public string rdate { get; set; }            
        }
        public class Item
        {
            public string meta { get; set; }
            public string value { get; set; }
        }
    }

}
