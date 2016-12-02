<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="myselections.ascx.cs" Inherits="Capping.ascx.myselections" %>
<div class="panel panel-primary">
    <div class="panel-heading panel-title">My Selections</div>
    <div class="">
        <asp:GridView ID="GVTournamentSelections" runat="server" AutoGenerateColumns="False" GridLines="None" HeaderStyle-CssClass="active" CssClass="table alumnbg table-condensed table-hover" PagerStyle-CssClass="pgr" DataSourceID="SqlDataSourceSelections">
            <Columns>
                <asp:BoundField HeaderText="Race" DataField="rnum" />
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
                        <asp:Label ID="LabelPayout" runat="server" Visible='<%# Convert.ToBoolean(Eval("processed")) %>' Text='<%# Eval("payout","{0:c2}") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ccrank" HeaderText="CC Rank" SortExpression="ccrank" />                                

            </Columns>

<PagerStyle CssClass="pgr"></PagerStyle>

        </asp:GridView>

    </div>
</div>

<asp:SqlDataSource ID="SqlDataSourceSelections" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
    SelectCommand="SELECT pick_types.description, picks.processed, picks.payout, races.rnum, entries.id, entries.name, entries.program, entries.post, entries.morningline, entries.scratched, entries.ccrank, entries.ccpoints, entries.ccscore, entries.livelongshot FROM picks INNER JOIN pick_types ON picks.pick_type = pick_types.id INNER JOIN entries ON picks.entryid = entries.id INNER JOIN races ON entries.raceid = races.id INNER JOIN tourn_entry ON picks.tourn_entry = tourn_entry.id WHERE tourn_entry.tournid = @tournid AND picks.userid = @userid ORDER BY rnum ASC">
    <SelectParameters>
        <asp:Parameter Name="tournid" Type="Int64" />
        <asp:SessionParameter Name="userid" SessionField="userid" />
    </SelectParameters>

</asp:SqlDataSource>

