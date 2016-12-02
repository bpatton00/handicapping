<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="admin_Analyze" Codebehind="Analyze.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderLeft" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
        
    <asp:Repeater ID="RepeaterStats" runat="server">
        <HeaderTemplate>
            <table class="responstable">
                <tr>
                    <th>Date</th>
                    <th>Win Rate</th>
                    <th>Win</th>
                    <th>Place</th>
                    <th>Show</th>
                </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td><%# Eval("date") %></td>
                <td><asp:Label ID="LabelPct" runat="server" Text='<%# Convert.ToInt16(Eval("winners")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("races"))).ToString("p2") : ""  %>'  /></td>
                <td><asp:Label ID="LabelAvgWReturn" runat="server" Visible='<%# Convert.ToDouble(Eval("avgwinreturn")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("avgwinreturn")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("avgwinreturn"))) %>' /></td>
                <td><asp:Label ID="LabelAvgPReturn" runat="server" Visible='<%# Convert.ToDouble(Eval("avgplacereturn")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("avgplacereturn")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("avgplacereturn"))) %>' /></td>
                <td><asp:Label ID="LabelAvgSReturn" runat="server" Visible='<%# Convert.ToDouble(Eval("avgshowreturn")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("avgshowreturn")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("avgshowreturn"))) %>' /></td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>
        
   
    <br /><br />
    <asp:DropDownList ID="DDLTrack" runat="server" DataSourceID="SqlDataSourceTracks"  AutoPostBack="true" 
        DataTextField="abbrev" DataValueField="track">
    </asp:DropDownList>


    <asp:SqlDataSource ID="SqlDataSourceTracks" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT DISTINCT(track), abbrev FROM [races] INNER JOIN tracks on tracks.id = races.track INNER JOIN entry_results ON races.id = entry_results.raceid ORDER BY abbrev">        
    </asp:SqlDataSource>

    <asp:GridView ID="GridViewReturns" CssClass="responstable" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceReturns">
        <Columns>
            <asp:BoundField DataField="ccrank" HeaderText="ccrank" SortExpression="ccrank" />
            <asp:TemplateField HeaderText="Win Rates">
                <ItemTemplate>
                    <asp:Label ID="LabelPct" runat="server" Text='<%# Convert.ToInt16(Eval("winners")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("races"))).ToString("p2") : ""  %>'  />
                    <asp:Label ID="LabelWinners" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("winners") + "/" + Eval("races") + "]</i>"%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ITM">
                <ItemTemplate>
                    <asp:Label ID="LabelPct" runat="server" Text='<%# Convert.ToInt16(Eval("itm")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("races"))).ToString("p2") : ""  %>'  />
                    <asp:Label ID="LabelWinners" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("itm") + "/" + Eval("races") + "]</i>"%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="winners" HeaderText="winners" ReadOnly="True" SortExpression="winners" Visible="false" />
            <asp:BoundField DataField="itm" HeaderText="itm" ReadOnly="True" SortExpression="itm" Visible="false" />
            <asp:BoundField DataField="races" HeaderText="races" ReadOnly="True" SortExpression="races" Visible="false" />
            <asp:BoundField DataField="avgwinpayoff" HeaderText="avgwinpayoff" DataFormatString="{0:C2}" ReadOnly="True" SortExpression="avgwinpayoff" Visible="false" />
            <asp:BoundField DataField="avgplacepayoff" HeaderText="avgplacepayoff" DataFormatString="{0:C2}" ReadOnly="True" SortExpression="avgplacepayoff" Visible="false" />
            <asp:BoundField DataField="avgshowpayoff" HeaderText="avgshowpayoff" DataFormatString="{0:C2}" ReadOnly="True" SortExpression="avgshowpayoff" Visible="false" />
            <asp:TemplateField HeaderText="Win">
                <ItemTemplate>
                    <asp:Label ID="LabelAvgReturn" runat="server" Visible='<%# Convert.ToDouble(Eval("avgwinreturn")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("avgwinreturn")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("avgwinreturn"))) %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Place">
                <ItemTemplate>
                    <asp:Label ID="LabelAvgReturn" runat="server" Visible='<%# Convert.ToDouble(Eval("avgplacereturn")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("avgplacereturn")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("avgplacereturn"))) %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Show">
                <ItemTemplate>
                    <asp:Label ID="LabelAvgReturn" runat="server" Visible='<%# Convert.ToDouble(Eval("avgshowreturn")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("avgshowreturn")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("avgshowreturn"))) %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceReturns" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT entries.ccrank, (SELECT COUNT(*) AS predicted FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid INNER JOIN races as r ON entries_1.raceid = r.id WHERE (entries_1.ccrank = entries.ccrank) AND (entry_results_2.officialfinish = 1) AND r.track = @track) AS winners, (SELECT COUNT(*) AS predicted FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid INNER JOIN races as r ON entries_1.raceid = r.id WHERE (entries_1.ccrank = entries.ccrank) AND (entry_results_2.officialfinish < 4) AND r.track = @track) AS itm, (SELECT COUNT(*) AS predicted FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid INNER JOIN races as r ON entries_1.raceid = r.id WHERE (entries_1.ccrank = entries.ccrank) AND r.track = @track) AS races, (SELECT AVG(entry_results_2.winpayoff) AS t FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid INNER JOIN races as r ON entries_1.raceid = r.id WHERE (entries_1.ccrank = entries.ccrank) AND (entry_results_2.officialfinish = 1) AND r.track = @track GROUP BY entry_results_2.officialfinish) AS avgwinpayoff, (SELECT AVG(entry_results_2.placepayoff) AS t FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid INNER JOIN races as r ON entries_1.raceid = r.id WHERE (entries_1.ccrank = entries.ccrank) AND (entry_results_2.officialfinish = 2) AND r.track = @track GROUP BY entry_results_2.officialfinish) AS avgplacepayoff, (SELECT AVG(entry_results_2.showpayoff) AS t FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid INNER JOIN races as r ON entries_1.raceid = r.id WHERE (entries_1.ccrank = entries.ccrank) AND (entry_results_2.officialfinish = 3) AND r.track = @track GROUP BY entry_results_2.officialfinish) AS avgshowpayoff, (SELECT AVG(entry_results_2.winpayoff) AS t FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid INNER JOIN races as r ON entries_1.raceid = r.id WHERE (entries_1.ccrank = entries.ccrank) AND r.track = @track) AS avgwinreturn, (SELECT AVG(entry_results_2.placepayoff) AS t FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid INNER JOIN races as r ON entries_1.raceid = r.id WHERE (entries_1.ccrank = entries.ccrank) AND r.track = @track) AS avgplacereturn, (SELECT AVG(entry_results_2.showpayoff) AS t FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid INNER JOIN races as r ON entries_1.raceid = r.id WHERE (entries_1.ccrank = entries.ccrank) AND r.track = @track) AS avgshowreturn FROM entries INNER JOIN entry_results AS entry_results_1 ON entries.id = entry_results_1.entryid INNER JOIN races ON entries.raceid = races.id AND entry_results_1.raceid = races.id WHERE track = @track GROUP BY entries.ccrank">
        <SelectParameters>
            <asp:ControlParameter Name="track" ControlID="DDLTrack" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

