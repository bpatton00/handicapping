<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="Account_recover_password" Codebehind="recover_password.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderLeft" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:TextBox id="UsernameTextBox" runat="server"></asp:TextBox>
    <asp:Label id="QuestionLabel" runat="server"></asp:Label>
    <asp:Label id="AnswerTextBox" runat="server"></asp:Label>
  Please supply the registered email address.
    <asp:Label id="Msg" runat="server" ForeColor="maroon" /><br />
  <asp:TextBox ID="TBEmail" runat="server" placeholder="Email address" />
        <asp:Button id="ResetPasswordButton" Text="Send Password Reset Email" OnClick="ResetPassword_OnClick" runat="server" Enabled="false" />
        <br /><br /><br />
        <asp:Label ID="LabelResponse" runat="server" ></asp:Label>

        
</asp:Content>

