using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;

public partial class test_p5maker : System.Web.UI.Page
{
    [Serializable]
    protected struct RaceEntry
    {
        public Int64 entryid;
        public string program;
        public int ccrank;
        public double ccscore;
        public int race;

        public RaceEntry(Int64 entryid, string program, int ccrank, double ccscore, int race)
        {    
            this.entryid = entryid;
            this.program = program;
            this.ccrank = ccrank;
            this.ccscore = ccscore;
            this.race = race;
        }

    }
    public static T DeepCopy<T>(T item)
    {
        System.Runtime.Serialization.Formatters.Binary.BinaryFormatter formatter = new System.Runtime.Serialization.Formatters.Binary.BinaryFormatter();
        System.IO.MemoryStream stream = new System.IO.MemoryStream();
        formatter.Serialize(stream, item);
        stream.Seek(0, System.IO.SeekOrigin.Begin);
        T result = (T)formatter.Deserialize(stream);
        stream.Close();
        return result;
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ButtonMakePicks_Click(object sender, EventArgs e)
    {
        double wageramount = Convert.ToDouble(DDLAmount.SelectedValue);
        double totalwager = 0;
        double maxwager = Convert.ToDouble(DDLTargetPrice.SelectedValue);
        int ticketsize = 0;
        int begrace = Convert.ToInt16(DDLBegRace.SelectedValue);
        int endrace = Convert.ToInt16(DDLEndRace.SelectedValue);
        LiteralPicks.Text = "";
        LiteralPicks.Text += "<span class\"title-sm hr-before\">" + DDLTrack.SelectedItem.Text + " racces " + begrace + " thru " + endrace + "</span>";
        try
        {
            int track = Convert.ToInt16(DDLTrack.SelectedValue);
            string rdate = Convert.ToString(DDLDate.SelectedValue);
            //build picks 
            List<RaceEntry> selected = new List<RaceEntry>();

            List<RaceEntry>[] ticket = new List<RaceEntry>[21];
            List<RaceEntry>[] raceA = new List<RaceEntry>[21];
            List<RaceEntry>[] raceB = new List<RaceEntry>[21];
            List<RaceEntry>[] raceC = new List<RaceEntry>[21];
            List<RaceEntry>[] raceALL = new List<RaceEntry>[21];
            List<RaceEntry> complete = new List<RaceEntry>();

            //inits
            for (int i = 0; i < raceA.Length; ++i)
                ticket[i] = new List<RaceEntry>();
            for (int i = 0; i < raceA.Length; ++i)
                raceA[i] = new List<RaceEntry>();
            for (int i = 0; i < raceB.Length; ++i)
                raceB[i] = new List<RaceEntry>();
            for (int i = 0; i < raceC.Length; ++i)
                raceC[i] = new List<RaceEntry>();
            for (int i = 0; i < raceALL.Length; ++i)
                raceALL[i] = new List<RaceEntry>();


            //for each race from start to finish 
            for (int i = begrace; i <= endrace; i++)
            {
                SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
                string sql = "SELECT entries.id, ccrank, ccscore, ccpoints, program FROM entries INNER JOIN races on entries.raceid = races.id WHERE track = " + track + " AND rdate = '" + rdate + "' AND rnum = " + i + " AND scratched = 'False' ORDER BY post";
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
                    try
                    {
                        if (Convert.ToInt16(dr["ccrank"]) == 1) { raceA[i].Add(new RaceEntry(Convert.ToInt64(dr["id"]), Convert.ToString(dr["program"]), Convert.ToInt16(dr["ccrank"]), Convert.ToDouble(dr["ccscore"]), i)); }
                        if (Convert.ToInt16(dr["ccrank"]) > 1 && Convert.ToDouble(dr["ccscore"]) >= .20) { raceA[i].Add(new RaceEntry(Convert.ToInt64(dr["id"]), Convert.ToString(dr["program"]), Convert.ToInt16(dr["ccrank"]), Convert.ToDouble(dr["ccscore"]), i)); }
                        if (Convert.ToInt16(dr["ccrank"]) > 1 && Convert.ToDouble(dr["ccscore"]) >= .12 && Convert.ToDouble(dr["ccscore"]) < .20) { raceB[i].Add(new RaceEntry(Convert.ToInt64(dr["id"]), Convert.ToString(dr["program"]), Convert.ToInt16(dr["ccrank"]), Convert.ToDouble(dr["ccscore"]), i)); }
                        if (Convert.ToInt16(dr["ccrank"]) > 1 && Convert.ToDouble(dr["ccscore"]) >= .07 && Convert.ToDouble(dr["ccscore"]) < .12) { raceC[i].Add(new RaceEntry(Convert.ToInt64(dr["id"]), Convert.ToString(dr["program"]), Convert.ToInt16(dr["ccrank"]), Convert.ToDouble(dr["ccscore"]), i)); }
                        raceALL[i].Add(new RaceEntry(Convert.ToInt64(dr["id"]), Convert.ToString(dr["program"]), Convert.ToInt16(dr["ccrank"]), Convert.ToDouble(dr["ccscore"]), i));
                        complete.Add(new RaceEntry(Convert.ToInt64(dr["id"]), Convert.ToString(dr["program"]), Convert.ToInt16(dr["ccrank"]), Convert.ToDouble(dr["ccscore"]), i));
                    }
                    catch (Exception ex) { LiteralAlerts.Text += "<br/> Race #" + i + " " + ex.ToString(); }

                }
            }
            //debug
            /*
            for (int i = begrace; i <= endrace; i++)
            {

                LiteralAlerts.Text += "<br/> Race #" + i + " Counts A(" + raceA[i].Count + ") " + " Counts B(" + raceB[i].Count + ") " + " Counts C(" + raceC[i].Count + ") ";
            }*/
            //add results
            //A List
            LiteralPicks.Text += "<div class=\"row\">";
            LiteralPicks.Text += "<div class=\"col-xs-12 col-md-4\"><div class=\"panel panel-default\"><div class=\"panel-heading\">A list Horses</div><div class=\"panel-body\">";
            for (int i = begrace; i <= endrace; i++)
            {
                raceA[i].Sort(delegate (RaceEntry r1, RaceEntry r2) { return r2.ccscore.CompareTo(r1.ccscore); });
                LiteralPicks.Text += "<div class=\"input-group racepicks\"> <span class=\"input-group-addon\">Race " + i + ": </span>";
                bool firstentry = true;
                LiteralPicks.Text += "<div class=\"form-control\">";
                foreach (RaceEntry re in raceA[i])
                {
                    if (!firstentry) { LiteralPicks.Text += "&nbsp;"; }
                    LiteralPicks.Text += "<span class=\"blanket horse" + races.GetSaddleClothNumber(re.program).ToString() + "\"  data-toggle=\"tooltip\" data-placement=\"top\"  data-original-title=\"" + entries.GetHorseName(re.entryid) + "\">" + re.program + "</span>";
                    firstentry = false;
                }
                LiteralPicks.Text += "</div>"; //end form-control
                LiteralPicks.Text += "</div>";
            }
            LiteralPicks.Text += "</div></div></div>";


            //B
            LiteralPicks.Text += "<div class=\"col-xs-12 col-md-4\"><div class=\"panel panel-default\"><div class=\"panel-heading\">B list Horses</div><div class=\"panel-body\">";
            for (int i = begrace; i <= endrace; i++)
            {
                raceB[i].Sort(delegate (RaceEntry r1, RaceEntry r2) { return r2.ccscore.CompareTo(r1.ccscore); });
                LiteralPicks.Text += "<div class=\"input-group racepicks\"> <span class=\"input-group-addon\">Race " + i + ": </span>";
                bool firstentry = true;
                LiteralPicks.Text += "<div class=\"form-control\">";
                foreach (RaceEntry re in raceB[i])
                {
                    if (!firstentry) { LiteralPicks.Text += "&nbsp;"; }
                    LiteralPicks.Text += "<span class=\"blanket horse" + races.GetSaddleClothNumber(re.program).ToString() + "\"  data-toggle=\"tooltip\" data-placement=\"top\"  data-original-title=\"" + entries.GetHorseName(re.entryid) + "\">" + re.program + "</span>";
                    firstentry = false;
                }
                LiteralPicks.Text += "</div>"; //end form-control
                LiteralPicks.Text += "</div>";
            }
            LiteralPicks.Text += "</div></div></div>";
            //C
            //B
            LiteralPicks.Text += "<div class=\"col-xs-12 col-md-4\"><div class=\"panel panel-default\"><div class=\"panel-heading\">C list Horses</div><div class=\"panel-body\">";
            for (int i = begrace; i <= endrace; i++)
            {
                raceC[i].Sort(delegate (RaceEntry r1, RaceEntry r2) { return r2.ccscore.CompareTo(r1.ccscore); });
                LiteralPicks.Text += "<div class=\"input-group racepicks\"> <span class=\"input-group-addon\">Race " + i + ": </span>";
                bool firstentry = true;
                LiteralPicks.Text += "<div class=\"form-control\">";
                foreach (RaceEntry re in raceC[i])
                {
                    if (!firstentry) { LiteralPicks.Text += "&nbsp;"; }
                    LiteralPicks.Text += "<span class=\"blanket horse" + races.GetSaddleClothNumber(re.program).ToString() + "\"  data-toggle=\"tooltip\" data-placement=\"top\"  data-original-title=\"" + entries.GetHorseName(re.entryid) + "\">" + re.program + "</span>";
                    firstentry = false;
                }
                LiteralPicks.Text += "</div>"; //end form-control
                LiteralPicks.Text += "</div>";
            }
            LiteralPicks.Text += "</div></div></div>";
            LiteralPicks.Text += "</div>"; //close row

            //ALL
            //LiteralPicks.Text += "<br/><b>ALL list Horses</b><br/>";
            for (int i = begrace; i <= endrace; i++)
            {
                raceALL[i].Sort(delegate (RaceEntry r1, RaceEntry r2) { return r2.ccscore.CompareTo(r1.ccscore); });
                /*LiteralPicks.Text += "<br/><div class=\"RaceHeader\"> <span>Race " + i + ": </span>";
                bool firstentry = true;
                foreach (RaceEntry re in raceALL[i])
                {
                    if (!firstentry) { LiteralPicks.Text += "&nbsp;"; }
                    LiteralPicks.Text += re.program;
                    firstentry = false;
                }
                LiteralPicks.Text += "</div>";
                */
            }


            //now that we have them in order - put together a ticket
            //first add all the top picks
            double ticketprice = 0;
            for (int i = begrace; i <= endrace; i++)
            {
                ticket[i].Add(raceA[i][0]);
                selected.Add(raceA[i][0]);
            }

            //go through and find the next most likely winner -- this is probably going to be done by comparing %'s to the currently selected horses, 
            //so if there is no clear favorite, then multiple selections would be better than choosing a second choice who is behind a clear favorite 
            //perhaps look at horses in the ticket and reverse sort them by confidence
            //each race is already sorted by confidence raceALL
            //go through list of all horses and fill in based on confidence
            complete.Sort(delegate (RaceEntry r1, RaceEntry r2) { return r2.ccscore.CompareTo(r1.ccscore); });

            complete.ForEach(delegate (RaceEntry re)
            {
                //if this horse is not in the list, add them
                if (!selected.Contains(re))
                {
                    //temp ticket (used to  check to make sure the last horse added didn't set us over budget)
                    List<RaceEntry>[] tempticket = new List<RaceEntry>[21];
                    for (int i = begrace; i <= endrace; i++)
                    {
                        tempticket[i] = new List<RaceEntry>(ticket[i]);
                    }
                    tempticket[re.race].Add(re);
                        if ((CalculateTicketPrice(tempticket, wageramount, begrace, endrace)) < maxwager) { selected.Add(re); ticket[re.race].Add(re); }
                }
            });
            LiteralPicks.Text += "<div class=\"row\">";
            LiteralPicks.Text += "<div class=\"col-xs-12 col-lg-6 col-lg-offset-3\">";
            LiteralPicks.Text += "<div class=\"panel panel-primary\"><div class=\"panel-heading\">Final Ticket</div><div class=\"panel-body\">";
            for (int i = begrace; i <= endrace; i++)
            {
                ticket[i].Sort(delegate(RaceEntry r1, RaceEntry r2) { return r2.ccscore.CompareTo(r1.ccscore); });
                LiteralPicks.Text += "<div class=\"input-group racepicks\"> <span class=\"input-group-addon\">Race " + i + ": </span>";
                bool firstentry = true;
                LiteralPicks.Text += "<div class=\"form-control\">";
                foreach (RaceEntry re in ticket[i])
                {
                    if (!firstentry) { LiteralPicks.Text += "&nbsp;"; }
                    LiteralPicks.Text += "<span class=\"blanket horse" + races.GetSaddleClothNumber(re.program).ToString() + "\"  data-toggle=\"tooltip\" data-placement=\"top\"  data-original-title=\"" + entries.GetHorseName(re.entryid) +  "- Score: " + re.ccscore.ToString("p0") + "\">" + re.program + "</span>";
                    //include odds and %'s here?
                    
                    firstentry = false;

                }
                LiteralPicks.Text += "</div>"; //end form-control
                LiteralPicks.Text += "</div>";
            }
            ticketprice = CalculateTicketPrice(ticket, wageramount, begrace, endrace);

            LiteralPicks.Text += "<br/><br/><b>Combinations: " + CountCombinations(ticket, begrace, endrace) + "</b>";

            LiteralPicks.Text += "<br/><br/><div class=\"input-group\">Final Ticket Price:<div class=\"form-control\">" + ticketprice.ToString("C2") + "</div></div>";

            LiteralPicks.Text += "</div></div>";
            LiteralPicks.Text += "</div>"; //close col
            LiteralPicks.Text += "</div>"; //close row

        }
        catch (Exception ex)
        {
            LiteralAlerts.Text += "<br/>Outer Error: " + ex.ToString();
        }
    }

    protected double CalculateTicketPrice(List<RaceEntry>[] ticket, double wageramount, int begrace, int endrace)
    {
        double ticketprice = 0;


        ticketprice = wageramount * CountCombinations(ticket, begrace, endrace); ;
        return ticketprice;
    }
    protected double CountCombinations(List<RaceEntry>[] ticket, int begrace, int endrace)
    {
        int combinations = 1;
        //picks in 1 x 2 x 3 x 4 etc
        for (int i = begrace; i <= endrace; i++)
        {
            if (ticket[i].Count > 0)
                combinations = (ticket[i].Count * combinations);
        }
        return combinations;
    }
}