<%@ Page Language="C#" AutoEventWireup="true" Inherits="tooltips_workouts" Codebehind="workouts.aspx.cs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
</head>
<body>
    <form id="form1" runat="server">
    <!--Workout Data by entryid-->
        <div style="font-size:.8em;">
        <asp:GridView ID="GVDetails" runat="server" GridLines="None" DataSourceID="SqlDataSourceWDetails" CssClass="table table-condensed" ShowHeader="false" AutoGenerateColumns="False">
            <Columns>                
                <asp:TemplateField >
                    <ItemTemplate>
                            <asp:Label ID="LabelDate" runat="server" Text='<%# Eval("wdate","{0:dMMMyy}") %>'  />
                    </ItemTemplate>                    
                </asp:TemplateField>
                <asp:TemplateField >
                    <ItemTemplate>
                            <asp:Label ID="LabelDist" runat="server" Text='<%# Eval("dist") + "f" %>'  />
                    </ItemTemplate>                    
                </asp:TemplateField>
                <asp:TemplateField >
                    <ItemTemplate>
                            <asp:Label ID="LabelSurf" runat="server" Text='<%# Eval("surf").ToString().Trim() == "T" ? "&#9417;" : "" %>' />
                            <!--all weather symbol-->
                    </ItemTemplate>                    
                </asp:TemplateField>
                <asp:TemplateField >
                    <ItemTemplate>
                            <asp:Label ID="LabelTCond" runat="server" Text='<%# Eval("trackcond") %>'  />
                    </ItemTemplate>                    
                </asp:TemplateField>
                <asp:TemplateField >
                    <ItemTemplate>
                            <asp:Label ID="LabelTrack" runat="server" Text='<%# Eval("trackabbv") %>'  />
                    </ItemTemplate>                    
                </asp:TemplateField>
                <asp:TemplateField >
                    <ItemTemplate>
                            <asp:Label ID="LabelTime" runat="server" Text='<%# Eval("wtime") + " " %>'  />
                            <asp:Label ID="LabelType" runat="server" Font-Size="XX-Small" Text='<%# Eval("wtype") %>' />
                    </ItemTemplate>                    
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-HorizontalAlign="Right" >
                    <ItemTemplate>
                            <asp:Label ID="LabelBullet" runat="server"  Visible='<%# Convert.ToBoolean(Convert.ToInt16(Eval("wrank")) == 1) %>' Font-Size="Larger" >&#149;</asp:Label>
                            <asp:Label ID="LabelRank" runat="server" Text='<%# Eval("wrank") + "/" + Eval("wgroup") %>'  />
                        
                    </ItemTemplate>                    
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceWDetails" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
            SelectCommand="SELECT * FROM [works] WHERE ([entryid] = @entryid) ORDER BY wnum ">
            <SelectParameters>
                <asp:QueryStringParameter Name="entryid" QueryStringField="entryid" Type="Int64" />
            </SelectParameters>
        </asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
