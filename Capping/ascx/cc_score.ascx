<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="cc_score.ascx.cs" Inherits="Capping.ascx.cc_score" %>
    <div style="font-size:.8em;"">
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
                <asp:Parameter Name="raceid" Type="Int64" />
            </SelectParameters>
        </asp:SqlDataSource>