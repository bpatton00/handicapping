<%@ Page Title="Tournaments Overview" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="Tournaments_Default" Codebehind="Default.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <featured>
    </featured>

    <div>
        
            <div class="ribboncontainer one">
                <div class="skew l"></div>
                  <div class="ribbonmain">
                    <div class="title-md">Upcoming Tournaments</div>   
                  </div>
            </div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <asp:GridView ID="GVUPcomingTourn" runat="server" AutoGenerateColumns="False" DataKeyNames="id"  GridLines="None" PagerStyle-CssClass="pgr"
                    DataSourceID="SqlDataSourceTourns" AllowPaging="true" PageSize="10" CssClass="table table-hover panel panel-default" HeaderStyle-CssClass="success" EmptyDataText="No Tournaments Currently Available">
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" Visible="false" />
                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                                <asp:HyperLink ID="HLTourny" runat="server" Text='<%# Eval("name") %>' NavigateUrl='<%# "~/tournaments/details.aspx?id=" + Eval("id") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="prize" HeaderText="Prize" SortExpression="prize" DataFormatString="{0:c}" />
                        <asp:BoundField DataField="tdate" HeaderText="Closes" SortExpression="tdate" DataFormatString="{0:g}" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <span class="badge">  <%# (Convert.ToInt16(Eval("nument")) < Convert.ToInt16(Eval("maxplayers"))) ? Eval("nument") + "/" + Eval("maxplayers") : "full"%> </span>
                            </ItemTemplate>
                        </asp:TemplateField>                
                    </Columns>
                </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>

            <div class="ribboncontainer one">
                <div class="skew l"></div>
                  <div class="ribbonmain">
                    <div class="title-md">Running Tournaments</div>   
                  </div>
            </div>
            <asp:UpdatePanel ID="UPUpcoming" runat="server">
                <ContentTemplate>
                <asp:GridView ID="GVRunning" runat="server" AutoGenerateColumns="False" DataKeyNames="id" GridLines="None" PagerStyle-CssClass="pgr" 
                    DataSourceID="SqlDataSourceTournsRunning" AllowPaging="true" PageSize="10" CssClass="table table-hover panel panel-default" HeaderStyle-CssClass="active">
                    <Columns>
                        <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" ReadOnly="True" SortExpression="id" Visible="false" />
                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                                <asp:HyperLink ID="HLTourny" runat="server" Text='<%# Eval("name") %>' NavigateUrl='<%# "~/tournaments/details.aspx?id=" + Eval("id") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="prize" HeaderText="Prize" SortExpression="prize" DataFormatString="{0:c}" />
                        <asp:BoundField DataField="tdate" HeaderText="Closes" SortExpression="tdate" DataFormatString="{0:g}" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <span class="badge">  <%# (Convert.ToInt16(Eval("nument")) < Convert.ToInt16(Eval("maxplayers"))) ? Eval("nument") + "/" + Eval("maxplayers") : "full"%> </span>
                            </ItemTemplate>
                        </asp:TemplateField>                
                    </Columns>
                </asp:GridView>
                    </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSourceTournsRunning" runat="server" 
    ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
    SelectCommand="SELECT * FROM [tournaments] WHERE ([tdate] < DateAdd(hour,-5,getdate())) AND finished = 'False' ORDER BY [tdate] DESC">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTourns" runat="server" 
    ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
    SelectCommand="SELECT * FROM [tournaments] WHERE ([tdate] >= DateAdd(hour,-5,getdate())) AND isopen = 'True' ORDER BY [tdate]">
    </asp:SqlDataSource>
</asp:Content>

