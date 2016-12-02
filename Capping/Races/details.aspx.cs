using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Races_details : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected string GetPickCSS(int ccrank)
    {
        string css = "";
        if (ccrank == 1) { css = " pick firstpick "; }
        if (ccrank == 2) { css = " pick secondpick "; }
        if (ccrank == 3) { css = " pick thirdpick "; }
        return css;
    }

    protected void HorsesDataBound(object sender, GridViewRowEventArgs e)
    {        
        //set column style
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
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
}