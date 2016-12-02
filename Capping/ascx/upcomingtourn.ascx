<%@ Control Language="C#" AutoEventWireup="true" Inherits="ascx_upcomingtourn" Codebehind="upcomingtourn.ascx.cs" %>
<asp:SqlDataSource ID="SqlDataSourceTourns" runat="server" 
    ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
    SelectCommand="SELECT TOP(5)* FROM [tournaments] WHERE ([tdate] >= DateAdd(hour,-5,getdate())) AND (nument < maxplayers)  AND (isopen = 'True') ORDER BY [tdate]">
</asp:SqlDataSource>

<asp:Repeater ID="RepeaterTournaments" runat="server" DataSourceID="SqlDataSourceTourns">
    <HeaderTemplate>
        <ul class="list-unstyled">            
    </HeaderTemplate>
    <ItemTemplate>
        <li>
        <!--<a class="list-group-item" href='<%# "/tournaments/details.aspx?id=" + Eval("id") %>' > <%# Eval("name") %> <span class="badge"><%# Eval("nument") + "/" + Eval("maxplayers") %></span></a>-->
            <a class="" href='<%# "/tournaments/details.aspx?id=" + Eval("id") %>' > <%# Eval("name") %> <span class="badge pull-right"><%# Eval("nument") + "/" + Eval("maxplayers") %></span></a>
        </li>
    </ItemTemplate>
    <FooterTemplate>
        </ul>
    </FooterTemplate>
</asp:Repeater>
