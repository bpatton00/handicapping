<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="test_p5maker" Codebehind="p5maker.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Admin" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderLeft" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" Runat="Server">


        <div class="title-md hr-before">Handicappers Friend</div>
        <asp:UpdatePanel ID="UP_Selectors" runat="server" >
            <ContentTemplate>

            
                <div class="input-group">
                    <span class="input-group-addon">Track</span>
                    <asp:DropDownList ID="DDLTrack" runat="server" CssClass="form-control" DataSourceID="SqlDataSourceTracks"  AutoPostBack="true" 
                        DataTextField="abbrev" DataValueField="track">
                    </asp:DropDownList>
                </div>
            
                <div class="input-group">
                    <span class="input-group-addon">Date</span>
                    <asp:DropDownList ID="DDLDate" runat="server" CssClass="form-control" DataSourceID="SqlDataSourceDates" DataTextField="rdate" DataValueField="rdate" AutoPostBack="true">
                    </asp:DropDownList>
                </div>
            
                <div class="input-group">
                    <span class="input-group-addon">Starting Race </span>
                    <asp:DropDownList ID="DDLBegRace" runat="server" CssClass="form-control" DataSourceID="SqlDataSourceRaces" DataTextField="rnum" DataValueField="rnum" AutoPostBack="true">
                    </asp:DropDownList>
                </div>

                <div class="input-group">
                    <span class="input-group-addon">Ending Race</span>
                    <asp:DropDownList ID="DDLEndRace" runat="server" CssClass="form-control" DataSourceID="SqlDataSourceRaces" DataTextField="rnum" DataValueField="rnum" AutoPostBack="true">
                    </asp:DropDownList>
                </div>

                <div class="input-group">
                    <span class="input-group-addon">Wager Amount</span>
                    <asp:DropDownList ID="DDLAmount" runat="server" CssClass="form-control" AutoPostBack="true">
                        <asp:ListItem Text="$.25" Value=".25" />
                        <asp:ListItem Text="$.5" Value=".5" />
                        <asp:ListItem Selected="True" Text="$1" Value="1" />
                        <asp:ListItem Text="$2" Value="2" />
                        <asp:ListItem Text="$5" Value="5" />
                        <asp:ListItem Text="$10" Value="10" />
                    </asp:DropDownList>
                </div>

                <div class="input-group">
                    <span class="input-group-addon">Ticket Price</span>
                    <asp:DropDownList ID="DDLTargetPrice" runat="server" CssClass="form-control" AutoPostBack="true">
                        <asp:ListItem Text="$10" Value="10" />
                        <asp:ListItem Text="$20" Value="20" />
                        <asp:ListItem Selected="True" Text="$50" Value="50" />
                        <asp:ListItem Text="$75" Value="75" />
                        <asp:ListItem Text="$100" Value="100" />
                        <asp:ListItem Text="$250" Value="250" />
                    </asp:DropDownList>
                </div>
                <br />
                <asp:Button ID="ButtonMakePicks" runat="server" Text="Make Picks" CssClass="btn btn-default" OnClick="ButtonMakePicks_Click" />
                <br /><br />

                <div class="col-xs-12">
                <asp:Literal ID="LiteralPicks" runat="server" ></asp:Literal>
                </div>
                <div class="col-xs-12">
                <asp:Literal ID="LiteralAlerts" runat="server" ></asp:Literal>
                </div>
    
        

    <asp:SqlDataSource ID="SqlDataSourceTracks" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT DISTINCT(track), abbrev FROM [races] INNER JOIN tracks on tracks.id = races.track WHERE ([ropen] = 'True') ORDER BY abbrev">        
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDates" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT DISTINCT(rdate) FROM [races] INNER JOIN tracks on tracks.id = races.track WHERE track = @track ORDER BY rdate DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLTrack" Name="track"  />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceRaces" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT DISTINCT (rnum) FROM entries INNER JOIN races on entries.raceid = races.id WHERE track = @track AND rdate = @rdate ORDER BY rnum">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLTrack" PropertyName="SelectedValue" Name="track"  />
            <asp:ControlParameter ControlID="DDLDate"  PropertyName="SelectedValue" Name="rdate"  />
        </SelectParameters>
    </asp:SqlDataSource>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

