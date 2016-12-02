using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Web.UI.HtmlControls;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.IsAuthenticated)
        {
            Session["userid"] = Membership.GetUser().ProviderUserKey.ToString();
            if (Session["userid"].ToString() == "271195a8-154f-4051-98bf-410f5a680da0")
            {
                HtmlGenericControl b = new HtmlGenericControl("li");
                b.InnerHtml = "<a style=\"background-image: linear-gradient(#2ecc71 0px, rgba(229, 229, 229, 0) 8%, rgba(46, 204, 113, 0.47) 52%, #2ecc71 100%);\" href='/Admin'>Admin</a>";
                CPH_Admin.Controls.Add(b);                
            }
        }
    }
}
