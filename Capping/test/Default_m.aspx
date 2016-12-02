<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="test_Default_m" Codebehind="Default_m.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    

    <asp:SqlDataSource ID="SqlDataSourceRDetails" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
                            SelectCommand="SELECT *, races.ropen FROM entries INNER JOIN races ON entries.raceid = races.id WHERE (raceid = @id) ORDER BY CONVERT(int,dbo.ReplaceNonNumericChars(program)),post">
                            <SelectParameters>
                                <asp:Parameter Name="id" DefaultValue="1843" />
                            </SelectParameters>
                        </asp:SqlDataSource>
</asp:Content>

