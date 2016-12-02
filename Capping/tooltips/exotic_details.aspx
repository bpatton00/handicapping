<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="exotic_details.aspx.cs" Inherits="Capping.tooltips.exotic_details" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
        <asp:GridView ID="GVExotics" runat="server" DataSourceID="SqlDataSourceExotics" GridLines="None" HeaderStyle-CssClass="active" CssClass="table table-condensed" AutoGenerateColumns="false" EmptyDataText="No Winning Tickets Found" >
            <Columns>
                <asp:BoundField HeaderText="Date" DataField="rdate" DataFormatString="{0:d}" />
                <asp:BoundField HeaderText="Track" DataField="abbrev" />
                <asp:BoundField HeaderText="Race" DataField="rnum" />
                <asp:BoundField HeaderText="Description" DataField="rtype" />
                <asp:TemplateField HeaderText="Purse">
                    <ItemTemplate>
                        <%# shared.FormatNumber(Convert.ToInt32(Eval("purse"))) %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Payout" DataField="payout" DataFormatString="{0:c}" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceExotics" runat="server"  ConnectionString="<%$ ConnectionStrings:WageringConn %>" >
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
