<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="eval_dtld.aspx.cs" Inherits="Capping.admin.eval_dtld" %>

<%@ Register Src="~/ascx/eval_filters.ascx" TagPrefix="uc1" TagName="eval_filters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Admin" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderLeft" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <uc1:eval_filters runat="server" id="eval_filters" />
</asp:Content>
