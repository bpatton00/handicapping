<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="selections.aspx.cs" Inherits="Capping.myaccount.selections" %>

<%@ Register Src="~/ascx/myselections.ascx" TagPrefix="uc1" TagName="myselections" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Admin" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderLeft" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
    <div class="panel panel-primary">
    <div class="panel-heading panel-title">My Selections</div>
    <div class="">
        <asp:GridView ID="GVTournamentSelections" runat="server" AutoGenerateColumns="False" GridLines="None" HeaderStyle-CssClass="active" CssClass="table alumnbg table-condensed table-hover" PagerStyle-CssClass="pgr" DataSourceID="SqlDataSourceSelections">
            <Columns>                
                <asp:TemplateField HeaderText="Horse">
                    <ItemTemplate>
                        <div style="max-width:25px;" class='<%# "blanket horse" + races.GetSaddleClothNumber(Eval("program").ToString()) %>'>
                            <asp:Label ID="LabelProgram" runat="server" Text='<%# Eval("program") %>'  Width="22px" ToolTip='<%# "Program Number: " + Eval("program") + " / Post Number: " + Eval("post") %>' />
                        </div>  
                        <span data-poload='<%# "../tooltips/edetails.aspx?eid=" + Eval("id") %>' data-placement="right" id='<%# "ed" + Eval("id") %>' data-original-title="Entry Details:" style="text-decoration:none;">
                            <asp:Label ID="LabelHorse" runat="server" Text='<%# System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(Eval("name").ToString().ToLower()) %>' CssClass="text-success" Font-Strikeout='<%# Eval("scratched") %>'  />
                        </span>
                        <br />
                        <div class="">
                            <%# Eval("abbrev") + " #" + Eval("rnum") + " <sub>(" + Convert.ToInt32(Eval("purse").ToString().Trim()).ToString("c0") + ")</sub>"%>
                        </div>
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
    SelectCommand="SELECT pick_types.description, picks.processed, picks.payout, races.rnum, entries.id, entries.name, entries.program, entries.post, entries.morningline, entries.scratched, entries.ccrank, entries.ccpoints, entries.ccscore, entries.livelongshot, tracks.abbrev, races.rdate, races.rtime, races.purse FROM picks INNER JOIN pick_types ON picks.pick_type = pick_types.id INNER JOIN entries ON picks.entryid = entries.id INNER JOIN races ON entries.raceid = races.id INNER JOIN tourn_entry ON picks.tourn_entry = tourn_entry.id INNER JOIN tracks ON races.track = tracks.id WHERE ropen = 'True' AND picks.userid = @userid ORDER BY races.rdate, abbrev, rnum ASC">
    <SelectParameters>        
        <asp:SessionParameter Name="userid" SessionField="userid" />
    </SelectParameters>

</asp:SqlDataSource>
</asp:Content>
