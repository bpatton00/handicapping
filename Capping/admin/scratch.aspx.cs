using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


public partial class admin_scratch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void AddRemove_CheckedChanged(object sender, EventArgs e)
    {

        CheckBox AddRemove = (CheckBox)sender;
        var item = (GridViewRow)AddRemove.NamingContainer;
        HiddenField hf = (HiddenField)item.FindControl("HFID");

        //insert/update 
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        SqlCommand cmd = new SqlCommand("SP_Scratch", con);


        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@entryid", hf.Value));
        cmd.Parameters.Add(new SqlParameter("@checked", AddRemove.Checked));

        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        //GVHorses.DataBind();

        //get raceid from entryid
        string sql = "SELECT raceid FROM entries WHERE id = '" + hf.Value + "'";
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        con.Close();
        //after scratching then rerun the rankings
        rank.CreateRankings(Convert.ToInt64(ds.Tables[0].Rows[0]["raceid"]));

    }
}