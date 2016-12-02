<%@ Page Language="C#" AutoEventWireup="true" Inherits="tooltips_cc_score" Codebehind="cc_score.aspx.cs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <!--Ranks and Scores by raceid-->
    <div style="font-size:.8em;width:250px">
        <asp:GridView ID="GVDetails" runat="server" DataSourceID="SqlDataSourceRDetails" CssClass="table table-condensed" GridLines="None" AutoGenerateColumns="False">
            <Columns>                
                <asp:TemplateField HeaderText="Horse">
                    <ItemTemplate>
                        <div style="text-align:center;text-shadow:none;margin-right:10px;" class='<%# "blanket blanket_s horse" + races.GetSaddleClothNumber(Eval("program").ToString()) %>'>
                            <asp:Label ID="LabelProgram" runat="server" Text='<%# Eval("program") %>' ToolTip='<%# "Program Number: " + Eval("program") + " / Post Number: " + Eval("post") %>' />
                        </div>
                        <asp:Label ID="LabelHorse" runat="server" Text='<%# Eval("name") %>' />
                    </ItemTemplate>                    
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Score">
                    <ItemTemplate>
                        <asp:Label ID="LabelScore" runat="server" Text='<%# Eval("ccscore","{0:p0}") + " <i>[" + Eval("ccpoints") + "]</i>" %>' />
                        <i class="fa fa-plus" runat="server" visible='<%# Convert.ToBoolean(Eval("livelongshot")) %>'></i>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>    

        </asp:GridView>
    </div>
        <asp:SqlDataSource ID="SqlDataSourceRDetails" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
            SelectCommand="SELECT program, post, name, ccrank, ccscore, ccpoints, livelongshot FROM [entries] WHERE ([raceid] = @raceid) AND ccrank > 0 ORDER BY ccrank ">
            <SelectParameters>
                <asp:QueryStringParameter Name="raceid" QueryStringField="raceid" Type="Int64" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
