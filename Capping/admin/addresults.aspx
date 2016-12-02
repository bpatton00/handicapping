<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="admin_addresults" Codebehind="addresults.aspx.cs" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderLeft" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
     Select a file - once it has uploaded it will automatically process the file.
    <br /><br />
    <b>Trackmaster XML</b>
    <asp:AsyncFileUpload ID="AsyncFileUpload1" runat="server"  OnUploadedComplete="ULComplete" />
    <br /><br />
    <b>Brisnet CSV</b>
    <asp:AsyncFileUpload ID="AsyncFileUpload2" runat="server"  OnUploadedComplete="ULComplete_CSV" />        
    <br /><br />
    <b>Brisnet Exotics CSV</b>
    <asp:AsyncFileUpload ID="AsyncFileUpload3" runat="server"  OnUploadedComplete="ULComplete_CSV_Exotics" />        
                
            <asp:Button ID="ButtonForce" runat="server" Text="Import CSV" OnClick="ButtonForce_Click"  />
    <asp:UpdatePanel ID="UPStatus" runat="server">
        <ContentTemplate>
            <asp:Label ID="LabelStatus" runat="server" ></asp:Label>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br /><br />
</asp:Content>

