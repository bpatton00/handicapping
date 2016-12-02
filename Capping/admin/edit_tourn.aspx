<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="admin_edit_tourn" Codebehind="edit_tourn.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <div id="tourn-editor" class="row row-tabs" role="tabpanel">
        <div class="col-xs-12">
            <div id="tabs-v1" class="tabs-top tabs-justified-top"> 
                <ul class="nav nav-tabs nav-justified" role="tablist">
                    <li class="active"><a href="#tournamentstatus" role="tab" aria-controls="tournamentstatus" data-toggle="tab">Tournament Status</a></li>
                    <li><a href="#edittourn" role="tab" aria-controls="edittourn" data-toggle="tab">Edit Tournaments</a></li>
                </ul>
                <div class="tab-content">
                    <div id="tournamentstatus" class="tab-pane active">
                        <h2>Currently Open Tournaments</h2>
                        <asp:GridView ID="GVOpenTourns" runat="server" GridLines="None" CssClass="table table-hover table-condensed" HeaderStyle-CssClass="active" PagerStyle-CssClass="pgr"
                            DataSourceID="SqlDataSourceTourns" AutoGenerateColumns="False" DataKeyNames="id">

                            <Columns>
                                <asp:BoundField DataField="name" HeaderText="Tournament" SortExpression="name" />
                                <asp:BoundField DataField="prize" HeaderText="Prize" SortExpression="prize" DataFormatString="{0:c0}" />
                                <asp:BoundField DataField="tdate" HeaderText="Date" SortExpression="tdate" DataFormatString="{0:d}" />
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="ButtonClose" runat="server" Text="Close" CssClass="btn btn-danger" CommandArgument='<%# Eval("id") %>' CommandName="Close" OnClick="ButtonClose_Click" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
<HeaderStyle CssClass="active"></HeaderStyle>

<PagerStyle CssClass="pgr"></PagerStyle>

                        </asp:GridView>
  
                    </div>


                    <div id="edittourn" class="tab-pane ">
                        <h2>Edit Tournament</h2>        
                        <asp:UpdatePanel ID="UPEdit" runat="server">
                            <ContentTemplate>

                            
     <h3>Choose Tournament</h3>
    <asp:DropDownList ID="DropDownListTourns" runat="server" DataSourceID="SqlDataSourceTourns" AutoPostBack="true" 
    DataTextField="name" DataValueField="id" CssClass="form-control"></asp:DropDownList>




    <h3>Select Races to Include in Tournament</h3>
    <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSourceSelected" AutoGenerateColumns="False" 
    DataKeyNames="id" CssClass="table table-condensed table-hover" GridLines="None" PagerStyle-CssClass="pgr" HeaderStyle-CssClass="active">
        <Columns>
            <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
            <asp:BoundField DataField="remoteid" HeaderText="remoteid" SortExpression="remoteid" />
            <asp:BoundField DataField="rdesc" HeaderText="Race" SortExpression="rdesc" />
            <asp:BoundField DataField="rdate" HeaderText="Date" SortExpression="rdate" DataFormatString="{0:d}" />
            <asp:BoundField DataField="rtime" HeaderText="Post Time" SortExpression="rtime" DataFormatString="{0:t}" />
            <asp:BoundField DataField="track" HeaderText="Track" SortExpression="track" />
            <asp:BoundField DataField="distance" HeaderText="Distance" SortExpression="distance" />
            <asp:BoundField DataField="surface" HeaderText="Surface" SortExpression="surface" />
            <asp:BoundField DataField="purse" HeaderText="purse" SortExpression="purse" />
            <asp:BoundField DataField="rtype" HeaderText="Type" SortExpression="rtype" />
            <asp:BoundField DataField="rnum" HeaderText="RNum" SortExpression="rnum" />
            <asp:CheckBoxField DataField="ropen" HeaderText="Open" SortExpression="ropen" />
        </Columns>
    </asp:GridView>


    <h4>Races Currently Selected</h4>

    <h4>Available Races</h4>
    <asp:DropDownList ID="DDLTrack" runat="server" DataSourceID="SqlDataSourceTracks" AutoPostBack="true" 
        DataTextField="abbrev" DataValueField="track" CssClass="form-control"></asp:DropDownList>

    <asp:SqlDataSource ID="SqlDataSourceTracks" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT DISTINCT(track), abbrev FROM [races] INNER JOIN tracks on tracks.id = races.track WHERE ([ropen] = @ropen) ORDER BY track">
        <SelectParameters>
            <asp:Parameter DefaultValue="True" Name="ropen" Type="Boolean" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridViewRaces" runat="server" DataSourceID="SqlDataSourceAvail" AutoGenerateColumns="False" 
    DataKeyNames="id" CssClass="table table-condensed table-hover" GridLines="None" PagerStyle-CssClass="pgr" HeaderStyle-CssClass="active">
        <Columns>
            <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" />
            <asp:BoundField DataField="remoteid" HeaderText="remoteid" SortExpression="remoteid" />
            <asp:BoundField DataField="rdesc" HeaderText="Race" SortExpression="rdesc" />
            <asp:BoundField DataField="rdate" HeaderText="Date" SortExpression="rdate" DataFormatString="{0:d}" />
            <asp:BoundField DataField="rtime" HeaderText="Post Time" SortExpression="rtime" DataFormatString="{0:t}" />
            <asp:BoundField DataField="track" HeaderText="Track" SortExpression="track" />
            <asp:BoundField DataField="distance" HeaderText="Distance" SortExpression="distance" />
            <asp:BoundField DataField="surface" HeaderText="Surface" SortExpression="surface" />
            <asp:BoundField DataField="purse" HeaderText="purse" SortExpression="purse" />
            <asp:BoundField DataField="rtype" HeaderText="Type" SortExpression="rtype" />
            <asp:BoundField DataField="rnum" HeaderText="RNum" SortExpression="rnum" />
            <asp:CheckBoxField DataField="ropen" HeaderText="Open" SortExpression="ropen" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSourceAvail" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT * FROM [races] WHERE ([ropen] = @ropen) AND (track = @track) ORDER BY rdate, rnum">
        <SelectParameters>
            <asp:Parameter DefaultValue="True" Name="ropen" Type="Boolean" />
            <asp:ControlParameter Name="Track" ControlID="DDLTrack" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceSelected" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT * FROM [races] INNER JOIN racesintourn ON racesintourn.raceid = races.id WHERE racesintourn.tournid = @tournid  ORDER BY rdate, rnum">
        <SelectParameters>
            <asp:ControlParameter  Name="tournid" ControlID="DropDownListTourns" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
                                </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </div>

        <asp:SqlDataSource ID="SqlDataSourceTourns" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" SelectCommand="SELECT * FROM [tournaments] WHERE ([finished] = @finished) ORDER BY [tdate]">
        <SelectParameters>
            <asp:Parameter DefaultValue="False" Name="finished" Type="Boolean" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

