<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="admin_addraces" Codebehind="addraces.aspx.cs" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    Select an XML file - once it has uploaded it will automatically process the file and create a tournament.
    <br /><br />
    <b>TrackMaster</b>
    <asp:AsyncFileUpload ID="AsyncFileUpload1" runat="server"  OnUploadedComplete="ULComplete" />


</asp:Content>

