using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class Account_recover_password : System.Web.UI.Page
{
    MembershipUser u;

    public void Page_Load(object sender, EventArgs args)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["ID"]))
        {
            if (!Membership.EnablePasswordReset)
            {
                FormsAuthentication.RedirectToLoginPage();
            }

            Msg.Text = "";

            if (!IsPostBack)
            {
                Msg.Text = "Please supply a username.";
            }
            else
            {
                VerifyUsername();
            }
        }
    }


    public void VerifyUsername()
    {
        u = Membership.GetUser(UsernameTextBox.Text, false);

        if (u == null)
        {
            Msg.Text = "Username " + Server.HtmlEncode(UsernameTextBox.Text) + " not found. Please check the value and re-enter.";

            QuestionLabel.Text = "";
            QuestionLabel.Enabled = false;
            AnswerTextBox.Enabled = false;
            ResetPasswordButton.Enabled = false;
        }
        else
        {
            QuestionLabel.Text = u.PasswordQuestion;
            QuestionLabel.Enabled = true;
            AnswerTextBox.Enabled = true;
            ResetPasswordButton.Enabled = true;
        }
    }

    public void ResetPassword_OnClick(object sender, EventArgs args)
    {

        //resend verification email        

        //get membership information by email address
        string username = Membership.GetUserNameByEmail(TBEmail.Text);
        try
        {
            MembershipUser mu = Membership.GetUser(username);
            
                string verifyurl = "https://www.cappingclub.us/account/recover_password.aspx?ID=" + mu.ProviderUserKey.ToString();
                string emailbody = "Hello " + mu.UserName + ", \r\n\r\nYou are receiving this email because you recently requested to reset your password at cappingclub.com. Before you can login, however, you need to first visit the following link:\r\n\r\n " + verifyurl + "\r\n\r\n.";
                //messaging.SendTemplateEmail(userInfo.Email.ToString(), userInfo.UserName +  " account verification", emailbody, userInfo.UserName.ToString());
                messaging.SendEmail(mu.Email.ToString(), mu.UserName + ", Capping Club: Password Reset", emailbody);
                LabelResponse.Text = "Recovery email has been dispatched.";           
        }
        catch { LabelResponse.Text = "There is no account associated with the entered email address."; }
    }

}
