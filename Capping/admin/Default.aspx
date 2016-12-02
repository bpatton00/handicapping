<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="admin_Default" Codebehind="Default.aspx.cs" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="btn btn-group" role="group">
        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="btn btn-default" NavigateUrl="~/admin/edit_tourn.aspx">Edit Tournament</asp:HyperLink>
        <asp:HyperLink ID="HyperLink2" runat="server" CssClass="btn btn-default" NavigateUrl="~/admin/addraces.aspx">Add Races</asp:HyperLink>
        <asp:HyperLink ID="HyperLink6" runat="server" CssClass="btn btn-default" NavigateUrl="~/admin/addresults.aspx">Add Results</asp:HyperLink>
        <asp:HyperLink ID="HyperLink3" runat="server" CssClass="btn btn-default" NavigateUrl="~/admin/scratch.aspx">Scratches</asp:HyperLink>
        <asp:HyperLink ID="HyperLink4" runat="server" CssClass="btn btn-default" NavigateUrl="~/admin/rankings.aspx">Generate Rankings</asp:HyperLink>
        <asp:HyperLink ID="HyperLink5" runat="server" CssClass="btn btn-default" NavigateUrl="~/admin/errors.aspx">Errors</asp:HyperLink>
        <asp:HyperLink ID="HyperLink7" runat="server" CssClass="btn btn-default" NavigateUrl="~/admin/eval_dtld.aspx">Detailed Eval</asp:HyperLink>
    </div>
    

    
    <div id="div_alerts"  >
        <div class="titlebar">Alerts

        </div>

    </div>
</asp:Content>

