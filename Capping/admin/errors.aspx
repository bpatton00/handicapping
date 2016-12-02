<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="admin_errors" Codebehind="errors.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderLeft" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">

    <asp:GridView runat="server" ID="GVErrors" DataSourceID="SqlDataSourceErrors" CssClass="custtable"></asp:GridView>
    
    <asp:SqlDataSource ID="SqlDataSourceErrors" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" SelectCommand="SELECT * FROM [errors] order by id desc">        
    </asp:SqlDataSource>
</asp:Content>

