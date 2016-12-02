using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_edit_tourn : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ButtonClose_Click(object sender, EventArgs e)
    {
        //close selected tournament        
        Button btn = (Button)sender;
        if (btn.CommandName == "Close")
        {
            //SqlDataSourceTourns.UpdateCommand = "UPDATE tournaments set finished = 'True' WHERE id = " + btn.CommandArgument;
            //SqlDataSourceTourns.Update();
            SqlDataSourceTourns.UpdateCommand = "UPDATE races set ropen = 'False' WHERE ID IN (SELECT raceid FROM racesintourn WHERE tournid = " + btn.CommandArgument + ")";
            SqlDataSourceTourns.Update();
            GVOpenTourns.DataBind();
        }
    }
}