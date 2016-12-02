<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="admin_scratch" Codebehind="scratch.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <h3>Scratch Horses</h3>

    <asp:DropDownList ID="DDLTrack" runat="server" DataSourceID="SqlDataSourceTracks"  AutoPostBack="true" 
        DataTextField="abbrev" DataValueField="track">
    </asp:DropDownList>

    <asp:DropDownList ID="DDLDate" runat="server" DataSourceID="SqlDataSourceDates" DataTextField="rdate" DataValueField="rdate" AutoPostBack="true">
    </asp:DropDownList>

    <asp:GridView ID="GVHorses" runat="server" DataSourceID="SqlDataSourceEntries" CssClass="table table-condensed table-hover" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="name" HeaderText="Horse" SortExpression="name" />
            <asp:BoundField DataField="rnum" HeaderText="Race" SortExpression="rnum" />
            <asp:BoundField DataField="program" HeaderText="Program" SortExpression="program" />
            <asp:BoundField DataField="post" HeaderText="Post" SortExpression="post" />            
            <asp:TemplateField HeaderText="Scratched">
                <ItemTemplate>
                    <asp:UpdatePanel ID="UP_Scr" runat="server">
                        <ContentTemplate>
                            <div class="input-group">
                                <asp:Label ID="LabelScratch" runat="server" Text="Scratch" AssociatedControlID="CBScratched" CssClass="form-control"></asp:Label>
                                <asp:CheckBox ID="CBScratched" runat="server" AutoPostBack="true" CssClass="input-group-addon" Checked='<%# Eval("scratched") %>' OnCheckedChanged="AddRemove_CheckedChanged" Handles="AddRemove.CheckedChanged" ClientIDMode="AutoID" />
                                <asp:HiddenField ID="HFID" runat="server" Value='<%# Eval("id") %>' />      
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>


    </asp:GridView>


    <asp:SqlDataSource ID="SqlDataSourceTracks" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT DISTINCT(track), abbrev FROM [races] INNER JOIN tracks on tracks.id = races.track WHERE ([ropen] = 'True') ORDER BY abbrev">        
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDates" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT DISTINCT(rdate) FROM [races] INNER JOIN tracks on tracks.id = races.track WHERE track = @track ORDER BY rdate DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLTrack" Name="track"  />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceEntries" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT name, post, program, scratched, rnum, entries.id FROM entries INNER JOIN races on entries.raceid = races.id WHERE track = @track AND rdate = @rdate ORDER BY rnum">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLTrack" PropertyName="SelectedValue" Name="track"  />
            <asp:ControlParameter ControlID="DDLDate"  PropertyName="SelectedValue" Name="rdate"  />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

