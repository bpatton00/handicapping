<%@ Page Language="C#" AutoEventWireup="true" Inherits="tooltips_race_addtnl_details" Codebehind="race_addtnl_details.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="font-size:.8em;">
        <asp:FormView ID="FVAddtnlRaceDetails" runat="server" DataSourceID="SqlDataSourceAddtnlRaceDetails" CssClass="custtable" RowStyle-HorizontalAlign="Left">
            <ItemTemplate>     
                <div  style="width:286px;">
                1. <asp:Label ID="complinehoLabel" runat="server" Text='<%# Bind("complineho") %>' />
                <sup><asp:Label ID="LabelFinL" runat="server" Text='<%# Math.Round(Convert.ToDouble(Eval("complinele")) / 100, 2) %>' /></sup>                
                <br />
                2. <asp:Label ID="complineh2Label" runat="server" Text='<%# Bind("complineh2") %>' />
                <sup><asp:Label ID="Label1" runat="server" Text='<%# Math.Round(Convert.ToDouble(Eval("complinel2")) / 100, 2) %>' /></sup>                
                <br />
                3. <asp:Label ID="complineh3Label" runat="server" Text='<%# Bind("complineh3") %>' />
                <sup><asp:Label ID="Label2" runat="server" Text='<%# Math.Round(Convert.ToDouble(Eval("complinel3")) / 100, 2) %>' /></sup>                
                <br /><br />
                Class Rating:
                <asp:Label ID="classratinLabel" runat="server" Text='<%# Bind("classratin") %>' />
                </div>
            </ItemTemplate>
        
        </asp:FormView>
        <asp:SqlDataSource ID="SqlDataSourceAddtnlRaceDetails" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
            SelectCommand="SELECT [complineho], [complinele], [complineh2], [complinel2], [complineh3], [complinel3], [classratin], [horsetimef] FROM [pp] WHERE ([id] = @id)">
            <SelectParameters>
                <asp:QueryStringParameter Name="id" QueryStringField="ppid" Type="Int64" />
            </SelectParameters>
        </asp:SqlDataSource>

    </div>
    </form>
</body>
</html>
