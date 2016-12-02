<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="cceval_bytype.aspx.cs" Inherits="Capping.tools.cceval_bytype" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Admin" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderLeft" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
          <asp:DropDownList ID="DDLRtype" runat="server" AppendDataBoundItems="true" DataSourceID="SqlDataSourceTypes" DataTextField="rtype" DataValueField="rtype" AutoPostBack="true" >
        <asp:ListItem Selected="True" Text="All" Value="All"></asp:ListItem>
    </asp:DropDownList>

    <asp:GridView ID="GridViewReturns" CssClass="table alumnbg table-condensed table-hover" GridLines="None" HeaderStyle-CssClass="active" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceReturns">
        <Columns>
            <asp:BoundField DataField="ccrank" HeaderText="ccrank" SortExpression="ccrank" />
            <asp:TemplateField HeaderText="Strong Win">
                <ItemTemplate>
                    <asp:Label ID="LabelPct" runat="server" Text='<%# Convert.ToInt16(Eval("strongwinners")) > 0 ? (Convert.ToDouble(Eval("strongwinners")) / Convert.ToDouble(Eval("strongraces"))).ToString("p2") : ""  %>'  />
                    <asp:Label ID="LabelWinners" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("strongwinners") + "/" + Eval("strongraces") + "]</i>"%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Strong ITM">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Convert.ToInt16(Eval("strongitm")) > 0 ? (Convert.ToDouble(Eval("strongitm")) / Convert.ToDouble(Eval("strongraces"))).ToString("p2") : ""  %>'  />
                    <asp:Label ID="Label2" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("strongitm") + "/" + Eval("strongraces") + "]</i>"%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Win Rates">
                <ItemTemplate>
                    <asp:Label ID="LabelPct" runat="server" Text='<%# Convert.ToInt16(Eval("winners")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("races"))).ToString("p2") : ""  %>'  />
                    <asp:Label ID="LabelWinners" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("winners") + "/" + Eval("races") + "]</i>"%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ITM">
                <ItemTemplate>
                    <asp:Label ID="LabelPct" runat="server" Text='<%# Convert.ToInt16(Eval("itm")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("races"))).ToString("p2") : ""  %>'  />
                    <asp:Label ID="LabelWinners" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("itm") + "/" + Eval("races") + "]</i>"%>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="winners" HeaderText="winners" ReadOnly="True" SortExpression="winners" Visible="false" />
            <asp:BoundField DataField="itm" HeaderText="itm" ReadOnly="True" SortExpression="itm" Visible="false" />
            <asp:BoundField DataField="races" HeaderText="races" ReadOnly="True" SortExpression="races" Visible="false" />
            <asp:BoundField DataField="avgwinpayoff" HeaderText="avgwinpayoff" DataFormatString="{0:C2}" ReadOnly="True" SortExpression="avgwinpayoff" Visible="false" />
            <asp:BoundField DataField="avgplacepayoff" HeaderText="avgplacepayoff" DataFormatString="{0:C2}" ReadOnly="True" SortExpression="avgplacepayoff" Visible="false" />
            <asp:BoundField DataField="avgshowpayoff" HeaderText="avgshowpayoff" DataFormatString="{0:C2}" ReadOnly="True" SortExpression="avgshowpayoff" Visible="false" />
            <asp:TemplateField HeaderText="Win">
                <ItemTemplate>
                    <asp:Label ID="LabelAvgReturn" runat="server" Visible='<%# Convert.ToDouble(Eval("avgwinreturn")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("avgwinreturn")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("avgwinreturn"))) %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Place">
                <ItemTemplate>
                    <asp:Label ID="LabelAvgReturn" runat="server" Visible='<%# Convert.ToDouble(Eval("avgplacereturn")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("avgplacereturn")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("avgplacereturn"))) %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Show">
                <ItemTemplate>
                    <asp:Label ID="LabelAvgReturn" runat="server" Visible='<%# Convert.ToDouble(Eval("avgshowreturn")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("avgshowreturn")) - 2.0).ToString("c2") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("avgshowreturn"))) %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceReturns" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SP_EvalReturns" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter Name="rtype" ControlID="DDLRtype" PropertyName="SelectedValue" /> 
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTypes" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT distinct rtype FROM races">
    </asp:SqlDataSource>
</asp:Content>
