<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="cceval.aspx.cs" Inherits="Capping.tools.cceval" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .fw-inputgroup-sm .input-group-addon { border-radius:0;}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Admin" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderLeft" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <div class="col-xs-12">
        <div class="panel panel-success">
            <div class="panel-heading">TL Strong Selections</div>
            <div class="panel-body">
                <asp:FormView ID="FVSelections" runat="server" RenderOuterTable="false" DataSourceID="SqlDataSourceSelections">
                    <ItemTemplate>
                        <div class="col-md-3">
                            Win %<br />
                            <asp:Label ID="Label11" runat="server" Text='<%# Convert.ToInt16(Eval("winners")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("races"))).ToString("p2") : ""  %>'  />
                            <asp:Label ID="Label12" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("winners") + "/" + Eval("races") + "]</i>"%>' />
                        </div>
                        <div class="col-md-3">
                            ITM %<br />
                            <asp:Label ID="Label13" runat="server" Text='<%# Convert.ToInt16(Eval("itm")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("races"))).ToString("p2") : ""  %>'  />
                            <asp:Label ID="Label14" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("itm") + "/" + Eval("races") + "]</i>"%>' />
                        </div>
                        <div class="col-md-3">
                            Win Bet<br />
                            <asp:Label ID="Label5" runat="server" Visible='<%# Convert.ToDouble(Eval("winpays")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("winpays")) / Convert.ToDouble(Eval("races")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("winpays")) / Convert.ToDouble(Eval("races"))) %>' />
                            <asp:Label ID="LabelNet" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("winpays","{0:c2}") + "]</i>"%>' />
                        </div>
                        <div class="col-md-3">
                            WPS Bet<br />
                            <asp:Label ID="Label6" runat="server" Visible='<%# Convert.ToDouble(Eval("boardpays")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("boardpays")) / Convert.ToDouble(Eval("races")) - 6.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("boardpays")) / Convert.ToDouble(Eval("races")) - 4) %>' />
                            <asp:Label ID="Label7" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("boardpays","{0:c2}") + "]</i>"%>' />
                        </div>
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="SqlDataSourceSelections" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
                    SelectCommand="SELECT COUNT(entries.ID) as races, SUM(CASE WHEN (officialfinish = 1) THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN (officialfinish <= 3) THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN entry_results.officialfinish = 1 THEN entry_results.winpayoff ELSE 0 END) as winpays, SUM(CASE WHEN entry_results.officialfinish = 1 THEN (entry_results.winpayoff + entry_results.placepayoff + entry_results.showpayoff) ELSE 0 END) as boardpays FROM entry_results INNER JOIN entries ON entries.id = entry_results.entryid INNER JOIN races ON entries.raceid = races.id WHERE ccrank = 1 AND ccscore >= .2">
                </asp:SqlDataSource>

                <asp:GridView ID="GVSelections_DTLD" DataSourceID="SqlDataSourceSelections_DTLD" CssClass="table alumnbg table-condensed table-hover" GridLines="None" HeaderStyle-CssClass="active" runat="server" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="scorerange" HeaderText="Score" SortExpression="scorerange" />
                        <asp:TemplateField HeaderText="Win Rates">
                                <ItemTemplate>
                                    <asp:Label ID="Label11" runat="server" Text='<%# Convert.ToInt16(Eval("winners")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("races"))).ToString("p2") : ""  %>'  />
                                    <asp:Label ID="Label12" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("winners") + "/" + Eval("races") + "]</i>"%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ITM">
                                <ItemTemplate>
                                    <asp:Label ID="Label13" runat="server" Text='<%# Convert.ToInt16(Eval("itm")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("races"))).ToString("p2") : ""  %>'  />
                                    <asp:Label ID="Label14" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("itm") + "/" + Eval("races") + "]</i>"%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Win Bet">
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Visible='<%# Convert.ToDouble(Eval("winpays")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("winpays")) / Convert.ToDouble(Eval("races")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("winpays")) / Convert.ToDouble(Eval("races"))) %>' />
                                    <asp:Label ID="LabelNet" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("winpays","{0:c2}") + "]</i>"%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="WPS Bet">
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Visible='<%# Convert.ToDouble(Eval("boardpays")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("boardpays")) / Convert.ToDouble(Eval("races")) - 6.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("boardpays")) / Convert.ToDouble(Eval("races")) - 4) %>' />
                                    <asp:Label ID="Label7" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("boardpays","{0:c2}") + "]</i>"%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                                </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSourceSelections_DTLD" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
                    SelectCommand="SELECT CASE WHEN ccscore < .3 THEN '20-29%' WHEN ccscore BETWEEN .30 AND .40 THEN '30-39%' WHEN ccscore BETWEEN .40 AND .50 THEN '40-49%' WHEN ccscore > .50 THEN '50%+' END as scorerange, COUNT(entries.ID) as races, SUM(CASE WHEN (officialfinish = 1) THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN (officialfinish <= 3) THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN entry_results.officialfinish = 1 THEN entry_results.winpayoff ELSE 0 END) as winpays, SUM(CASE WHEN entry_results.officialfinish = 1 THEN (entry_results.winpayoff + entry_results.placepayoff + entry_results.showpayoff) ELSE 0 END) as boardpays FROM entry_results INNER JOIN entries ON entries.id = entry_results.entryid INNER JOIN races ON entries.raceid = races.id WHERE ccrank = 1 AND ccscore >= .2 GROUP BY CASE WHEN ccscore < .3 THEN '20-29%' WHEN ccscore BETWEEN .3 AND .40 THEN '30-39%' WHEN ccscore BETWEEN .40 AND .50 THEN '40-49%' WHEN ccscore > .50 THEN '50%+' END ORDER BY scorerange">
                </asp:SqlDataSource>
                
            </div>
        </div>
    </div>

     <div id="race-repeater" class="row row-tabs" role="tabpanel">
        <div class="col-xs-12">
            <div id="tabs-v1" class="tabs-top tabs-justified-top"> 
                <ul class="nav nav-tabs nav-justified" role="tablist">
                    <li class="active"><a href="#overall" role="tab" aria-controls="overall" data-toggle="tab">Overall</a></li>
                    <li><a href="#bytrack" role="tab" aria-controls="bytrack" data-toggle="tab">Track/Date</a></li>
                    <li><a href="#longshots" role="tab" aria-controls="longshots" data-toggle="tab">Longshots</a></li>
                    <li><a href="#exotics" role="tab" aria-controls="exotics" data-toggle="tab">Exotics</a></li>
                </ul>
                <div class="tab-content">
                    <div id="overall" class="tab-pane active">
                        
                    <asp:HyperLink ID="HyperLink7" runat="server" CssClass="btn btn-default" NavigateUrl="~/tools/cceval_bytype.aspx">Evaluate by Race Type</asp:HyperLink>
                    <asp:GridView ID="GridViewReturns" CssClass="table alumnbg table-condensed table-hover" GridLines="None" HeaderStyle-CssClass="active" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceReturns">
                        <Columns>
                            <asp:BoundField DataField="ccrank" HeaderText="ccrank" SortExpression="ccrank" />
                            <asp:TemplateField HeaderText="Win Rates">
                                <ItemTemplate>
                                    <asp:Label ID="Label11" runat="server" Text='<%# Convert.ToInt16(Eval("winners")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("races"))).ToString("p2") : ""  %>'  />
                                    <asp:Label ID="Label12" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("winners") + "/" + Eval("races") + "]</i>"%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ITM">
                                <ItemTemplate>
                                    <asp:Label ID="Label13" runat="server" Text='<%# Convert.ToInt16(Eval("itm")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("races"))).ToString("p2") : ""  %>'  />
                                    <asp:Label ID="Label14" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("itm") + "/" + Eval("races") + "]</i>"%>' />
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
                                    <asp:Label ID="Label15" runat="server" Visible='<%# Convert.ToDouble(Eval("avgwinreturn")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("avgwinreturn")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("avgwinreturn"))) %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Place">
                                <ItemTemplate>
                                    <asp:Label ID="Label16" runat="server" Visible='<%# Convert.ToDouble(Eval("avgplacereturn")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("avgplacereturn")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("avgplacereturn"))) %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Show">
                                <ItemTemplate>
                                    <asp:Label ID="Label17" runat="server" Visible='<%# Convert.ToDouble(Eval("avgshowreturn")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("avgshowreturn")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("avgshowreturn"))) %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                           <asp:SqlDataSource ID="SqlDataSourceReturns" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
                            SelectCommand="SP_EvalReturns" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter Name="rtype" DefaultValue="All" /> 
                            </SelectParameters>
                        </asp:SqlDataSource>

                    </div>

                    <div id="bytrack" class="tab-pane">
                        <div class="title-md hr-before">Results By Track and Date</div>
    <asp:GridView ID="GVResultsByTrackAndDate" CssClass="table alumnbg table-condensed table-hover" GridLines="None" HeaderStyle-CssClass="active" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceResultsByTrack">
        <Columns>
          
            <asp:BoundField DataField="rdate" HeaderText="rdate" SortExpression="rdate" DataFormatString="{0:d}" />
            <asp:BoundField DataField="abbrev" HeaderText="Track" SortExpression="abbrev" />
            <asp:TemplateField HeaderText="Win Rates">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Convert.ToInt16(Eval("winners")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("races"))).ToString("p2") : ""  %>'  />
                    <asp:Label ID="Label2" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("winners") + "/" + Eval("races") + "]</i>"%>' />
                    <br />
                    Strong 
                    <asp:Label ID="Label9" runat="server" Text='<%# Convert.ToInt16(Eval("strong_winners")) > 0 ? (Convert.ToDouble(Eval("strong_winners")) / Convert.ToDouble(Eval("strong_races"))).ToString("p2") : ""  %>'  />
                    <asp:Label ID="Label10" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("strong_winners") + "/" + Eval("strong_races") + "]</i>"%>' />
                    
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ITM">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Convert.ToInt16(Eval("itm")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("races"))).ToString("p2") : ""  %>'  />
                    <asp:Label ID="Label4" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("itm") + "/" + Eval("races") + "]</i>"%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CC1">
                <ItemTemplate>
                    Win
                    <asp:Label ID="Label5" runat="server" Visible='<%# Convert.ToDouble(Eval("toppick_winpays")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("toppick_winpays")) / Convert.ToDouble(Eval("races")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("toppick_winpays")) / Convert.ToDouble(Eval("races"))) %>' />
                    <asp:Label ID="LabelNet" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("toppick_winpays","{0:c2}") + "]</i>"%>' />
                    <br />
                    Board
                    <asp:Label ID="Label6" runat="server" Visible='<%# Convert.ToDouble(Eval("toppick_boardpays")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("toppick_boardpays")) / Convert.ToDouble(Eval("races")) - 6.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("toppick_boardpays")) / Convert.ToDouble(Eval("races")) - 4) %>' />
                    <asp:Label ID="Label7" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("toppick_boardpays","{0:c2}") + "]</i>"%>' />
                    <br />
                    Strong
                    <asp:Label ID="Label8" runat="server" Visible='<%# Convert.ToDouble(Eval("strong_toppick_winpays")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("strong_toppick_winpays")) / Convert.ToDouble(Eval("strong_races")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("strong_toppick_winpays")) / Convert.ToDouble(Eval("strong_races"))) %>' />
                    <asp:Label ID="Label18" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("strong_toppick_winpays","{0:c2}") + "]</i>"%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CC2">
                <ItemTemplate>
                    Win
                    <asp:Label ID="Label19" runat="server" Visible='<%# Convert.ToDouble(Eval("secondpick_winpays")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("secondpick_winpays")) / Convert.ToDouble(Eval("races")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("secondpick_winpays")) / Convert.ToDouble(Eval("races"))) %>' />
                    <asp:Label ID="Label20" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("secondpick_winpays","{0:c2}") + "]</i>"%>' />
                    <br />
                    Board
                    <asp:Label ID="Label21" runat="server" Visible='<%# Convert.ToDouble(Eval("secondpick_boardpays")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("secondpick_boardpays")) / Convert.ToDouble(Eval("races")) - 6.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("secondpick_boardpays")) / Convert.ToDouble(Eval("races")) - 4) %>' />
                    <asp:Label ID="Label22" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("secondpick_boardpays","{0:c2}") + "]</i>"%>' />
                    <br />
                    Strong
                    <asp:Label ID="Label23" runat="server" Visible='<%# Convert.ToDouble(Eval("strong_secondpick_winpays")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("strong_secondpick_winpays")) / Convert.ToDouble(Eval("races")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("strong_secondpick_winpays")) / Convert.ToDouble(Eval("strong_races"))) %>' />
                    <asp:Label ID="Label24" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("strong_secondpick_winpays","{0:c2}") + "]</i>"%>' />
                </ItemTemplate>
            </asp:TemplateField>       
          
        </Columns>
    </asp:GridView>
                    </div>

                    <div id="longshots" class="tab-pane">
                        <div class="title-md hr-before">Longshot Plays</div>
    <asp:GridView ID="GridViewLongshots" CssClass="table alumnbg table-condensed table-hover" GridLines="None" HeaderStyle-CssClass="active" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceLongshots">
        <Columns>
            <asp:BoundField DataField="ccrank" HeaderText="ccrank" SortExpression="ccrank" />
            <asp:TemplateField HeaderText="Win Rates">
                <ItemTemplate>
                    <asp:Label ID="Label25" runat="server" Text='<%# Convert.ToInt16(Eval("winners")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("races"))).ToString("p2") : ""  %>'  />
                    <asp:Label ID="Label26" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("winners") + "/" + Eval("races") + "]</i>"%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ITM">
                <ItemTemplate>
                    <asp:Label ID="Label27" runat="server" Text='<%# Convert.ToInt16(Eval("itm")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("races"))).ToString("p2") : ""  %>'  />
                    <asp:Label ID="Label28" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("itm") + "/" + Eval("races") + "]</i>"%>' />
                </ItemTemplate>
            </asp:TemplateField>
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
                    <asp:Label ID="Label29" runat="server" Visible='<%# Convert.ToDouble(Eval("avgplacereturn")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("avgplacereturn")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("avgplacereturn"))) %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Show">
                <ItemTemplate>
                    <asp:Label ID="Label30" runat="server" Visible='<%# Convert.ToDouble(Eval("avgshowreturn")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("avgshowreturn")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("avgshowreturn"))) %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceLongshots" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT entries.ccrank, (SELECT COUNT(*) AS predicted FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid WHERE (entries_1.ccrank = entries.ccrank) AND (entries_1.livelongshot = 1) AND (entry_results_2.officialfinish = 1)) AS winners, (SELECT COUNT(*) AS predicted FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid WHERE (entries_1.ccrank = entries.ccrank) AND (entries_1.livelongshot = 1) AND (entry_results_2.officialfinish < 4)) AS itm, (SELECT COUNT(*) AS predicted FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid WHERE (entries_1.ccrank = entries.ccrank) AND (entries_1.livelongshot = 1)) AS races, (SELECT AVG(entry_results_2.winpayoff) AS t FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid WHERE (entries_1.ccrank = entries.ccrank) AND (entries_1.livelongshot = 1) AND (entry_results_2.officialfinish = 1) GROUP BY entry_results_2.officialfinish) AS avgwinpayoff, (SELECT AVG(entry_results_2.placepayoff) AS t FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid WHERE (entries_1.ccrank = entries.ccrank) AND (entries_1.livelongshot = 1) AND (entry_results_2.officialfinish = 2) GROUP BY entry_results_2.officialfinish) AS avgplacepayoff, (SELECT AVG(entry_results_2.showpayoff) AS t FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid WHERE (entries_1.ccrank = entries.ccrank) AND (entries_1.livelongshot = 1) AND (entry_results_2.officialfinish = 3) GROUP BY entry_results_2.officialfinish) AS avgshowpayoff, (SELECT AVG(entry_results_2.winpayoff) AS t FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid WHERE (entries_1.ccrank = entries.ccrank) AND (entries_1.livelongshot = 1)) AS avgwinreturn, (SELECT AVG(entry_results_2.placepayoff) AS t FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid WHERE (entries_1.ccrank = entries.ccrank) AND (entries_1.livelongshot = 1)) AS avgplacereturn, (SELECT AVG(entry_results_2.showpayoff) AS t FROM entries AS entries_1 INNER JOIN entry_results AS entry_results_2 ON entries_1.id = entry_results_2.entryid WHERE (entries_1.ccrank = entries.ccrank) AND (entries_1.livelongshot = 1)) AS avgshowreturn FROM entries INNER JOIN entry_results AS entry_results_1 ON entries.id = entry_results_1.entryid WHERE (entries.livelongshot = 1) GROUP BY entries.ccrank, entries.livelongshot">
    </asp:SqlDataSource>
                    </div>

                    <div id="exotics" class="tab-pane ">
                        <div class="title-md hr-before">Exotics Data</div>

                        <asp:Repeater ID="RepeaterEx" runat="server" DataSourceID="SqlDataSourceEx">
                            <ItemTemplate>
                                <div class=" fw-inputgroup-sm" runat="server" visible='<%# Convert.ToInt16(Eval("rcount")) > 0  %>' >
                                    <div class="opacity-layer section section-xs section-both ">
                                        <div class="row">
                        <div class="col-xs-12"  >
                        <asp:Label ID="labelTrack" runat="server" Text='<%# Eval("abbrev") %>' CssClass="title-sm hr-before" />
                            <sub data-toggle="tooltip" title="Number of Races"><%# Eval("rcount") %></sub>
                            
                        </div>
                    </div>
                                        <div class="row">
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
                        <div class='<%# GetPanelClass(Convert.ToDouble(Eval("excold")), Convert.ToDouble(Eval("rcount"))) %>' runat="server" >
                            <div class="panel-heading">Ex Cold  <a  href='javascript:void(0);' class="btn btn-ghost btn-xs pull-right exoticdetails" rel='<%# "exotic=ex_cold&track=" + Eval("abbrev") %>'><i class="fa fa-list"></i></a></div>
                            <div class="panel-body">
                            <asp:Label ID="LabelPct" runat="server" Text='<%# Convert.ToInt16(Eval("excold")) > 0 ? (Convert.ToDouble(Eval("excold")) / Convert.ToDouble(Eval("rcount"))).ToString("p2") : ""  %>'  />
                            <asp:Label ID="LabelWinners" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("excold") + "/" + Eval("rcount") + "]</i>"%>' />
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">Avg</div>
                                <div class="form-control text-right"><asp:Label ID="LabelPay" runat="server" Text='<%# Convert.ToInt16(Eval("excold")) > 0 ? (Convert.ToDouble(Eval("ex_coldpay")) / Convert.ToDouble(Eval("excold"))).ToString("c2") : "" %>' /></div>
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">Total</div>
                                <div class="form-control text-right"><asp:Label ID="Label51" runat="server" Text='<%# Convert.ToInt16(Eval("excold")) > 0 ? Convert.ToDouble(Eval("ex_coldpay")).ToString("c2") : "" %>' /></div>
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">ROI</div>
                                <div class="form-control text-right">
                                    <%# GetROIIcon("excold", Convert.ToInt16(Eval("rcount")), Convert.ToInt16(Eval("excold")), Convert.ToDouble(Eval("ex_coldpay"))) %>
                                    <asp:Label ID="Label57" runat="server" Text='<%# ROI("excold", Convert.ToInt16(Eval("rcount")), Convert.ToInt16(Eval("excold")), Convert.ToDouble(Eval("ex_coldpay"))).ToString("p2") %>'  /></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
                        <div class='<%# GetPanelClass(Convert.ToDouble(Eval("exbox")), Convert.ToDouble(Eval("rcount"))) %>' runat="server" visible='<%# Convert.ToInt16(Eval("rcount")) > 0  %>' >
                            <div class="panel-heading">Ex Box <a  href='javascript:void(0);' class="btn btn-ghost btn-xs pull-right exoticdetails" rel='<%# "exotic=ex_box&track=" + Eval("abbrev") %>'><i class="fa fa-list"></i></a></div>
                            <div class="panel-body">
                            <asp:Label ID="Label31" runat="server" Text='<%# Convert.ToInt16(Eval("exbox")) > 0 ? (Convert.ToDouble(Eval("exbox")) / Convert.ToDouble(Eval("rcount"))).ToString("p2") : ""  %>'  />
                            <asp:Label ID="Label32" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("exbox") + "/" + Eval("rcount") + "]</i>"%>' />
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">Avg</div>
                                <div class="form-control text-right"><asp:Label ID="Label33" runat="server" Text='<%# Convert.ToInt16(Eval("exbox")) > 0 ? (Convert.ToDouble(Eval("ex_boxpay")) / Convert.ToDouble(Eval("exbox"))).ToString("c2") : "" %>'  /></div>
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">Total</div>
                                <div class="form-control text-right"><asp:Label ID="Label50" runat="server" Text='<%# Convert.ToInt16(Eval("exbox")) > 0 ? Convert.ToDouble(Eval("ex_boxpay")).ToString("c2") : "" %>'  /></div>
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">ROI</div>                                
                                <div class="form-control text-right">
                                    <%# GetROIIcon("exbox", Convert.ToInt16(Eval("rcount")), Convert.ToInt16(Eval("exbox")), Convert.ToDouble(Eval("ex_boxpay"))) %>
                                    <asp:Label ID="Label56" runat="server" Text='<%# ROI("exbox", Convert.ToInt16(Eval("rcount")), Convert.ToInt16(Eval("exbox")), Convert.ToDouble(Eval("ex_boxpay"))).ToString("p2") %>'  /></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
                        <div class='<%# GetPanelClass(Convert.ToDouble(Eval("exboxplus")), Convert.ToDouble(Eval("rcount"))) %>' runat="server" visible='<%# Convert.ToInt16(Eval("rcount")) > 0  %>' >
                            <div class="panel-heading">Ex Box+1 <a  href='javascript:void(0);' class="btn btn-ghost btn-xs pull-right exoticdetails" rel='<%# "exotic=ex_boxplusone&track=" + Eval("abbrev") %>'><i class="fa fa-list"></i></a></div>
                            <div class="panel-body">
                            <asp:Label ID="Label34" runat="server" Text='<%# Convert.ToInt16(Eval("exboxplus")) > 0 ? (Convert.ToDouble(Eval("exboxplus")) / Convert.ToDouble(Eval("rcount"))).ToString("p2") : ""  %>'  />
                            <asp:Label ID="Label35" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("exboxplus") + "/" + Eval("rcount") + "]</i>"%>' />
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">Avg</div>
                                <div class="form-control text-right"><asp:Label ID="Label36" runat="server" Text='<%# Convert.ToInt16(Eval("exboxplus")) > 0 ? (Convert.ToDouble(Eval("ex_boxplusonepay")) / Convert.ToDouble(Eval("exboxplus"))).ToString("c2") : "" %>' /></div>
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">Total</div>
                                <div class="form-control text-right"><asp:Label ID="Label49" runat="server" Text='<%# Convert.ToInt16(Eval("exboxplus")) > 0 ? Convert.ToDouble(Eval("ex_boxplusonepay")).ToString("c2") : "" %>' /></div>
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">ROI</div>                                
                                <div class="form-control text-right">
                                    <%# GetROIIcon("exboxplus", Convert.ToInt16(Eval("rcount")), Convert.ToInt16(Eval("exboxplus")), Convert.ToDouble(Eval("ex_boxplusonepay"))) %>
                                    <asp:Label ID="Label55" runat="server" Text='<%# ROI("exboxplus", Convert.ToInt16(Eval("rcount")), Convert.ToInt16(Eval("exboxplus")), Convert.ToDouble(Eval("ex_boxplusonepay"))).ToString("p2") %>'  /></div>
                            </div>
                        </div>
                    </div>
                    <!--Tri-->
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
                        <div class='<%# GetPanelClass(Convert.ToDouble(Eval("tricold")), Convert.ToDouble(Eval("rcount"))) %>' runat="server" visible='<%# Convert.ToInt16(Eval("rcount")) > 0  %>' >
                            <div class="panel-heading">Tri Cold <a  href='javascript:void(0);' class="btn btn-ghost btn-xs pull-right exoticdetails" rel='<%# "exotic=tri_cold&track=" + Eval("abbrev") %>'><i class="fa fa-list"></i></a></div>
                            <div class="panel-body">
                            <asp:Label ID="Label37" runat="server" Text='<%# Convert.ToInt16(Eval("tricold")) > 0 ? (Convert.ToDouble(Eval("tricold")) / Convert.ToDouble(Eval("rcount"))).ToString("p2") : ""  %>'  />
                            <asp:Label ID="Label38" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("tricold") + "/" + Eval("rcount") + "]</i>"%>' />
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">Avg</div>
                                <div class="form-control text-right"><asp:Label ID="Label39" runat="server" Text='<%# Convert.ToInt16(Eval("tricold")) > 0 ? (Convert.ToDouble(Eval("tri_coldpay")) / Convert.ToDouble(Eval("tricold"))).ToString("c2") : "" %>' /></div>
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">Total</div>
                                <div class="form-control text-right"><asp:Label ID="Label48" runat="server" Text='<%# Convert.ToInt16(Eval("tricold")) > 0 ? Convert.ToDouble(Eval("tri_coldpay")).ToString("c2") : "" %>' /></div>
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">ROI</div>
                                <div class="form-control text-right">
                                    <%# GetROIIcon("tricold", Convert.ToInt16(Eval("rcount")), Convert.ToInt16(Eval("tricold")), Convert.ToDouble(Eval("tri_coldpay"))) %>
                                    <asp:Label ID="Label54" runat="server" Text='<%# ROI("tricold", Convert.ToInt16(Eval("rcount")), Convert.ToInt16(Eval("tricold")), Convert.ToDouble(Eval("tri_coldpay"))).ToString("p2") %>'  /></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
                        <div class='<%# GetPanelClass(Convert.ToDouble(Eval("tribox")), Convert.ToDouble(Eval("rcount"))) %>' runat="server" visible='<%# Convert.ToInt16(Eval("rcount")) > 0  %>' >
                            <div class="panel-heading">Tri Box <a  href='javascript:void(0);' class="btn btn-ghost btn-xs pull-right exoticdetails" rel='<%# "exotic=tri_box&track=" + Eval("abbrev") %>'><i class="fa fa-list"></i></a></div>
                            <div class="panel-body">
                            <asp:Label ID="Label40" runat="server" Text='<%# Convert.ToInt16(Eval("tribox")) > 0 ? (Convert.ToDouble(Eval("tribox")) / Convert.ToDouble(Eval("rcount"))).ToString("p2") : ""  %>'  />
                            <asp:Label ID="Label41" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("tribox") + "/" + Eval("rcount") + "]</i>"%>' />
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">Avg</div>
                                <div class="form-control text-right"><asp:Label ID="Label42" runat="server" Text='<%# Convert.ToInt16(Eval("tribox")) > 0 ? (Convert.ToDouble(Eval("tri_boxpay")) / Convert.ToDouble(Eval("tribox"))).ToString("c2") : "" %>'  /></div>
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">Total</div>
                                <div class="form-control text-right"><asp:Label ID="Label47" runat="server" Text='<%# Convert.ToInt16(Eval("tribox")) > 0 ? Convert.ToDouble(Eval("tri_boxpay")).ToString("c2") : "" %>'  /></div>
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">ROI</div>
                                <div class="form-control text-right">
                                    <%# GetROIIcon("tribox", Convert.ToInt16(Eval("rcount")), Convert.ToInt16(Eval("tribox")), Convert.ToDouble(Eval("tri_boxpay"))) %>                                    
                                    <asp:Label ID="Label52" runat="server" Text='<%# ROI("tribox", Convert.ToInt16(Eval("rcount")), Convert.ToInt16(Eval("tribox")), Convert.ToDouble(Eval("tri_boxpay"))).ToString("p2") %>'  />

                                </div>
                            </div>                            
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
                        <div class='<%# GetPanelClass(Convert.ToDouble(Eval("triboxplus")), Convert.ToDouble(Eval("rcount"))) %>' runat="server" visible='<%# Convert.ToInt16(Eval("rcount")) > 0  %>' >
                            <div class="panel-heading">Tri Box+1 <a  href='javascript:void(0);' class="btn btn-ghost btn-xs pull-right exoticdetails" rel='<%# "exotic=tri_boxplusone&track=" + Eval("abbrev") %>'><i class="fa fa-list"></i></a></div>
                            <div class="panel-body">
                            <asp:Label ID="Label43" runat="server" Text='<%# Convert.ToInt16(Eval("triboxplus")) > 0 ? (Convert.ToDouble(Eval("triboxplus")) / Convert.ToDouble(Eval("rcount"))).ToString("p2") : ""  %>'  />
                            <asp:Label ID="Label44" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("triboxplus") + "/" + Eval("rcount") + "]</i>"%>' />
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">Avg</div>
                                <div class="form-control text-right"><asp:Label ID="Label45" runat="server" Text='<%# (Convert.ToDouble(Eval("tri_boxplusonepay")) / Convert.ToDouble(Eval("triboxplus"))).ToString("c2") %>' /></div>
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">Total</div>
                                <div class="form-control text-right"><asp:Label ID="Label46" runat="server" Text='<%# Convert.ToDouble(Eval("tri_boxplusonepay")).ToString("c2") %>' /></div>
                            </div>
                            <div class="input-group">
                                <div class="input-group-addon">ROI</div>
                                <div class="form-control text-right">
                                    <%# GetROIIcon("triboxplus", Convert.ToInt16(Eval("rcount")), Convert.ToInt16(Eval("triboxplus")), Convert.ToDouble(Eval("tri_boxplusonepay"))) %>
                                    <asp:Label ID="Label53" runat="server" Text='<%# ROI("triboxplus", Convert.ToInt16(Eval("rcount")), Convert.ToInt16(Eval("triboxplus")), Convert.ToDouble(Eval("tri_boxplusonepay"))).ToString("p2") %>'  /></div>
                            </div>
                        </div>
                    </div>
                    </div>
                                    </div>
                                </div>

                            </ItemTemplate>
                            
                        </asp:Repeater>
    
                    </div>
                    
                    
            </div>
        </div>
    </div>
    
    </div>
    
 
    
    





    <asp:SqlDataSource ID="SqlDataSourceEx" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="select abbrev, SUM(CASE WHEN ex_box = 1 THEN 1 ELSE 0 END) as exbox, SUM(CASE WHEN tri_box = 1 THEN 1 ELSE 0 END) as tribox, SUM(CASE WHEN ex_cold = 1 THEN 1 ELSE 0 END) as excold, SUM(CASE WHEN tri_cold = 1 THEN 1 ELSE 0 END) as tricold, SUM(CASE WHEN ex_boxplusone = 1 THEN 1 ELSE 0 END) as exboxplus, SUM(CASE WHEN tri_boxplusone = 1 THEN 1 ELSE 0 END) as triboxplus, SUM(CASE WHEN ex_box = 1 THEN exacta ELSE 0 END) as expay, SUM(CASE WHEN tri_box = 1 THEN exacta ELSE 0 END) as tripay, SUM(CASE WHEN ex_cold = 1 THEN exacta ELSE 0 END) as ex_coldpay, SUM(CASE WHEN tri_cold = 1 THEN trifecta ELSE 0 END) as tri_coldpay, SUM(CASE WHEN ex_boxplusone = 1 THEN exacta ELSE 0 END) as ex_boxplusonepay, SUM(CASE WHEN ex_box = 1 THEN exacta ELSE 0 END) as ex_boxpay, SUM(CASE WHEN tri_box = 1 THEN trifecta ELSE 0 END) as tri_boxpay, SUM(CASE WHEN tri_boxplusone = 1 THEN trifecta ELSE 0 END) as tri_boxplusonepay, (SELECT COUNT(r.ID) FROM races as r INNER JOIN tracks as t ON r.track = t.id WHERE r.exoticsproc = 1 AND t.abbrev = tracks.abbrev) as rcount from races INNER JOIN tracks ON races.track = tracks.id GROUP BY abbrev">
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="SqlDataSourceResults" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT entries.name, entries.post, entry_results.winpayoff, entry_results.placepayoff, entry_results.showpayoff, races.rnum, tracks.abbrev, entry_results.officialfinish, entries.ccrank, entries.ccpoints, entries.livelongshot, entries.ccscore FROM entries INNER JOIN entry_results ON entries.id = entry_results.entryid INNER JOIN races ON entries.raceid = races.id AND entry_results.raceid = races.id INNER JOIN tracks ON races.track = tracks.id WHERE (entries.scratched = 0) AND (entry_results.officialfinish &lt;= 3) ORDER BY races.rdate, races.track, races.rnum, entry_results.officialfinish">
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceResultsByTrack" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT rdate, tracks.abbrev, COUNT(DISTINCT races.id) as races, SUM(CASE WHEN (officialfinish = 1 AND entries.ccrank = 1) THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN ccscore > .19 and ccrank = 1 THEN 1 ELSE 0 END) as strong_races, SUM(CASE WHEN (officialfinish = 1 AND entries.ccrank = 1 AND entries.ccscore > .19) THEN 1 ELSE 0 END) as strong_winners, SUM(CASE WHEN (officialfinish <= 3 AND entries.ccrank = 1) THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN entry_results.officialfinish = 1 AND ccrank = 1 THEN entry_results.winpayoff ELSE 0 END) as toppick_winpays, SUM(CASE WHEN entry_results.officialfinish <= 3 AND ccrank = 1 THEN (entry_results.winpayoff + entry_results.placepayoff + entry_results.showpayoff) ELSE 0 END) as toppick_boardpays, SUM(CASE WHEN entry_results.officialfinish = 1 AND ccrank = 1 AND ccscore > .19 THEN entry_results.winpayoff ELSE 0 END) as strong_toppick_winpays, SUM(CASE WHEN entry_results.officialfinish <= 1 AND ccrank = 1 AND ccscore > .19 THEN (entry_results.winpayoff + entry_results.placepayoff + entry_results.showpayoff) ELSE 0 END) as strong_toppick_boardpays, SUM(CASE WHEN entry_results.officialfinish = 1 AND ccrank = 1 THEN entry_results.winpayoff ELSE 0 END) as secondpick_winpays, SUM(CASE WHEN entry_results.officialfinish <= 3 AND ccrank = 2 THEN (entry_results.winpayoff + entry_results.placepayoff + entry_results.showpayoff) ELSE 0 END) as secondpick_boardpays, SUM(CASE WHEN entry_results.officialfinish = 1 AND ccrank = 2 AND ccscore > .19 THEN entry_results.winpayoff ELSE 0 END) as strong_secondpick_winpays, SUM(CASE WHEN entry_results.officialfinish <= 1 AND ccrank = 2 AND ccscore > .19 THEN (entry_results.winpayoff + entry_results.placepayoff + entry_results.showpayoff) ELSE 0 END) as strong_secondpick_boardpays FROM entry_results INNER JOIN entries ON entries.id = entry_results.entryid INNER JOIN races ON entries.raceid = races.id INNER JOIN tracks on races.track = tracks.id GROUP BY races.rdate, tracks.abbrev ORDER BY rdate desc">
    </asp:SqlDataSource>
    
</asp:Content>
