<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="userstats.ascx.cs" Inherits="Capping.ascx.userstats" %>
<div class="row">
    <asp:FormView ID="FVUserStats" runat="server" RenderOuterTable="false" DataSourceID="SqlDataSourceUserStats">
        <ItemTemplate>
            
            <div class="col-sm-6">
                <div class="">
                    <div class="title-sm text-center">Overall</div>
            <div class="post-xs-side">                               
                <div class="wrapper-dial-xs">
                    <input type="text" class="dial dial-1" value='<%# Convert.ToDouble(Eval("numpicked")) > 0 ? Convert.ToInt16((Convert.ToDouble(Eval("numcorrect")) / Convert.ToDouble(Eval("numpicked")) * 100)) : 0 %>' data-max="100" data-readOnly=true  data-width="86" data-height="86" data-thickness=.2>
                    <h3 class="title" data-toggle="tooltip" title='<%# Eval("numcorrect") + " / " + Eval("numpicked") %>'>Accuracy</h3>
                </div>
            </div>                
               <div class="caption-portfolio text-center">
                    <span>Return: </span>
                    <%# picks.GetROIIcon((Convert.ToDouble(Eval("totalpayout")) / Convert.ToDouble(Eval("totalwagered")) - 1)) %>
                    <asp:Label ID="LabelOverallReturn" runat="server" data-toggle="tooltip" title='<%# Eval("totalpayout","{0:c2}") %>' Text='<%# (Convert.ToDouble(Eval("totalpayout")) / Convert.ToDouble(Eval("totalwagered")) - 1).ToString("P2") %>' />
               </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:FormView>
    <asp:FormView ID="FormView1" runat="server" RenderOuterTable="false" DataSourceID="SqlDataSourceUserStatsL30">
        <ItemTemplate>            
            <div class="col-sm-6">
                <div class="">
                    <div class="title-sm text-center">Last 30</div>
            <div class="post-xs-side">                               
                <div class="wrapper-dial-xs">
                    <input type="text" class="dial dial-1" value='<%# Convert.ToDouble(Eval("numpicked")) > 0 ? Convert.ToInt16((Convert.ToDouble(Eval("numcorrect")) / Convert.ToDouble(Eval("numpicked")) * 100)) : 0 %>' data-max="100" data-readOnly=true  data-width="86" data-height="86" data-thickness=.2>
                    <h3 class="title" data-toggle="tooltip" title='<%# Eval("numcorrect") + " / " + Eval("numpicked") %>'>Accuracy</h3>
                </div>
            </div>                
               <div class="caption-portfolio text-center">
                    <span>Return: </span>
                   <%# picks.GetROIIcon((Convert.ToDouble(Eval("totalpayout")) / Convert.ToDouble(Eval("totalwagered")) - 1)) %>
                    <asp:Label ID="LabelOverallReturn" runat="server" data-toggle="tooltip" title='<%# Eval("totalpayout","{0:c2}") %>' Text='<%# (Convert.ToDouble(Eval("totalpayout")) / Convert.ToDouble(Eval("totalwagered")) - 1 ).ToString("P2") %>' />
                </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:FormView>
</div>
       <asp:Repeater ID="RepeaterStats"  runat="server" DataSourceID="SqlDataSourceUserStats_GRP">
           <ItemTemplate>
                <div class="row">
                <div class="post-xs-side">                       
                    <div class="col-sm-3">
                        <div class="title-sm text-center"><%# Eval("abbrev") %></div>
                    </div>
                    <div class="col-sm-4">
                        
                        <div class="wrapper-dial-xs">
                            <input type="text" class="dial dial-1" value='<%# Convert.ToDouble(Eval("numpicked")) > 0 ? Convert.ToInt16((Convert.ToDouble(Eval("numcorrect")) / Convert.ToDouble(Eval("numpicked")) * 100)) : 0 %>' data-max="100" data-readOnly=true  data-width="43" data-height="43" data-thickness=.2>
                            <h3 class="title" data-toggle="tooltip" title='<%# Eval("numcorrect") + " / " + Eval("numpicked") %>'>Accuracy</h3>
                        </div>
                    </div>                
                   <div class="col-sm-5">
                        <span>Return: </span>
                       <%# picks.GetROIIcon((Convert.ToDouble(Eval("totalpayout")) / Convert.ToDouble(Eval("totalwagered")) - 1)) %>
                        <asp:Label ID="LabelOverallReturn" runat="server" data-toggle="tooltip" title='<%# Eval("totalpayout","{0:c2}") %>' Text='<%# (Convert.ToDouble(Eval("totalpayout")) / Convert.ToDouble(Eval("totalwagered")) - 1).ToString("P2") %>' />
                    </div>
                    
                </div>
                </div>
           </ItemTemplate>
       </asp:Repeater>

<div class="row">
    <br /><br /><br />
    <asp:UpdatePanel ID="UPPickHistory" runat="server">
        <ContentTemplate>


