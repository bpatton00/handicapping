<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="finalstandings.ascx.cs" Inherits="Capping.ascx.finalstandings" %>
<div class="panel panel-primary">
    <div class="panel-heading panel-title">Final Standings</div>
    <div class="">
        <asp:GridView ID="GVTournamentResults" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="table table-hover" PagerStyle-CssClass="pgr" DataSourceID="SqlDataSourceTournResults">
            <Columns>
                <asp:BoundField DataField="UserName" HeaderText="Name" SortExpression="UserName" />
                <asp:BoundField DataField="wager_earnings" HeaderText="Winnings" SortExpression="wager_earnings" DataFormatString="{0:c2}" />
            </Columns>

        </asp:GridView>

    </div>
</div>
<asp:SqlDataSource ID="SqlDataSourceTournResults" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
    SelectCommand="SELECT UserName, [wager_earnings] FROM [tourn_entry] INNER JOIN aspnet_Users ON tourn_entry.userid = aspnet_Users.UserId  WHERE ([tournid] = @tournid) ORDER BY [wager_earnings] DESC">
    <SelectParameters>
        <asp:QueryStringParameter Name="tournid" QueryStringField="id" Type="Int64" />
    </SelectParameters>

</asp:SqlDataSource>
