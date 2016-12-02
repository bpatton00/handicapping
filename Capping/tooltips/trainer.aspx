<%@ Page Language="C#" AutoEventWireup="true" Inherits="tooltips_trainer" Codebehind="trainer.aspx.cs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="font-size:.8em;">
        <asp:FormView ID="FVTrainer" runat="server" DataSourceID="SqlDataSourceTDetails" Caption="Trainer Data" RenderOuterTable="false">
            <ItemTemplate>
                    <table class="table table-condensed">
                    <tr><th></th><th>%</th><th>Record</th><th>ROI</th></tr>
                    <tr><th style="text-align:left;">L30</th><td style="text-align:right;"><%# (Convert.ToDouble(Eval("trainer_30_wins")) / Convert.ToDouble(Eval("trainer_30_starts"))).ToString("p0")%></td><td style="text-align:right;"><%# Eval("trainer_30_starts") + ": " +  Eval("trainer_30_wins") + "-" + Eval("trainer_30_places") + "-" + Eval("trainer_30_shows") %></td><td style="text-align:right;"> <%# Eval("trainer_30_roi") %>% </td></tr>
                    <tr><th style="text-align:left;">J&T</th><td style="text-align:right;"><%# (Convert.ToDouble(Eval("JOCK_TRAN_wins")) / Convert.ToDouble(Eval("JOCK_TRAN_starts"))).ToString("p0")%></td><td style="text-align:right;"><%# Eval("JOCK_TRAN_starts") + ": " + Eval("JOCK_TRAN_wins") + "-" + Eval("JOCK_TRAN_places") + "-" + Eval("JOCK_TRAN_shows") %></td><td style="text-align:right;"> <%# Eval("JOCK_TRAN_roi") %>% </td></tr>
                    </table>
            </ItemTemplate>
        </asp:FormView>
  
    </div>
        <asp:SqlDataSource ID="SqlDataSourceTDetails" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
            SelectCommand="SELECT [trainer], [trainer_30_starts], [trainer_30_wins], [trainer_30_places], [trainer_30_shows], [trainer_30_roi], JOCK_TRAN_starts, JOCK_TRAN_wins, JOCK_TRAN_places, JOCK_TRAN_shows, JOCK_TRAN_roi, JOCK_TRAN_earnings FROM [entries] WHERE id = @id">
            <SelectParameters>
                <asp:QueryStringParameter Name="id" QueryStringField="eid" Type="Int64" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