<div class="panel panel-default">
    <div class="panel-heading">Full Pick History</div>
    <asp:GridView ID="GVFullPick" DataSourceID="SqlDataSourcePicks" runat="server" GridLines="None" CssClass="table table-hover table-condensed" 
        HeaderStyle-CssClass="active" PagerStyle-CssClass="pgr" PageSize="20" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id">

        <Columns>             
                <asp:TemplateField HeaderText="Race">
                    <ItemTemplate>
                        <%#  Eval("rdate","{0:d}")  + ": " + Eval("abbrev") + " #" + Eval("rnum") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Horse">
                    <ItemTemplate>
                        <div style="max-width:25px;" class='<%# "blanket horse" + races.GetSaddleClothNumber(Eval("program").ToString()) %>'>
                            <asp:Label ID="LabelProgram" runat="server" Text='<%# Eval("program") %>'  Width="22px" ToolTip='<%# "Program Number: " + Eval("program") + " / Post Number: " + Eval("post") %>' />
                        </div>  
                        <span data-poload='<%# "../tooltips/edetails.aspx?eid=" + Eval("id") %>' data-placement="right" id='<%# "ed" + Eval("id") %>' data-original-title="Entry Details:" style="text-decoration:none;">
                            <asp:Label ID="LabelHorse" runat="server" Text='<%# System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(Eval("name").ToString().ToLower()) %>' CssClass="text-success" Font-Strikeout='<%# Eval("scratched") %>'  />
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="description" HeaderText="Wager Type" SortExpression="description" />                               
                <asp:BoundField DataField="morningline" HeaderText="M/L" SortExpression="morningline" />                
                <asp:TemplateField HeaderText="Payout">
                    <ItemTemplate>
                        <asp:Label ID="LabelPending" runat="server" Visible='<%# !Convert.ToBoolean(Eval("processed")) %>' Text="Pending" />
                        <asp:Label ID="LabelPayout" runat="server" Visible='<%# Convert.ToBoolean(Eval("processed")) %>' Text='<%# Convert.ToDouble(Eval("payout")) > 0 ? Eval("payout","{0:c2}") : "-" %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ccrank" HeaderText="CC Rank" SortExpression="ccrank" />   
        </Columns>
<HeaderStyle CssClass="active"></HeaderStyle>

<PagerStyle CssClass="pgr"></PagerStyle>

    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSourcePicks" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
            SelectCommand="SELECT pick_types.description, picks.processed, picks.payout, tracks.abbrev, races.rdate, races.rnum, entries.id, entries.name, entries.program, entries.post, entries.morningline, entries.scratched, entries.ccrank, entries.ccpoints, entries.ccscore, entries.livelongshot FROM picks INNER JOIN pick_types ON picks.pick_type = pick_types.id INNER JOIN entries ON picks.entryid = entries.id INNER JOIN races ON entries.raceid = races.id INNER JOIN tourn_entry ON picks.tourn_entry = tourn_entry.id INNER JOIN tracks ON races.track = tracks.id WHERE picks.userid = @userid AND picks.processed = 'True' ORDER BY entries.id DESC">
            <SelectParameters>
                <asp:SessionParameter Name="userid" SessionField="userid" />
            </SelectParameters>
        </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceUserStats" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
            SelectCommand="SELECT SUM(CASE WHEN payout > 0 THEN 1 ELSE 0 END) as numcorrect, COUNT(picks.id) as numpicked, SUM(payout) as totalpayout, SUM(CASE WHEN pick_type = 1 THEN 4 ELSE 2 END) as totalwagered FROM picks INNER JOIN pick_types ON picks.pick_type = pick_types.id INNER JOIN entries ON picks.entryid = entries.id INNER JOIN races ON entries.raceid = races.id INNER JOIN tourn_entry ON picks.tourn_entry = tourn_entry.id INNER JOIN tracks ON races.track = tracks.id WHERE picks.userid = @userid AND picks.processed = 'True'">
            <SelectParameters>
                <asp:SessionParameter Name="userid" SessionField="userid" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceUserStats_GRP" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
            SelectCommand="SELECT abbrev, SUM(CASE WHEN payout > 0 THEN 1 ELSE 0 END) as numcorrect, COUNT(picks.id) as numpicked, SUM(payout) as totalpayout, SUM(CASE WHEN pick_type = 1 THEN 4 ELSE 2 END) as totalwagered FROM picks INNER JOIN pick_types ON picks.pick_type = pick_types.id INNER JOIN entries ON picks.entryid = entries.id INNER JOIN races ON entries.raceid = races.id INNER JOIN tourn_entry ON picks.tourn_entry = tourn_entry.id INNER JOIN tracks ON races.track = tracks.id WHERE picks.userid = @userid AND picks.processed = 'True' GROUP BY tracks.abbrev">
            <SelectParameters>
                <asp:SessionParameter Name="userid" SessionField="userid" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlDataSourceUserStatsL30" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
            SelectCommand="SELECT SUM(CASE WHEN payout > 0 THEN 1 ELSE 0 END) as numcorrect, COUNT(picks.id) as numpicked, ISNULL(SUM(payout),0) as totalpayout, ISNULL(SUM(CASE WHEN pick_type = 1 THEN 4 ELSE 2 END),0) as totalwagered FROM picks INNER JOIN pick_types ON picks.pick_type = pick_types.id INNER JOIN entries ON picks.entryid = entries.id INNER JOIN races ON entries.raceid = races.id INNER JOIN tourn_entry ON picks.tourn_entry = tourn_entry.id INNER JOIN tracks ON races.track = tracks.id WHERE picks.userid = @userid AND picks.processed = 'True' AND races.rdate >= DATEADD(day,-30,GETDATE()) ">
            <SelectParameters>
                <asp:SessionParameter Name="userid" SessionField="userid" />
            </SelectParameters>
        </asp:SqlDataSource>

</div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>