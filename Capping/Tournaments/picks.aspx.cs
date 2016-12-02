using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Text.RegularExpressions;

public partial class Tournaments_picks : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //if no entries, redirect to registration
            if (user_functions.Tourn_NumEntries(Membership.GetUser().ProviderUserKey.ToString(), Convert.ToInt64(Request.QueryString["id"])) > 0)
            {
                div_reg.Visible = false;
                div_picks.Visible = true;
            }

            //set page title based on tournament name
            Page.Title = user_functions.GetTournamentName(Convert.ToInt64(Request.QueryString["id"]));
        }

    }

   
    protected string FormatParTime(string s_time)
    {
        string s_formattedtime = "";
        if (s_time.Length > 5)
        {
            //insert : after the first digit
            s_formattedtime = s_time.Insert(1, ":");
        }
        else { return s_time; }
        return s_formattedtime;
    }

    protected void HorsesDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            GridView gv = (GridView)sender;
            //RadioButton btn = (RadioButton)e.Row.FindControl("RadioButtonSelect");
            Button btn = (Button)e.Row.FindControl("ButtonSelect");
            if (Convert.ToBoolean( DataBinder.Eval(e.Row.DataItem, "scratched").ToString())) { btn.Enabled = false; btn.Visible = false; }
            
        }
        catch { }
        //set column style
        try
        {
            if(e.Row.RowType == DataControlRowType.DataRow)
            {
                int ccrank = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "ccrank"));
                if (ccrank == 1) { e.Row.Cells[0].CssClass = "text-center pick firstpick"; }
                if (ccrank == 2) { e.Row.Cells[0].CssClass = "text-center pick secondpick"; }
                if (ccrank == 3) { e.Row.Cells[0].CssClass = "text-center pick thirdpick"; }
            }
        }
        catch { }
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                bool scratched = Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "scratched"));
                if (scratched) { e.Row.CssClass = " scratched"; }
            }
        }
        catch { }
    }

    protected string isSelected(int currentprogram, Int64 raceid)
    {
        Int64 tournid = Convert.ToInt64(Request.QueryString["id"]);
        string userId = Membership.GetUser().ProviderUserKey.ToString();
        DropDownList ddl = (DropDownList)FVTourn.FindControl("DDLEntries"); Int64 tourn_entry = Convert.ToInt64(ddl.SelectedValue);
        int program = user_functions.ProgramSelected(userId, tournid, raceid, tourn_entry);
        if (program == currentprogram)
        {
            return " horseselected";
        }
        else { return ""; }
    }

    protected string GetPickCSS(int ccrank)
    {
        string css = "";
        if (ccrank == 1) { css = " pick firstpick "; }
        if (ccrank == 2) { css = " pick secondpick "; }
        if (ccrank == 3) { css = " pick thirdpick "; }
        return css;
    }

    protected void HorsesLoaded(object sender, EventArgs e)
    {
        GridView gv = (GridView)sender;
        try
        {
            //check to see if the user has a pick for this race, if so select the row
            Int64 tournid = Convert.ToInt64(Request.QueryString["id"]);
            string userId = Membership.GetUser().ProviderUserKey.ToString();

            if (gv.Rows.Count > 0)
            {
                HiddenField hfraceid = (HiddenField)gv.Rows[0].FindControl("HFRaceid"); Int64 raceid = Convert.ToInt64(hfraceid.Value);
                DropDownList ddl = (DropDownList)FVTourn.FindControl("DDLEntries"); Int64 tourn_entry = Convert.ToInt64(ddl.SelectedValue);

                int program = user_functions.ProgramSelected(userId, tournid, raceid, tourn_entry);
                //LabelResponse.Text += "<br/>Race " + raceid + " Post " + post + "<br/>";
                bool rowFound = false;
                foreach (GridViewRow gvrRow in gv.Rows)
                {
                    Int32 rowID = Convert.ToInt32(gv.DataKeys[gvrRow.RowIndex].Values[0].ToString());
                    if (rowID.Equals(program))
                    {
                        rowFound = true;
                        gv.SelectedIndex = gvrRow.RowIndex;
                        //LabelResponse.Text += "<br/>Row Found<br/>";
                    }
                    if (rowFound)
                    { break; }
                }
            }
        }
        catch (Exception ex) 
        {
            LabelResponse.Text += ex.ToString();
        }

    }
    protected void EntriesBound(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)FVTourn.FindControl("DDLEntries");
        for(int z = 0; z < ddl.Items.Count; z++)
        {
            ddl.Items[z].Text = "Entry #" + (z + 1);
        }        
    }

    [WebMethod]    
    public static string WM_isSelected(int currentprogram, string raceid, string tournid, string tentry)
    {
        string userId = Membership.GetUser().ProviderUserKey.ToString();
        Int64 tourn_entry = Convert.ToInt64(tentry);
        int program = user_functions.ProgramSelected(userId, Convert.ToInt64(tournid), Convert.ToInt64(raceid), tourn_entry);
        if (program == currentprogram)
        {
            return " horseselected";
        }
        else { return ""; }
    }

    [WebMethod]
    public static string SaveSelection(string eid, string tentry)
    {
        try { 
        Int64 entryid = Convert.ToInt64(eid);
        Int64 tournid = Convert.ToInt64(HttpContext.Current.Request.QueryString["id"]);
        string userId = Membership.GetUser().ProviderUserKey.ToString();        
        string sql = " SELECT raceid, program FROM entries WHERE id = '" + entryid + "'";
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        //race id #
        Int64 raceid = Convert.ToInt64(ds.Tables[0].Rows[0]["raceid"]);
        int program = Convert.ToInt32(Regex.Replace((ds.Tables[0].Rows[0]["program"]).ToString(), @"[a-zA-Z\s]+", string.Empty));

        //tourn_entry id #
        //DropDownList ddl = (DropDownList)FVTourn.FindControl("DDLEntries"); Int64 tourn_entry = Convert.ToInt64(ddl.SelectedValue);
        Int64 tourn_entry = Convert.ToInt64(tentry);
        string response = "Race Closed";
        if (races.IsOpen(raceid))
        {             
            response = user_functions.SaveSelection(userId, tournid, raceid, tourn_entry, program, entryid);
        }
        return response;
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
    }

    protected void HorseSelected(object sender, GridViewCommandEventArgs e)
    {
        //while saving - display message

        GridView gv = (GridView)sender;
        // Retrieve the row index stored in the CommandArgument property.
        int index = Convert.ToInt32(e.CommandArgument);

        // Retrieve the row that contains the button from the Rows collection.
        GridViewRow row = gv.Rows[index];

        gv.SelectedIndex = index;
        Int64 tournid = Convert.ToInt64(Request.QueryString["id"]);
        string userId = Membership.GetUser().ProviderUserKey.ToString();
        HiddenField hfraceid = (HiddenField)row.FindControl("HFRaceid"); Int64 raceid = Convert.ToInt64(hfraceid.Value);
        DropDownList ddl = (DropDownList)FVTourn.FindControl("DDLEntries"); Int64 tourn_entry = Convert.ToInt64(ddl.SelectedValue);
        HiddenField hfprogram = (HiddenField)row.FindControl("HFProgram"); int program = Convert.ToInt32(hfprogram.Value);
        HiddenField hfentryid = (HiddenField)row.FindControl("HFEntryID"); Int64 entryid = Convert.ToInt64(hfentryid.Value);
        //save pick        
        //use tourn_entry.id to save - allows users to have multiple entries
        //LabelResponse.Text = "Race " + raceid + " -- Program " + program;
        Label lblp = (Label)row.FindControl("LabelPickSaved");
        LabelResponse.Text += user_functions.SaveSelection(userId, tournid, raceid, tourn_entry, program, entryid);
        
        //LabelResponse.Text = "Entry #" + tourn_entry;

    }

    protected void ButtonReg_Click(object sender, EventArgs e)
    {
        //enter user in the tournament
        bool regstatus = user_functions.EnterTourn(Membership.GetUser().ProviderUserKey.ToString(), Convert.ToInt64(Request.QueryString["id"]));

        if (regstatus)
        {
            div_picks.Visible = true;
            div_reg.Visible = false;
        }
        else
        {
            LabelRegStatus.Text = "You were not able to register at this time.";
        }
    }
}