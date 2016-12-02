using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class admin_rankings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ButtonRunRankings_Click(object sender, EventArgs e)
    {
        //run the rankings for the selected id
        rank.CreateRankings(Convert.ToInt64(DDLRaces.SelectedValue));
        LabelResponse.Text = "Rankings Generated";

        GVRankings.DataBind();
    }

    protected void ButtonRunALLRankings_CLick(object sender, EventArgs e)
    {
        //get a list of all races - run the rankings function for each one
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["WageringConn"].ConnectionString);
        string sql = "SELECT id FROM races";
        SqlCommand myCommand = new SqlCommand(sql, con);
        con.Open();

        SqlDataReader myReader = myCommand.ExecuteReader(CommandBehavior.CloseConnection);
        DataTable dt = new DataTable();
        dt.Load(myReader);
        DataSet ds = new DataSet();
        ds.Tables.Add(dt);
        con.Close();
        int processed = 0;
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            if (Convert.ToInt64(dr["id"]) >= Convert.ToInt32(TBSTart.Text) && Convert.ToInt64(dr["id"]) < Convert.ToInt32(TBEnd.Text))
            {
                try
                {
                    rank.CreateRankings(Convert.ToInt64(dr["id"]));
                    processed++;
                }
                catch { }
            }

        }
        LabelResponse.Text = processed + " races processed";
    }
}