using System;
using System.Data;
using System.IO;
using System.Data.SqlClient;
using System.Globalization;
using System.Data.OleDb;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Serialization;
using System.Xml;


public partial class admin_addresults : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void LoadCSV(string csvfile)
    {
        string path = Server.MapPath("~/admin/csv/" + csvfile);
        string full = Path.GetFullPath(path);
        string file = Path.GetFileName(full);
        string dir = Path.GetDirectoryName(full);

        //create the "database" connection string 
        //Microsoft.ACE.OLEDB.12.0
        string connString = "Provider=Microsoft.Jet.OLEDB.4.0;"
          + "Data Source=\"" + dir + "\\\";"
          + "Extended Properties=\"text;HDR=No;FMT=Delimited\"";
        //LabelStatus.Text += "<br/>";
        //LabelStatus.Text+= connString + "<br/>";
        //LabelStatus.Text += "<br/>File Location: " + dir + "\\" + file;
        //LabelStatus.Text += "<br/>Exists: " + System.IO.File.Exists(dir + "\\" + file) + "<br/>" + System.IO.File.ReadAllText(dir + "\\" + file) + "<br/><br/>";
        //create the database query
        string query = "SELECT * FROM " + csvfile;
        //create a DataTable to hold the query results
        DataTable dTable = new DataTable();
        //create an OleDbDataAdapter to execute the query
        OleDbDataAdapter dAdapter = new OleDbDataAdapter(query, connString);
        try
        {
            //fill the DataTable
            dAdapter.Fill(dTable);
        }
        catch (InvalidOperationException /*e*/)
        { }


        dAdapter.Dispose();

        LabelStatus.Text += "Loading Inormation";
        try
        {
            //LoadInfo(dTable);
            ProcessCSV(dTable);
        }
        catch (Exception ex) { LabelStatus.Text = "Error Loading csv: " + ex.ToString(); }
        
    }

    protected void LoadXML(string xmlfile)
    {      
        string trackscheduled = "";
        DateTime racedate;

        try
        {
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);

            XmlSerializer ser = new XmlSerializer(typeof(CHART));
            CHART rdata;
            string path = Server.MapPath("~/admin/xml/" + xmlfile);
            using (XmlReader reader = XmlReader.Create(path))
            {
                rdata = (CHART)ser.Deserialize(reader);
            }
            for (int i = 0; i < rdata.RACE.Length; i++)
            {
                if (rdata.RACE[i] != null)
                {
                    if (i == 0)
                    {
                        trackscheduled = races.GetTrackID(rdata.TRACK.CODE).ToString(); //need to cast this as the integer based on the abbreviation and the mathcing id from tracks
                        //RACE_DATE="2015-07-13"
                        //racedate = DateTime.ParseExact(rdata.RACE_DATE.ToString(), "yyyy-MM-dd", CultureInfo.InvariantCulture);

                    }

                    racedate = rdata.RACE_DATE;
                    //loop through each result in the race
                    for (int r = 0; r < rdata.RACE[i].ENTRY.Length; r++)
                    {
                        Int64 raceid;
                        string track;
                        int racenum;
                        Int64 entryid;
                        int postpos;
                        int finish;
                        int officialfinish;
                        decimal finalodds;
                        decimal winpayoff;
                        decimal placepayoff;
                        decimal showpayoff;
                        int weight;
                        decimal finaltime;
                        string trackcondition;

                        track = rdata.TRACK.CODE;
                        racenum = Convert.ToInt16(rdata.RACE[i].NUMBER);
                        postpos = Convert.ToInt16(rdata.RACE[i].ENTRY[r].POST_POS);
                        finish = Convert.ToInt16(rdata.RACE[i].ENTRY[r].POINT_OF_CALL[5].POSITION);
                        officialfinish = Convert.ToInt16(rdata.RACE[i].ENTRY[r].OFFICIAL_FIN);
                        finaltime = rdata.RACE[i].WIN_TIME;
                        finalodds = rdata.RACE[i].ENTRY[r].DOLLAR_ODDS;
                        winpayoff = rdata.RACE[i].ENTRY[r].WIN_PAYOFF;
                        placepayoff = rdata.RACE[i].ENTRY[r].PLACE_PAYOFF;
                        showpayoff = rdata.RACE[i].ENTRY[r].SHOW_PAYOFF;
                        weight = Convert.ToInt16(rdata.RACE[i].ENTRY[r].WEIGHT);
                        trackcondition = rdata.RACE[i].TRK_COND;


                        string sqlRace = "SELECT races.id FROM races INNER JOIN tracks ON races.track = tracks.id WHERE (races.rdate = '" + racedate.ToShortDateString() + "') AND (races.rnum = '" + racenum + "') AND (tracks.abbrev = '" + track.ToUpper().Trim() + "')";
                        //LabelStatus.Text += "<br/>" + sqlRace;
                        SqlCommand myCommandRace = new SqlCommand(sqlRace, con);
                        con.Open();
                        SqlDataReader myReaderRace = myCommandRace.ExecuteReader(CommandBehavior.CloseConnection);
                        DataTable dtRace = new DataTable();
                        dtRace.Load(myReaderRace);
                        DataSet dsRace = new DataSet();
                        dsRace.Tables.Add(dtRace);
                        con.Close();
                        raceid = Convert.ToInt64(dsRace.Tables[0].Rows[0]["id"]);


                        string sqlEntry = "SELECT id FROM entries where raceid = " + raceid + " and post = " + postpos + "";
                        SqlCommand myCommandEntry = new SqlCommand(sqlEntry, con);
                        con.Open();
                        SqlDataReader myReaderEntry = myCommandEntry.ExecuteReader(CommandBehavior.CloseConnection);
                        DataTable dtEntry = new DataTable();
                        dtEntry.Load(myReaderEntry);
                        DataSet dsEntry = new DataSet();
                        dsEntry.Tables.Add(dtEntry);
                        con.Close();
                        entryid = Convert.ToInt64(dsEntry.Tables[0].Rows[0]["id"]);

                        SqlCommand cmd = new SqlCommand("SP_AddEntryResult", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add(new SqlParameter("@raceid", raceid));
                        cmd.Parameters.Add(new SqlParameter("@entryid ", entryid));
                        cmd.Parameters.Add(new SqlParameter("@finish", finish));
                        cmd.Parameters.Add(new SqlParameter("@officialfinish", officialfinish));
                        cmd.Parameters.Add(new SqlParameter("@finalodds", finalodds));
                        cmd.Parameters.Add(new SqlParameter("@winpayoff", winpayoff));
                        cmd.Parameters.Add(new SqlParameter("@placepayoff", placepayoff));
                        cmd.Parameters.Add(new SqlParameter("@showpayoff", showpayoff));
                        cmd.Parameters.Add(new SqlParameter("@weight", weight));
                        cmd.Parameters.Add(new SqlParameter("@finaltime", finaltime));
                        cmd.Parameters.Add(new SqlParameter("@trackcondition", trackcondition));

                        //SqlParameter retValue = cmd.Parameters.Add("return", SqlDbType.Int);
                        //retValue.Direction = ParameterDirection.ReturnValue;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
//                        Int64 newraceid = Convert.ToInt64(retValue.Value);

                    }


                    //when done process cpu picks ?


                }
            }
        }
        catch (Exception ex)
        { shared.SaveError("addresults.aspx", ex.GetBaseException().ToString()); }

        Response.Write("<br/> Results Loaded.");
    }

    private void ProcessCSV(DataTable dTable)
    {

        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);

        string trackscheduled = "";
        DateTime racedate;
        Int64 raceid;
        string track;
        int racenum;
        Int64 entryid;
        int postpos;
        int finish;
        int officialfinish;
        decimal finalodds;
        decimal winpayoff;
        decimal placepayoff;
        decimal showpayoff;
        int weight;
        decimal finaltime;
        string trackcondition;
        string program = "";

        //each record will be from the same track and day -- only load once
        //race number will change, therefore raceid will change
        //need to find entryid each time

        // For each row, print the values of each column.
        foreach (DataRow row in dTable.Rows)
        {
            try
            {
                if (Convert.ToString(row[8]).Trim() != "SCR" && Convert.ToInt16(row[7]) != 99)
                {
                    //comprehensive format
                    //columns to write
                    //using  file 2 of the comprehensive
                    //0 Track
                    track = row[0].ToString().Trim();
                    //1 Date
                    //format date
                    racedate = DateTime.ParseExact(row[1].ToString(),
                                            "yyyyMMdd",
                                            CultureInfo.InvariantCulture,
                                            DateTimeStyles.None);
                    //2 Race Num
                    racenum = Convert.ToInt16(row[2]);

                    //7 post position
                    postpos = Convert.ToInt16(row[7]);
                    //8 program number
                    program = Convert.ToString(row[8]).Trim();

                    //30 odds
                    finalodds = Convert.ToDecimal(row[30]);

                    //37 weight
                    weight = Convert.ToInt16(row[37]);

                    //50 win payoff
                    if (string.IsNullOrEmpty(row[50].ToString()))
                    { winpayoff = 0; }
                    else { winpayoff = Convert.ToDecimal(row[50]); }

                    //51 place payoff
                    if (string.IsNullOrEmpty(row[51].ToString()))
                    { placepayoff = 0; }
                    else { placepayoff = Convert.ToDecimal(row[51]); }

                    //52 show payoff
                    if (string.IsNullOrEmpty(row[52].ToString()))
                    { showpayoff = 0; }
                    else { showpayoff = Convert.ToDecimal(row[52]); }

                    //59 Finish Position
                    finish = Convert.ToInt16(row[59]);
                    //60 Official Position
                    officialfinish = Convert.ToInt16(row[60]);

                    finaltime = 0;
                    trackcondition = "na";

                    //find the entryid - raceid 
                    string sqlRace = "SELECT races.id FROM races INNER JOIN tracks ON races.track = tracks.id WHERE (races.rdate = '" + racedate.ToShortDateString() + "') AND (races.rnum = '" + racenum + "') AND (tracks.abbrev = '" + track.ToUpper().Trim() + "')";
                    //LabelStatus.Text += "<br/>" + sqlRace;
                    SqlCommand myCommandRace = new SqlCommand(sqlRace, con);
                    con.Open();
                    SqlDataReader myReaderRace = myCommandRace.ExecuteReader(CommandBehavior.CloseConnection);
                    DataTable dtRace = new DataTable();
                    dtRace.Load(myReaderRace);
                    DataSet dsRace = new DataSet();
                    dsRace.Tables.Add(dtRace);
                    con.Close();
                    raceid = Convert.ToInt64(dsRace.Tables[0].Rows[0]["id"]);


                    string sqlEntry = "SELECT id FROM entries where raceid = " + raceid + " and program = '" + program + "'";
                    SqlCommand myCommandEntry = new SqlCommand(sqlEntry, con);
                    con.Open();
                    SqlDataReader myReaderEntry = myCommandEntry.ExecuteReader(CommandBehavior.CloseConnection);
                    DataTable dtEntry = new DataTable();
                    dtEntry.Load(myReaderEntry);
                    DataSet dsEntry = new DataSet();
                    dsEntry.Tables.Add(dtEntry);
                    con.Close();
                    entryid = Convert.ToInt64(dsEntry.Tables[0].Rows[0]["id"]);

                    SqlCommand cmd = new SqlCommand("SP_AddEntryResult", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add(new SqlParameter("@raceid", raceid));
                    cmd.Parameters.Add(new SqlParameter("@entryid ", entryid));
                    cmd.Parameters.Add(new SqlParameter("@finish", finish));
                    cmd.Parameters.Add(new SqlParameter("@officialfinish", officialfinish));
                    cmd.Parameters.Add(new SqlParameter("@finalodds", finalodds));
                    cmd.Parameters.Add(new SqlParameter("@winpayoff", winpayoff));
                    cmd.Parameters.Add(new SqlParameter("@placepayoff", placepayoff));
                    cmd.Parameters.Add(new SqlParameter("@showpayoff", showpayoff));
                    cmd.Parameters.Add(new SqlParameter("@weight", weight));
                    cmd.Parameters.Add(new SqlParameter("@finaltime", finaltime));
                    cmd.Parameters.Add(new SqlParameter("@trackcondition", trackcondition));

                    //SqlParameter retValue = cmd.Parameters.Add("return", SqlDbType.Int);
                    //retValue.Direction = ParameterDirection.ReturnValue;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    //LabelStatus.Text += "Horse : " + program;
                }
                //horse is scratched, update it's entry
                else
                {
                    //0 Track
                    track = row[0].ToString().Trim();
                    //1 Date
                    //format date
                    racedate = DateTime.ParseExact(row[1].ToString(),
                                            "yyyyMMdd",
                                            CultureInfo.InvariantCulture,
                                            DateTimeStyles.None);
                    //2 Race Num
                    racenum = Convert.ToInt16(row[2]);

                    //find the entryid - raceid 
                    string sqlRace = "SELECT races.id FROM races INNER JOIN tracks ON races.track = tracks.id WHERE (races.rdate = '" + racedate.ToShortDateString() + "') AND (races.rnum = '" + racenum + "') AND (tracks.abbrev = '" + track.ToUpper().Trim() + "')";
                    //LabelStatus.Text += "<br/>" + sqlRace;
                    SqlCommand myCommandRace = new SqlCommand(sqlRace, con);
                    con.Open();
                    SqlDataReader myReaderRace = myCommandRace.ExecuteReader(CommandBehavior.CloseConnection);
                    DataTable dtRace = new DataTable();
                    dtRace.Load(myReaderRace);
                    DataSet dsRace = new DataSet();
                    dsRace.Tables.Add(dtRace);
                    con.Close();
                    raceid = Convert.ToInt64(dsRace.Tables[0].Rows[0]["id"]);

                    string name = row[4].ToString().Trim().ToUpper();
                    //find by name as the program numnber is scr
                    name = name.Replace("'", "''");
                    string sql_upd = " UPDATE entries SET scratched = 1 WHERE name = '" + name + "' AND raceid = '" + raceid + "'";
                    if (con.State != ConnectionState.Open) { con.Open(); }
                    
                    SqlCommand cmd_proc = new SqlCommand(sql_upd, con);
                    cmd_proc.ExecuteNonQuery();
                    LabelStatus.Text += "<br/>RaceID(" + raceid + ") Horse Scratched: " + name;
                    shared.SaveError("horse scratched", name);
                    if (con.State == ConnectionState.Open) { con.Close(); }
                    rank.CreateRankings(raceid);  //redo rankings
                }
            }
            catch (Exception ex)
            {
                LabelStatus.Text += "<br/>Error: " + ex.ToString();
                if (con.State == ConnectionState.Open) { con.Close(); }
            }


        }
        LabelStatus.Text += "<br/>Records processed: " + dTable.Rows.Count;

    }

    private void ProcessCSV_Exotics(DataTable dTable)
    {

        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);

        //file 4 from the comprehensive package

        DateTime racedate;
        Int64 raceid;
        string track = "";
        int racenum;
        List<Int64> racesprocessed = new List<Int64>();
        

        // For each row, print the values of each column.
        foreach (DataRow row in dTable.Rows)
        {
            try
            {
                    //comprehensive format
                    //columns to write
                    //using  file 4 of the comprehensive
                    //0 Track
                    track = row[0].ToString().Trim();
                    //1 Date
                    //format date
                    racedate = DateTime.ParseExact(row[1].ToString(),
                                            "yyyyMMdd",
                                            CultureInfo.InvariantCulture,
                                            DateTimeStyles.None);
                    //2 Race Num
                    racenum = Convert.ToInt16(row[2]);

                    //4 wager type 
                    string wagertype = row[4].ToString().Trim().ToUpper();
                    if (wagertype == "EXACTA" || wagertype == "TRIFECTA")
                    {
                        //5 bet amount
                        decimal betamount = Convert.ToDecimal(row[5]);
                        //6 payout amount
                        decimal payout = Convert.ToDecimal(row[6]);

                        //ensure bet amount is $1
                        if (betamount > 1) { payout = Math.Round(payout / Convert.ToDecimal(betamount),2); }
                        if(betamount < 1) {  payout = Math.Round(payout * ((decimal)1.0 / Convert.ToDecimal(betamount)), 2); }

                    string sqlRace = "SELECT races.id FROM races INNER JOIN tracks ON races.track = tracks.id WHERE (races.rdate = '" + racedate.ToShortDateString() + "') AND (races.rnum = '" + racenum + "') AND (tracks.abbrev = '" + track.ToUpper().Trim() + "')";
                        //LabelStatus.Text += "<br/>" + sqlRace;
                        SqlCommand myCommandRace = new SqlCommand(sqlRace, con);
                        con.Open();
                        SqlDataReader myReaderRace = myCommandRace.ExecuteReader(CommandBehavior.CloseConnection);
                        DataTable dtRace = new DataTable();
                        dtRace.Load(myReaderRace);
                        DataSet dsRace = new DataSet();
                        dsRace.Tables.Add(dtRace);
                        con.Close();
                        raceid = Convert.ToInt64(dsRace.Tables[0].Rows[0]["id"]);
                        //after done, update race as having exotics processed
                        string sql_upd = " UPDATE races SET exoticsproc = 1 WHERE id = '" + raceid + "'";
                        con.Open();
                        SqlCommand cmd_proc = new SqlCommand(sql_upd, con);
                        cmd_proc.ExecuteNonQuery();
                        con.Close();

                        if(wagertype == "EXACTA")
                        {
                            sql_upd = "UPDATE races SET EXACTA = '" + payout + "' WHERE id = '" + raceid + "'";
                            //SqlParameter retValue = cmd.Parameters.Add("return", SqlDbType.Int);
                            //retValue.Direction = ParameterDirection.ReturnValue;
                            con.Open();
                            SqlCommand cmd = new SqlCommand(sql_upd, con);
                            cmd.ExecuteNonQuery();
                            con.Close();
                            LabelStatus.Text += "<br/>RACE: " + raceid + " EXACTA PAYOUT " + payout;
                        
                        }
                        if (wagertype == "TRIFECTA")
                        {
                            sql_upd = "UPDATE races SET TRIFECTA = '" + payout + "' WHERE id = '" + raceid + "'";
                            //SqlParameter retValue = cmd.Parameters.Add("return", SqlDbType.Int);
                            //retValue.Direction = ParameterDirection.ReturnValue;
                            con.Open();
                            SqlCommand cmd = new SqlCommand(sql_upd, con);
                            cmd.ExecuteNonQuery();
                            con.Close();
                            LabelStatus.Text += "<br/>RACE: " + raceid + " TRIFECTA PAYOUT " + payout;
                        }
                    if (!racesprocessed.Contains(raceid)) { racesprocessed.Add(raceid); }
                }
                    

            }
            catch (Exception ex)
            {
                LabelStatus.Text += "<br/>Error: " + ex.ToString();
                if (con.State == ConnectionState.Open) { con.Close(); }
            }


        }
        foreach(Int64 rid in racesprocessed)
        {
            handicapping.CalculateExoticsData(rid);
        }
        
        LabelStatus.Text += "<br/>Records processed: " + dTable.Rows.Count;
        
    }

    private void LoadInfo(DataTable dTable)
    {

        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);

        //clear any existing data in table
        string sql_del = "TRUNCATE table results_merge";
        SqlCommand cmd_del = new SqlCommand(sql_del, con);
        con.Open();
        cmd_del.ExecuteNonQuery();
        con.Close();

        Int64 raceid;
            string track;
            string rdate;
            int racenum;
        Int64 entryid;
            int postpos;
            bool coupled;
        int finish;
        int moneyfinish;
        decimal finalodds;
        decimal beatenlengths;
        string medication;
        string equipment;
        int weight;
        double finaltime;
        string trackcondition;
        string raceclassname;
        int statebred;
        int racegrade;

        //each record will be from the same track and day -- only load once
        //race number will change, therefore raceid will change
        //need to find entryid each time

        // For each row, print the values of each column.
        foreach (DataRow row in dTable.Rows)
        {
            try
            {

                    //columns to write

                    //0 Track
                track = row[0].ToString().Trim();
                    //1 Date
                rdate = row[1].ToString();
                    //2 Race Num
                racenum = Convert.ToInt16(row[2]);
                    //3 Distance                       
                    //4 Surface
                    //5 Race Type
                    //6 Race Grade
                racegrade = Convert.ToInt16(row[6]);
                    //7 Purse
                    //8 Age/Sex Restr
                    //9 Statebred Flag
                statebred = Convert.ToInt16(row[9]);
                    //10 Final Time
                finaltime = Convert.ToDouble(row[10]);
                    //11 Track Condition
                trackcondition = row[11].ToString();
                    //12 Race Class/Race Name
                raceclassname = row[12].ToString();
                    //*****************************
                    //HORSE INFORMATION

                    //13 Post Poisition
                postpos = Convert.ToInt16(row[13]);
                    //14 Entry/Coupling Flag
                if(!string.IsNullOrEmpty(row[14].ToString()))
                {  coupled = Convert.ToBoolean(row[14]); }
                else { coupled = false; }
                    //15 Name
                    //16 Year of Birth
                    //17 Weight
                weight = Convert.ToInt16(row[17]);
                    //18 Claiming Price
                    //19 Finish Position
                finish = Convert.ToInt16(row[19]);
                    //20 Beaten Lengths
                beatenlengths = Convert.ToDecimal(row[20]);
                    //21 Odds to $1.00
                finalodds = Convert.ToDecimal(row[21]);
                    //22 Medication
                medication = row[22].ToString();
                    //23 Equipment
                equipment = row[23].ToString();
                    //24 Money Position
                moneyfinish = Convert.ToInt16(row[24]);
                   

                //find the entryid - raceid 

                //format date
                DateTime dt = DateTime.ParseExact(rdate,
                                        "yyyyMMdd",
                                        CultureInfo.InvariantCulture,
                                        DateTimeStyles.None);
                //LabelStatus.Text += "<br/>Race Date: " + dt.ToShortDateString() + "<br/>";
                string sqlRace = "SELECT races.id FROM races INNER JOIN tracks ON races.track = tracks.id WHERE (races.rdate = '" + dt.ToShortDateString() + "') AND (races.rnum = '" + racenum + "') AND (tracks.abbrev = '" + track.ToUpper().Trim() + "')";
                //LabelStatus.Text += "<br/>" + sqlRace;
                SqlCommand myCommandRace = new SqlCommand(sqlRace, con);
                con.Open();
                SqlDataReader myReaderRace = myCommandRace.ExecuteReader(CommandBehavior.CloseConnection);
                DataTable dtRace = new DataTable();
                dtRace.Load(myReaderRace);
                DataSet dsRace = new DataSet();
                dsRace.Tables.Add(dtRace);
                con.Close();
                raceid = Convert.ToInt64(dsRace.Tables[0].Rows[0]["id"]);


                string sqlEntry = "SELECT id FROM entries where raceid = " + raceid + " and post = " + postpos + "";
                SqlCommand myCommandEntry = new SqlCommand(sqlEntry, con);
                con.Open();
                SqlDataReader myReaderEntry = myCommandEntry.ExecuteReader(CommandBehavior.CloseConnection);
                DataTable dtEntry = new DataTable();
                dtEntry.Load(myReaderEntry);
                DataSet dsEntry = new DataSet();
                dsEntry.Tables.Add(dtEntry);
                con.Close();
                entryid = Convert.ToInt64(dsEntry.Tables[0].Rows[0]["id"]);


                //insert into temporary table then merge
                //create the database entry for this race                
                SqlCommand cmd = new SqlCommand("SP_AddResult", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@entryid ", entryid));
                cmd.Parameters.Add(new SqlParameter("@raceid", raceid));
                cmd.Parameters.Add(new SqlParameter("@finish", finish));
                cmd.Parameters.Add(new SqlParameter("@moneyposition", moneyfinish));
                cmd.Parameters.Add(new SqlParameter("@finalodds", finalodds));
                cmd.Parameters.Add(new SqlParameter("@beatenlengths", beatenlengths));
                cmd.Parameters.Add(new SqlParameter("@medication", medication));
                cmd.Parameters.Add(new SqlParameter("@weight", weight));
                cmd.Parameters.Add(new SqlParameter("@finaltime", finaltime));
                cmd.Parameters.Add(new SqlParameter("@trackcondition", trackcondition));
                cmd.Parameters.Add(new SqlParameter("@raceclassname", raceclassname));
                cmd.Parameters.Add(new SqlParameter("@statebred", statebred));
                cmd.Parameters.Add(new SqlParameter("@racegrade", racegrade));

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

            }
            catch (Exception ex)
            {
                LabelStatus.Text += "<br/>Error: " + ex.ToString();
                if (con.State == ConnectionState.Open) { con.Close(); }
            }

            
        }
        LabelStatus.Text += "<br/>Records processed: " + dTable.Rows.Count;
        UPStatus.Update();
    }

    protected void ULComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        //System.Diagnostics.Debug.Write("Upload Complete");

        LabelStatus.Text += "UL Completed<br/>";

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
        else
        {
            LabelStatus.Text = "No valid file uploaded.";
        }
    }

    protected void ULComplete_CSV(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        //System.Diagnostics.Debug.Write("Upload Complete");
        
        LabelStatus.Text += "UL Completed<br/>";
        
        AjaxControlToolkit.AsyncFileUpload fileupload = (AjaxControlToolkit.AsyncFileUpload)sender;
        //Upload files
        if (fileupload.HasFile)
        {
            //use newly created id to name file
            string newfilename = "csvfile";
            string savepath = Server.MapPath("~/admin/csv/");
            string extension = Path.GetExtension(fileupload.FileName);
            LabelStatus.Text += "Saving File:<br/>";
            string newfile = shared.SaveFile(fileupload.PostedFile, newfilename, savepath, extension);
            LabelStatus.Text += "Loading CSV to Merge Table:<br/>";
            LoadCSV(newfile);
        }
        else
        {
            LabelStatus.Text = "No valid file uploaded.";
        }
    }

    protected void ULComplete_CSV_Exotics(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        LabelStatus.Text += "UL Completed<br/>";

        AjaxControlToolkit.AsyncFileUpload fileupload = (AjaxControlToolkit.AsyncFileUpload)sender;
        //Upload files
        if (fileupload.HasFile)
        {
            //use newly created id to name file
            string newfilename = "exotics";
            string savepath = Server.MapPath("~/admin/csv/");
            string extension = Path.GetExtension(fileupload.FileName);
            LabelStatus.Text += "Saving File:<br/>";
            string newfile = shared.SaveFile(fileupload.PostedFile, newfilename, savepath, extension);
            LabelStatus.Text += "Loading Exotics Information:<br/>";
            string csvfile = newfile;

            string path = Server.MapPath("~/admin/csv/" + csvfile);
            string full = Path.GetFullPath(path);
            string file = Path.GetFileName(full);
            string dir = Path.GetDirectoryName(full);

            //create the "database" connection string 
            //Microsoft.ACE.OLEDB.12.0
            string connString = "Provider=Microsoft.Jet.OLEDB.4.0;"
              + "Data Source=\"" + dir + "\\\";"
              + "Extended Properties=\"text;HDR=No;FMT=Delimited\"";
            //LabelStatus.Text += "<br/>";
            //LabelStatus.Text+= connString + "<br/>";
            //LabelStatus.Text += "<br/>File Location: " + dir + "\\" + file;
            //LabelStatus.Text += "<br/>Exists: " + System.IO.File.Exists(dir + "\\" + file) + "<br/>" + System.IO.File.ReadAllText(dir + "\\" + file) + "<br/><br/>";
            //create the database query
            string query = "SELECT * FROM " + csvfile;
            //create a DataTable to hold the query results
            DataTable dTable = new DataTable();
            //create an OleDbDataAdapter to execute the query
            OleDbDataAdapter dAdapter = new OleDbDataAdapter(query, connString);
            try
            {
                //fill the DataTable
                dAdapter.Fill(dTable);
            }
            catch (InvalidOperationException /*e*/)
            { }


            dAdapter.Dispose();

            LabelStatus.Text += "Loading Inormation";
            try
            {
                //LoadInfo(dTable);
                ProcessCSV_Exotics(dTable);
            }
            catch (Exception ex) { LabelStatus.Text = "Error Loading csv: " + ex.ToString(); }
        }
        else
        {
            LabelStatus.Text = "No valid file uploaded.";
        }

        
    }



    protected void ButtonForce_Click(object sender, EventArgs e)
    {
    }
    
}