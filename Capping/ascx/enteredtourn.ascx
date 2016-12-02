<%@ Control Language="C#" AutoEventWireup="true" Inherits="ascx_enteredtourn" Codebehind="enteredtourn.ascx.cs" %>
<asp:Repeater ID="RepeaterEntered" runat="server" DataSourceID="SqlDataSourceEntered">
    <HeaderTemplate>
    </HeaderTemplate>
    <ItemTemplate>
        <li>
        <!--<a class="list-group-item" href='<%# "/tournaments/picks.aspx?id=" + Eval("id") %>' title='<%# Eval("tdate","{0:d}") %>' ><%# Eval("name") %></a>-->
            <a class="" href='<%# "/tournaments/picks.aspx?id=" + Eval("id") %>' data-toggle="tooltip" data-direction="right" title='<%# Eval("tdate","{0:d}") %>' ><%# Eval("name") %></a>
        </li>
    </ItemTemplate>
    <FooterTemplate>
    </FooterTemplate>
</asp:Repeater>
    <asp:SqlDataSource ID="SqlDataSourceEntered" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT aspnet_Users.UserId, tournaments.name, tournaments.prize, tournaments.tdate, tournaments.nument, tournaments.maxplayers, tournaments.id FROM tourn_entry INNER JOIN aspnet_Users ON tourn_entry.userid = aspnet_Users.UserId INNER JOIN tournaments ON tourn_entry.tournid = tournaments.id WHERE aspnet_Users.userid = @userid AND tournaments.finished = 'False' AND tdate > DATEADD(day,-7,GETDATE()) ORDER BY tdate DESC">
            <SelectParameters>
                <asp:SessionParameter Name="userid" SessionField="userid" />
            </SelectParameters>
        </asp:SqlDataSource>