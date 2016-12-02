using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;


public partial class admin_usermgt : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ButtonReset_Click(object sender, EventArgs e)
    {
        try
        {
            HiddenField hf = (HiddenField)DetailsView1.FindControl("HFUserName");

            MembershipUser currUser = Membership.Providers["MySqlMembershipProviderReset"].GetUser(hf.Value.ToString(), false);
            currUser.ChangePassword(currUser.ResetPassword(), "CC_password1");
            currUser.Comment = "CHANGEPASS";
            if (currUser.IsLockedOut == true)
            {
                currUser.UnlockUser();
            }
            //LiteralConfirm.Text = "Password is: " + u.GetPassword();
            LabelResponse.Text = "Password Reset to 'CC_password1'.";
            messaging.SendEmail(currUser.Email.ToString(), "Password Reset", "Password has been reset, new password is CC_password1");
        }
        catch (Exception ex)
        {
            LabelResponse.Text = "Error: " + ex.ToString();
        }
    }
}