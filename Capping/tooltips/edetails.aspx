<%@ Page Language="C#" AutoEventWireup="true" Inherits="tooltips_edetails" Codebehind="edetails.aspx.cs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
     <form id="form1" runat="server">
     <div style="font-size:.8em;">
        <asp:FormView ID="FVHorseDetails" runat="server" DataSourceID="SqlDataSourceEDetails" Caption="Additional Data" RenderOuterTable="false">
            <ItemTemplate>
                <table class="table table-condensed">
                    <tr><th style="text-align:left;">LIFE</th><td style="text-align:right;"><%# Eval("LIFE_starts")%></td><td style="text-align:right;"> <%# Eval("LIFE_wins") %></td><td style="text-align:right;"> <%# Eval("LIFE_places") %></td><td style="text-align:right;"> <%# Eval("LIFE_shows") %></td><td style="text-align:right;"> <%# shared.FormatNumber(Convert.ToInt32(Convert.ToDouble(Eval("LIFE_earnings")))) %> </td></tr>
                    <tr><th style="text-align:left;"><%# DateTime.Now.Year %></th><td style="text-align:right;"><%# Eval("TY_starts")%></td><td style="text-align:right;"> <%# Eval("TY_wins") %></td><td style="text-align:right;"> <%# Eval("TY_places") %></td><td style="text-align:right;"> <%# Eval("TY_shows") %></td><td style="text-align:right;"> <%# shared.FormatNumber(Convert.ToInt32(Convert.ToDouble(Eval("TY_earnings")))) %> </td></tr>
                    <tr><th style="text-align:left;">DST&SRF</th><td style="text-align:right;"><%# Eval("DST_SRF_starts")%></td><td style="text-align:right;"> <%# Eval("DST_SRF_wins") %></td><td style="text-align:right;"> <%# Eval("DST_SRF_places") %></td><td style="text-align:right;"> <%# Eval("DST_SRF_shows") %></td><td style="text-align:right;"> <%# shared.FormatNumber(Convert.ToInt32(Convert.ToDouble(Eval("DST_SRF_earnings")))) %> </td></tr>
                    <tr><th style="text-align:left;">DST&CRS</th><td style="text-align:right;"><%# Eval("DST_CRS_starts")%></td><td style="text-align:right;"> <%# Eval("DST_CRS_wins") %></td><td style="text-align:right;"> <%# Eval("DST_CRS_places") %></td><td style="text-align:right;"> <%# Eval("DST_CRS_shows") %></td><td style="text-align:right;"> <%# shared.FormatNumber(Convert.ToInt32(Convert.ToDouble(Eval("DST_CRS_earnings")))) %> </td></tr>
                    <tr><th style="text-align:left;">MUD</th><td style="text-align:right;"><%# Eval("MUD_starts")%></td><td style="text-align:right;"> <%# Eval("MUD_wins") %></td><td style="text-align:right;"> <%# Eval("MUD_places") %></td><td style="text-align:right;"> <%# Eval("MUD_shows") %></td><td style="text-align:right;"> <%# shared.FormatNumber(Convert.ToInt32(Convert.ToDouble(Eval("MUD_earnings")))) %> </td></tr>
                    <tr><th style="text-align:left;">TRACK</th><td style="text-align:right;"><%# Eval("AT_TRK_starts")%></td><td style="text-align:right;"> <%# Eval("AT_TRK_wins") %></td><td style="text-align:right;"> <%# Eval("AT_TRK_places") %></td><td style="text-align:right;"> <%# Eval("AT_TRK_shows") %></td><td style="text-align:right;"> <%# shared.FormatNumber(Convert.ToInt32(Convert.ToDouble(Eval("AT_TRK_earnings")))) %> </td></tr>
                </table>
            </ItemTemplate>                
        </asp:FormView>
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="id" 
            DataSourceID="SqlDataSourceEDetails" CssClass="table table-condensed" GridLines="None">
            <Fields>
                <asp:BoundField DataField="name" HeaderText="Horse" SortExpression="name" Visible="false" />
                <asp:BoundField DataField="horsesex" HeaderText="Sex" SortExpression="horsesex" />
                <asp:BoundField DataField="med" HeaderText="Med" SortExpression="med" />
                <asp:BoundField DataField="equip" HeaderText="Equip" SortExpression="equip" />
                <asp:BoundField DataField="claimprice" HeaderText="Claim Price" SortExpression="claimprice" DataFormatString="{0:c0}" />
                <asp:BoundField DataField="jockey" HeaderText="Jockey" SortExpression="jockey" Visible="false" />
                <asp:BoundField DataField="trainer" HeaderText="Trainer" SortExpression="trainer" Visible="false" />
                <asp:BoundField DataField="owner" HeaderText="Owner" SortExpression="owner" Visible="false" />
                <asp:BoundField DataField="sirename" HeaderText="Sire" SortExpression="sirename" Visible="false" />                
                <asp:BoundField DataField="damname" HeaderText="Dam" SortExpression="damname" Visible="false" />                
                <asp:BoundField DataField="studfee" HeaderText="Stud Fee" SortExpression="studfee" DataFormatString="{0:c0}" />
                <asp:BoundField DataField="color" HeaderText="Color" SortExpression="color" />
            </Fields>
        </asp:DetailsView>
  
    </div>
        <asp:SqlDataSource ID="SqlDataSourceEDetails" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
            SelectCommand="SELECT * FROM [entries] WHERE ([id] = @id)">
            <SelectParameters>
                <asp:QueryStringParameter Name="id" QueryStringField="eid" Type="Int64" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
