<%@ Page Language="C#" AutoEventWireup="true" Inherits="tooltips_jockey" Codebehind="jockey.aspx.cs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="font-size:.8em;">
        <asp:FormView ID="FVJock" runat="server" DataSourceID="SqlDataSourceJDetails" Caption="Jockey Data" RenderOuterTable="false">
            <ItemTemplate>
                    <table class="table table-condensed">
                    <tr><th></th><th>%</th><th>Record<th>ROI</th></tr>
                    <tr><th style="text-align:left;">L30</th><td style="text-align:right;"><%# (Convert.ToDouble(Eval("jockey_30_wins")) / Convert.ToDouble(Eval("jockey_30_starts"))).ToString("p0")%></td><td style="text-align:right;"><%# Eval("jockey_30_starts") + ": " + Eval("jockey_30_wins") + "-" + Eval("jockey_30_places") + "-" + Eval("jockey_30_shows") %></td><td style="text-align:right;"> <%# Eval("jockey_30_roi") %>% </td></tr>
                    <tr><th style="text-align:left;">J&T</th><td style="text-align:right;"><%# (Convert.ToDouble(Eval("JOCK_TRAN_wins")) / Convert.ToDouble(Eval("JOCK_TRAN_starts"))).ToString("p0")%></td><td style="text-align:right;"><%# Eval("JOCK_TRAN_starts") + ": " + Eval("JOCK_TRAN_wins") + "-" + Eval("JOCK_TRAN_places") + "-" + Eval("JOCK_TRAN_shows") %></td><td style="text-align:right;"> <%# Eval("JOCK_TRAN_roi") %>% </td></tr>
                    </table>
            </ItemTemplate>
        </asp:FormView>
    </div>
        <asp:SqlDataSource ID="SqlDataSourceJDetails" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
            SelectCommand="SELECT [jockey_30_starts], [jockey_30_wins], [jockey_30_places], [jockey_30_shows], [jockey_30_roi], [jockey], JOCK_TRAN_starts, JOCK_TRAN_wins, JOCK_TRAN_places, JOCK_TRAN_shows, JOCK_TRAN_roi, JOCK_TRAN_earnings FROM [entries] WHERE ([id] = @id)">
            <SelectParameters>
                <asp:QueryStringParameter Name="id" QueryStringField="eid" Type="Int64" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
