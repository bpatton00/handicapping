using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Capping.ascx
{
    public partial class cc_score : System.Web.UI.UserControl
    {
        public Int64 raceid { get; set; }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            SqlDataSourceRDetails.SelectParameters["raceid"].DefaultValue = raceid.ToString();
            GVDetails.DataBind();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
    }
}