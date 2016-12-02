using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
public partial class Tournaments_details : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ButtonReg.DataBind();
        ButtonPicks.DataBind();
    }
    protected void ButtonPicks_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/tournaments/picks.aspx?id=" + Request.QueryString["id"]);
    }
    protected void ButtonReg_Click(object sender, EventArgs e)
    {
        //enter user in the tournament
        bool regstatus = user_functions.EnterTourn(Membership.GetUser().ProviderUserKey.ToString(), Convert.ToInt64(Request.QueryString["id"]));

        if (regstatus)
        {
            Response.Redirect("~/tournaments/picks.aspx?id=" + Request.QueryString["id"]);
        }
        else
        {
            try
            {
                LabelRegStatus.Text = "You were not able to register at this time.";
            }
            catch { }
        }
    }
}