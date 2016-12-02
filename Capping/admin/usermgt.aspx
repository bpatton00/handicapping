<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="admin_usermgt" Codebehind="usermgt.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderLeft" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
         Find Email <asp:TextBox ID="TBEmail_Search" runat="server" />
    <asp:Button ID="ButtonFindEmail" runat="server" Text="Search" UseSubmitBehavior="true" />
   <asp:SqlDataSource ID="SqlDataSourceOwnerIDEmail" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT loweredemail FROM aspnet_Membership WHERE (aspnet_Membership.loweredemail LIKE '%' + @email + '%')">
        <SelectParameters>
            <asp:ControlParameter Name="email" ControlID="TBEmail_Search" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridViewOwnerIDEmail" runat="server" DataSourceID="SqlDataSourceOwnerIDEmail" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="loweredemail" />
        </Columns>
    </asp:GridView>

    Email Address <asp:TextBox ID="TBEmail" runat="server"></asp:TextBox> 
    <asp:Button ID="ButtonCheck" runat="server" Text="Find" UseSubmitBehavior="true"/>
    
    <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="125px" 
        AutoGenerateRows="False" 
        DataKeyNames="ApplicationId,LoweredUserName" 
        DataSourceID="SqlDataSourceOwnerDetails">
        <Fields>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HiddenField ID="HFUserName" Value='<%# Eval("UserName") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:BoundField DataField="ApplicationId" HeaderText="ApplicationId" ReadOnly="True" SortExpression="ApplicationId" />            
            <asp:BoundField DataField="username" HeaderText="UserName" SortExpression="username" />
            <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password" />
            <asp:BoundField DataField="PasswordFormat" HeaderText="PasswordFormat" 
                SortExpression="PasswordFormat" />
            <asp:BoundField DataField="PasswordSalt" HeaderText="PasswordSalt" 
                SortExpression="PasswordSalt" />
            <asp:BoundField DataField="MobilePIN" HeaderText="MobilePIN" 
                SortExpression="MobilePIN" />
            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            <asp:BoundField DataField="LoweredEmail" HeaderText="LoweredEmail" 
                SortExpression="LoweredEmail" />
            <asp:BoundField DataField="PasswordQuestion" HeaderText="PasswordQuestion" 
                SortExpression="PasswordQuestion" />
            <asp:BoundField DataField="PasswordAnswer" HeaderText="PasswordAnswer" 
                SortExpression="PasswordAnswer" />
            <asp:CheckBoxField DataField="IsApproved" HeaderText="IsApproved" 
                SortExpression="IsApproved" />
            <asp:CheckBoxField DataField="IsLockedOut" HeaderText="IsLockedOut" 
                SortExpression="IsLockedOut" />
            <asp:BoundField DataField="CreateDate" HeaderText="CreateDate" 
                SortExpression="CreateDate" />
            <asp:BoundField DataField="LastLoginDate" HeaderText="LastLoginDate" 
                SortExpression="LastLoginDate" />
            <asp:BoundField DataField="LastPasswordChangedDate" 
                HeaderText="LastPasswordChangedDate" SortExpression="LastPasswordChangedDate" />
            <asp:BoundField DataField="LastLockoutDate" HeaderText="LastLockoutDate" 
                SortExpression="LastLockoutDate" />
            <asp:BoundField DataField="FailedPasswordAttemptCount" 
                HeaderText="FailedPasswordAttemptCount" 
                SortExpression="FailedPasswordAttemptCount" />
            <asp:BoundField DataField="FailedPasswordAttemptWindowStart" 
                HeaderText="FailedPasswordAttemptWindowStart" 
                SortExpression="FailedPasswordAttemptWindowStart" />
            <asp:BoundField DataField="FailedPasswordAnswerAttemptCount" 
                HeaderText="FailedPasswordAnswerAttemptCount" 
                SortExpression="FailedPasswordAnswerAttemptCount" />
            <asp:BoundField DataField="FailedPasswordAnswerAttemptWindowStart" 
                HeaderText="FailedPasswordAnswerAttemptWindowStart" 
                SortExpression="FailedPasswordAnswerAttemptWindowStart" />
            <asp:BoundField DataField="Comment" HeaderText="Comment" 
                SortExpression="Comment" />
        </Fields>
    </asp:DetailsView>
    <asp:SqlDataSource ID="SqlDataSourceOwnerDetails" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT aspnet_Membership.*, aspnet_Users.UserName, aspnet_Users.LoweredUserName FROM aspnet_Membership INNER JOIN aspnet_Users ON aspnet_Membership.UserId = aspnet_Users.UserId WHERE LoweredEmail = @email">
        <SelectParameters>
            <asp:ControlParameter Name="email" ControlID="TBEmail" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Button ID="ButtonReset" runat="server" Text="Reset PW for Selected Account" OnClick="ButtonReset_Click" />
    <asp:Label ID="LabelResponse" runat="server" />
</asp:Content>

