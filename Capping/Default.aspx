<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="_Default" Codebehind="Default.aspx.cs" %>

<%@ Register Src="~/ascx/tips.ascx" TagPrefix="uc1" TagName="tips" %>
<%@ Register Src="~/ascx/bestbets.ascx" TagPrefix="uc1" TagName="bestbets" %>



<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <link href="css/chartist.min.css" rel="stylesheet" />
    <script src="js/chartist.min.js"></script>
    <link href="css/chartist-plugin-tooltip.css" rel="stylesheet" />
    <script src="js/chartist-plugin-tooltip.js"></script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        The easiest legal way to play thoroughbred handicapping tournaments!
    </h2>
    <p>
        We offer membership to our website in exchange for access to our free thoroughbred handicapping tournaments with real prize money!  You will participate in handicapping real live horse racing events and have a chance to earn real prize money every week.
    </p>

    <div class="panel panel-default">
        <div class="panel-heading">
            Free Picks
        </div>
        <div class="">
            <div>
                <div class="ribboncontainer one">
                <div class="skew l"></div>
                  <div class="ribbonmain">
                    <div class="title-md">Tips</div>   
                  </div>
                </div>
                <div class="font-xs">
                <uc1:tips runat="server" ID="tips" />
                </div>
            </div>
            <div>
                <div class="ribboncontainer one">
                <div class="skew l"></div>
                  <div class="ribbonmain">
                    <div class="title-md">Best Values</div>   
                  </div>
                </div>
                <div class="font-xs">
                    <uc1:bestbets runat="server" ID="bestbets" />
                </div>
            </div>
        </div>
    </div>

    
    <div class="col-md-6 small">
        <div class="row">

            <div class="col-md-6">
                <div class="panel panel-default">
                <div class="panel-heading">Recent Exactas</div>
                <div class="">
                    <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSourceEX" AutoGenerateColumns="false" GridLines="None" CssClass="table table-condensed table-hover">
                        <Columns>
                            <asp:BoundField HeaderText="Horse" DataField="name" />
                            <asp:BoundField HeaderText="Amount" DataField="exacta" DataFormatString="{0:c2}" ItemStyle-HorizontalAlign="Right" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceEX" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
                        SelectCommand="SELECT entries.name, entries.post, entries.program, entry_results.officialfinish, entry_results.winpayoff, entry_results.placepayoff, entry_results.showpayoff, entries.ccrank, entries.ccpoints, entries.livelongshot, entries.ccscore, races.exacta, races.trifecta, ISNULL(races.ex_cold, 0) ex_cold,  ISNULL(races.tri_cold, 0) tri_cold,  ISNULL(races.ex_box, 0) ex_box,  ISNULL(races.tri_box, 0) tri_box,  ISNULL(races.ex_boxplusone, 0) ex_boxplusone,  ISNULL(races.tri_boxplusone, 0) tri_boxplusone FROM entries INNER JOIN entry_results ON entries.id = entry_results.entryid INNER JOIN races ON entries.raceid = races.id AND entry_results.raceid = races.id INNER JOIN tracks ON races.track = tracks.id WHERE (entries.scratched = 0) AND (entry_results.officialfinish = 1) AND (ccrank = 1 OR ccrank = 2) AND (ex_boxplusone = 1) AND (rdate >= DATEADD(month,-1,GETDATE())) ORDER BY rdate DESC, winpayoff DESC">
                    </asp:SqlDataSource>                
                </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="panel panel-default">
                <div class="panel-heading">Recent Trifectas</div>
                <div class="">
                    <asp:GridView ID="GridView2" runat="server" DataSourceID="SqlDataSourceTRI" AutoGenerateColumns="false" GridLines="None" CssClass="table table-condensed table-hover">
                        <Columns>
                            <asp:TemplateField HeaderText="Race" >
                                <ItemTemplate>
                                    <%# Convert.ToDateTime(Eval("rdate")).ToShortDateString() + " - " + Eval("abbrev") + " " + Eval("rnum")  %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Amount" DataField="trifecta" DataFormatString="{0:c2}" ItemStyle-HorizontalAlign="Right" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceTRI" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
                        SelectCommand="SELECT races.rnum, races.rdate, tracks.abbrev, entries.name, entries.post, entries.program, entry_results.officialfinish, entry_results.winpayoff, entry_results.placepayoff, entry_results.showpayoff, entries.ccrank, entries.ccpoints, entries.livelongshot, entries.ccscore, races.exacta, races.trifecta, ISNULL(races.ex_cold, 0) ex_cold,  ISNULL(races.tri_cold, 0) tri_cold,  ISNULL(races.ex_box, 0) ex_box,  ISNULL(races.tri_box, 0) tri_box,  ISNULL(races.ex_boxplusone, 0) ex_boxplusone,  ISNULL(races.tri_boxplusone, 0) tri_boxplusone FROM entries INNER JOIN entry_results ON entries.id = entry_results.entryid INNER JOIN races ON entries.raceid = races.id AND entry_results.raceid = races.id INNER JOIN tracks ON races.track = tracks.id WHERE (entries.scratched = 0) AND (entry_results.officialfinish = 1) AND (ccrank = 1 OR ccrank = 2) AND (tri_boxplusone = 1) AND (rdate >= DATEADD(month,-1,GETDATE())) ORDER BY rdate DESC, winpayoff DESC">
                    </asp:SqlDataSource>                
                </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        Select Track :
    <asp:DropDownList ID="DDLTrack" CssClass="trackselector" runat="server" DataSourceID="SqlDataSourceTracks" DataTextField="abbrev" DataValueField="track">
    </asp:DropDownList>
    <button id="btnCreateChart" class="btn btn-primary btn-xs">Create chart</button>
    <asp:SqlDataSource ID="SqlDataSourceTracks" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT DISTINCT(track), abbrev FROM [races] INNER JOIN tracks on tracks.id = races.track WHERE ([rdate] >= DATEADD(MONTH, -1, GETDATE())) ORDER BY abbrev">        
    </asp:SqlDataSource>
    <div class="ct-chart ct-golden-section"></div>
    </div>
    <script>
        $(document).ready(function () {
            jQuery('#btnCreateChart').click();
        });

        $("#btnCreateChart").on('click', function (e) {
            var self = $(this);
            var pData = [];
            pData[0] = $(".trackselector").val();
            var jsonData = JSON.stringify({ pData: pData });
            $.ajax({
                type: "POST",
                url: "results.asmx/getRecentResults",
                data: jsonData,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess_,
                error: OnErrorCall_
            });
            function OnSuccess_(response) {
                var aData = response.d;
                var arrLabels = [], arrSeries = [], arrSeriesARR = [];
                $.map(aData, function (item, index) {
                    arrLabels.push(item.rdate);
                    arrSeries.push(item.json);
                });
                arrSeriesARR.push(arrSeries);
                var data = {
                    labels: arrLabels,
                    series: arrSeriesARR
                }                
                // This is themain part, where we set data and create PIE CHART
                var chart = new Chartist.Line('.ct-chart', data, {
                    plugins: [
                      Chartist.plugins.tooltip()
                    ],                    
                    fullWidth: true
                });
                chart.on('draw', function (data) {
                    if (data.type === 'line' || data.type === 'area') {
                        data.element.animate({
                            d: {
                                begin: 2000 * data.index,
                                dur: 2000,
                                from: data.path.clone().scale(1, 0).translate(0, data.chartRect.height()).stringify(),
                                to: data.path.clone().stringify(),
                                easing: Chartist.Svg.Easing.easeOutQuint
                            }
                        });
                    }
                });
            }

            function OnErrorCall_(response) {
                alert("Whoops something went wrong!");
            }
            e.preventDefault();
        });
    </script>
</asp:Content>
