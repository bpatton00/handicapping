<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="admin_rankings" Codebehind="rankings.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderLeft" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">

    <asp:DropDownList ID="DDLRaces" runat="server" DataSourceID="SqlDataSourceRaces" DataTextField="combineddesc" DataValueField="id" AutoPostBack="true" >

    </asp:DropDownList>
    <asp:Button ID="ButtonRunRankings" runat="server" Text="Run Rankings" CssClass="btn btn-default" OnClick="ButtonRunRankings_Click" />
    <asp:Button ID="Button1" runat="server" Text="Process Exotics" CssClass="btn btn-default" OnClick="ButtonRunRankings_Click" />
    
    <asp:SqlDataSource ID="SqlDataSourceRaces" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>"
        SelectCommand="SELECT races.id, rdesc, rdate, rtime, tracks.name, name + '[' + rdesc + ']' + ' ' + LEFT(CONVERT(VARCHAR, rdate, 120), 10) as combineddesc FROM races INNER JOIN tracks ON tracks.id = races.track ORDER BY rdate DESC " >

    </asp:SqlDataSource>
    <asp:Label ID="LabelResponse" runat="server" />

    <asp:GridView ID="GVRankings" runat="server" DataSourceID="SqlDataSourceHorses" AutoGenerateColumns="False" CssClass="responstable" >
        <Columns>
            <asp:BoundField DataField="ccrank" HeaderText="Rank" SortExpression="ccrank" />
            <asp:BoundField DataField="name" HeaderText="Horse" SortExpression="name" />
            <asp:BoundField DataField="ccscore" HeaderText="Score" SortExpression="ccscore" />
            <asp:BoundField DataField="ccpoints" HeaderText="Points" SortExpression="ccpoints" />
            <asp:BoundField DataField="morningline" HeaderText="Morning Line" SortExpression="morningline" />                        
            <asp:CheckBoxField DataField="livelongshot" HeaderText="Live Longshot" SortExpression="livelongshot" />
        </Columns>


    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceHorses" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>"
        SelectCommand="SELECT entries.name, entries.morningline, entries.ccrank, entries.ccscore, entries.ccpoints, entries.livelongshot FROM entries WHERE raceid = @raceid ORDER BY ccrank " >
        <SelectParameters>
            <asp:ControlParameter Name="raceid" ControlID="DDLRaces" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <br />
    <br />
    <div class="col-xs-12 col-md-6">
    <div class="input-group">
        <div class="input-group-addon">Start</div>
        <asp:TextBox ID="TBSTart" runat="server" CssClass="form-control" ></asp:TextBox>    
    </div>
    <div class="input-group">
        <div class="input-group-addon">End</div>
        <asp:TextBox ID="TBEnd" runat="server" CssClass="form-control" ></asp:TextBox>
    </div>
    <asp:Button ID="ButtonRunALLRankings" runat="server" Text="Run Rankings for Selected Races" CssClass="btn btn-danger" OnClick="ButtonRunALLRankings_CLick" />
    </div>

</asp:Content>

