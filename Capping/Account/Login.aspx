<%@ Page Title="Log In" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="Account_Login" Codebehind="Login.aspx.cs" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    
    
    
    <asp:Login ID="LoginUser" runat="server" EnableViewState="false" CssClass="col-xs-12 col-sm-6 col-sm-offset-2 col-md-4 col-md-offset-4 ">
        <LayoutTemplate>
            <span class="failureNotification">
                <asp:Literal ID="FailureText" runat="server"></asp:Literal>
            </span>
            <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" CssClass="failureNotification" 
                 ValidationGroup="LoginUserValidationGroup"/>
            <div class="wrapper-form-box" style="margin-bottom:40px;">                
                <h3 class="title-sm">Login</h3>                
                <div class="panel-body">
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-user"></i></span>
                            <asp:TextBox ID="UserName" runat="server" CssClass="form-control m-b-10" placeholder="User Name" autofocus></asp:TextBox>
                        </div>
                    </div>
                
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                            <asp:TextBox ID="Password" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password"></asp:TextBox>
                        </div>
                    </div>
                
                    <p class="loginbox-help" style="text-align:left;float:right;"><asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Account/recover_password.aspx">Forgot password?</asp:HyperLink>
                    <br /><asp:HyperLink ID="RegisterHyperLink" runat="server" EnableViewState="false" NavigateUrl="Register.aspx?">Create new account</asp:HyperLink></p>
                    <br /><br /><br />
                    <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In" ValidationGroup="LoginUserValidationGroup" class="btn btn-primary text-theme-xs mr-8"/> 
                    
                </div>
                
                <br />
            </div>
        </LayoutTemplate>
    </asp:Login>    
</asp:Content>