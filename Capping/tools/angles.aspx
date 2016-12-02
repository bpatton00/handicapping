<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="angles.aspx.cs" Inherits="Capping.tools.angles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Admin" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderLeft" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
                        <div class="title-md hr-before">Angles Data</div>
    <asp:UpdatePanel ID="UP_Angles" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true" >
        <ContentTemplate>                                                                        
                        <div class="filters_light filters_hz">
                            <div class="row">
                            <div class="hidden-md col-lg-2 text-center"><span data-toggle="tooltip" title="Highest ThoroLab rank allowed in the filter" class="title-sm" style="color:white;">Max CC Rank</span></div>
                                <div class="col-lg-10">
                            <asp:RadioButtonList ID="RBLCCRank" runat="server" RepeatDirection="Horizontal"  CssClass="table-noborder text-center" AutoPostBack="true" >
                                <asp:ListItem Text="All" Value="99" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                <asp:ListItem Text="5" Value="5"></asp:ListItem>
                            </asp:RadioButtonList>
                                </div>
                            </div>
                        </div>
                        <br /><br />
    <div class="row">
                        <div class=" col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-title">Perfect over Distance / Course <a class="btn btn-xs btn-default" data-toggle="collapse" href="#CRSDSTGRP">By Track</a></div>
                            <asp:GridView ID="GVDSTCRS" runat="server" DataSourceID="SqlDataSourceDSTCRS" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="active" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) -1).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                            <div class="row">
                            <div class="col-xs-12">                                
                                <div id="CRSDSTGRP" class="panel-collapse collapse">
                            <asp:GridView ID="GridView9" runat="server" DataSourceID="SqlDataSourceDSTCRS_GRP" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="success" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="abbrev" HeaderText="Track" />
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelITMRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("itm") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' data-toggle="tooltip" title='<%# "Total Payouts: " + Eval("totalwinpayout") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>                                            
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) - 1).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winning ROI (First Place Only)" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                                </div>
                            </div></div>
                        </div>
                        </div>

                        <div class=" col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-title">Jockey & Trainer ROI <a class="btn btn-xs btn-default" data-toggle="collapse" href="#JockTrainerROIGRP">By Track</a></div>
                            <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSourceJOCKTRAINROI" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="active" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) -1).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                            <div class="row">
                            <div class="col-xs-12">                                
                                <div id="JockTrainerROIGRP" class="panel-collapse collapse">
                            <asp:GridView ID="GridView8" runat="server" DataSourceID="SqlDataSourceJOCKTRAINROI_GRP" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="success" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="abbrev" HeaderText="Track" />
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelITMRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("itm") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' data-toggle="tooltip" title='<%# "Total Payouts: " + Eval("totalwinpayout") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) - 1).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winning ROI (First Place Only)" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                                </div>
                            </div></div>
                        </div>
                        </div>

                        <div class=" col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-title">Lifetime Jockey & Trainer <a class="btn btn-xs btn-default" data-toggle="collapse" href="#LifetimeJockTrainerGRP">By Track</a></div>
                            <asp:GridView ID="GridView2" runat="server" DataSourceID="SqlDataSourceLifeTimeJockeyTrainer" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="active" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) -1).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                            <div class="row">
                            <div class="col-xs-12">                                
                                <div id="LifetimeJockTrainerGRP" class="panel-collapse collapse">
                            <asp:GridView ID="GridView7" runat="server" DataSourceID="SqlDataSourceLifeTimeJockeyTrainer_GRP" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="success" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="abbrev" HeaderText="Track" />
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelITMRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("itm") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' data-toggle="tooltip" title='<%# "Total Payouts: " + Eval("totalwinpayout") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) - 1).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winning ROI (First Place Only)" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                                </div>
                            </div></div>
                        </div>
                        </div>

                        <div class=" col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-title">Last 30 Days Hot Jockey <a class="btn btn-xs btn-default" data-toggle="collapse" href="#RecentJockGRP">By Track</a></div>
                            <asp:GridView ID="GridView3" runat="server" DataSourceID="SqlDataSourceRecentJockey" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="active" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) -1).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                            <div class="row">
                            <div class="col-xs-12">                                
                                <div id="RecentJockGRP" class="panel-collapse collapse">
                            <asp:GridView ID="GridView6" runat="server" DataSourceID="SqlDataSourceRecentJockey_GRP" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="success" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="abbrev" HeaderText="Track" />
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelITMRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("itm") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' data-toggle="tooltip" title='<%# "Total Payouts: " + Eval("totalwinpayout") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) - 1).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winning ROI (First Place Only)" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                                </div>
                            </div></div>
                        </div>
                        </div>

                        <div class=" col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-title">Last 30 Days Hot Jockey (>= 60%) <a class="btn btn-xs btn-default" data-toggle="collapse" href="#RecentJock60GRP">By Track</a></div>
                            <asp:GridView ID="GridView14" runat="server" DataSourceID="SqlDataSourceRecentJockey60" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="active" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) -1).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                            <div class="row">
                            <div class="col-xs-12">                                
                                <div id="RecentJock60GRP" class="panel-collapse collapse">
                            <asp:GridView ID="GridView15" runat="server" DataSourceID="SqlDataSourceRecentJockey60_GRP" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="success" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="abbrev" HeaderText="Track" />
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelITMRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("itm") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' data-toggle="tooltip" title='<%# "Total Payouts: " + Eval("totalwinpayout") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) - 1).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winning ROI (First Place Only)" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                                </div>
                            </div></div>
                        </div>
                        </div>

                        <div class=" col-lg-6">
                            <div class="panel panel-default">
                            <div class="panel-heading panel-title">Last 30 Days Hot Trainer <a class="btn btn-xs btn-default" data-toggle="collapse" href="#TrainerGRP">By Track</a></div>
                            <asp:GridView ID="GridView4" runat="server" DataSourceID="SqlDataSourceRecentTrainer" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="active" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) -1).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
 
                                </Columns>
                            </asp:GridView>
                            <div class="row">
                            <div class="col-xs-12">                                
                                <div id="TrainerGRP" class="panel-collapse collapse">
                            <asp:GridView ID="GridView5" runat="server" DataSourceID="SqlDataSourceRecentTrainer_GRP" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="success" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="abbrev" HeaderText="Track" />
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelITMRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("itm") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' data-toggle="tooltip" title='<%# "Total Payouts: " + Eval("totalwinpayout") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) - 1).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winning ROI (First Place Only)" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                                </div>
                            </div>
                            </div>
                        </div>
                        </div>

                        <div class=" col-lg-6">
                            <div class="panel panel-default">
                            <div class="panel-heading panel-title">Last 30 Days Hot Trainer (>= 60%) <a class="btn btn-xs btn-default" data-toggle="collapse" href="#Trainer60GRP">By Track</a></div>
                            <asp:GridView ID="GridView12" runat="server" DataSourceID="SqlDataSourceRecentTrainer60" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="active" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) -1).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                            <div class="row">
                            <div class="col-xs-12">                                
                                <div id="Trainer60GRP" class="panel-collapse collapse">
                            <asp:GridView ID="GridView13" runat="server" DataSourceID="SqlDataSourceRecentTrainer60_GRP" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="success" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="abbrev" HeaderText="Track" />
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelITMRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("itm") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' data-toggle="tooltip" title='<%# "Total Payouts: " + Eval("totalwinpayout") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) - 1).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winning ROI (First Place Only)" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                                </div>
                            </div></div>
                        </div>
                        </div>

                        <div class=" col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-title">Live Longshots <a class="btn btn-xs btn-default" data-toggle="collapse" href="#Longshots">By Track</a></div>
                            <asp:GridView ID="GridView10" runat="server" DataSourceID="SqlDataSourceLongshots" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="active" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) -1).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                            <div class="row">
                            <div class="col-xs-12">                                
                                <div id="Longshots" class="panel-collapse collapse">
                            <asp:GridView ID="GridView11" runat="server" DataSourceID="SqlDataSourceLongshots_GRP" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="success" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="abbrev" HeaderText="Track" />
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelITMRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("itm") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' data-toggle="tooltip" title='<%# "Total Payouts: " + Eval("totalwinpayout") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) - 1).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winning ROI (First Place Only)" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                                </div>
                            </div>
                            </div>
                        </div>
                        </div>

                        <div class=" col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-title">Top Last SR <a class="btn btn-xs btn-default" data-toggle="collapse" href="#LastSR">By Track</a></div>
                            <asp:GridView ID="GridView16" runat="server" DataSourceID="SqlDataSourceTopLastSR" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="active" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) -1).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                            <div class="row">
                            <div class="col-xs-12">                                
                                <div id="LastSR" class="panel-collapse collapse">
                            <asp:GridView ID="GridView17" runat="server" DataSourceID="SqlDataSourceTopLastSR_GRP" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="success" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="abbrev" HeaderText="Track" />
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelITMRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("itm") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' data-toggle="tooltip" title='<%# "Total Payouts: " + Eval("totalwinpayout") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) - 1).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winning ROI (First Place Only)" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                                </div>
                            </div>
                            </div>
                        </div>
                        </div>

                        <div class=" col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-title">Top AVG SR <a class="btn btn-xs btn-default" data-toggle="collapse" href="#AVGSR">By Track</a></div>
                            <asp:GridView ID="GridView18" runat="server" DataSourceID="SqlDataSourceTopAVGSR" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="active" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) -1).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                            <div class="row">
                            <div class="col-xs-12">                                
                                <div id="AVGSR" class="panel-collapse collapse">
                            <asp:GridView ID="GridView19" runat="server" DataSourceID="SqlDataSourceTopAVGSR_GRP" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="success" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="abbrev" HeaderText="Track" />
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelITMRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("itm") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' data-toggle="tooltip" title='<%# "Total Payouts: " + Eval("totalwinpayout") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) - 1).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winning ROI (First Place Only)" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                                </div>
                            </div>
                            </div>
                        </div>
                        </div>

                        <div class=" col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-title">Top Class <a class="btn btn-xs btn-default" data-toggle="collapse" href="#class">By Track</a></div>
                            <asp:GridView ID="GridView20" runat="server" DataSourceID="SqlDataSourceTopClass" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="active" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) -1).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                            <div class="row">
                            <div class="col-xs-12">                                
                                <div id="class" class="panel-collapse collapse">
                            <asp:GridView ID="GridView21" runat="server" DataSourceID="SqlDataSourceTopClass_GRP" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="success" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="abbrev" HeaderText="Track" />
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelITMRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("itm") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' data-toggle="tooltip" title='<%# "Total Payouts: " + Eval("totalwinpayout") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) - 1).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winning ROI (First Place Only)" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                                </div>
                            </div>
                            </div>
                        </div>
                        </div>

                        <div class=" col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-title">Class Drop <a class="btn btn-xs btn-default" data-toggle="collapse" href="#classdrop">By Track</a></div>
                            <asp:GridView ID="GridView22" runat="server" DataSourceID="SqlDataSourceClassDrop" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="active" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) -1).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                            <div class="row">
                            <div class="col-xs-12">                                
                                <div id="classdrop" class="panel-collapse collapse">
                            <asp:GridView ID="GridView23" runat="server" DataSourceID="SqlDataSourceClassDrop_GRP" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="success" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="abbrev" HeaderText="Track" />
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelITMRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("itm") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' data-toggle="tooltip" title='<%# "Total Payouts: " + Eval("totalwinpayout") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) - 1).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winning ROI (First Place Only)" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                                </div>
                            </div>
                            </div>
                        </div>
                        </div>

                        <div class=" col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-title">Class Drop and Close <a class="btn btn-xs btn-default" data-toggle="collapse" href="#classdropClose">By Track</a></div>
                            <asp:GridView ID="GridView24" runat="server" DataSourceID="SqlDataSourceClassDropAndClose" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="active" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) -1).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>                                     
                                </Columns>
                            </asp:GridView>
                            <div class="row">
                            <div class="col-xs-12">                                
                                <div id="classdropClose" class="panel-collapse collapse">
                            <asp:GridView ID="GridView25" runat="server" DataSourceID="SqlDataSourceClassDropAndClose_GRP" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="success" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="abbrev" HeaderText="Track" />
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelITMRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("itm") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' data-toggle="tooltip" title='<%# "Total Payouts: " + Eval("totalwinpayout") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) - 1).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winning ROI (First Place Only)" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                                </div>
                            </div>
                            </div>
                        </div>
                        </div>

                        <div class=" col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-title">Win Streak <a class="btn btn-xs btn-default" data-toggle="collapse" href="#winstreak">By Track</a></div>
                            <asp:GridView ID="GridView26" runat="server" DataSourceID="SqlDataSourceWinStreak" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="active" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) -1).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                            <div class="row">
                            <div class="col-xs-12">                                
                                <div id="winstreak" class="panel-collapse collapse">
                            <asp:GridView ID="GridView27" runat="server" DataSourceID="SqlDataSourceWinStreak_GRP" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="success" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="abbrev" HeaderText="Track" />
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelITMRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("itm") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' data-toggle="tooltip" title='<%# "Total Payouts: " + Eval("totalwinpayout") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) - 1).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winning ROI (First Place Only)" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                                </div>
                            </div>
                            </div>

                        </div>
                        </div>

                        <div class=" col-lg-6">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-title">Post Time Fav <a class="btn btn-xs btn-default" data-toggle="collapse" href="#posttimefav">By Track</a></div>
                            <asp:GridView ID="GridView28" runat="server" DataSourceID="SqlDataSourcePostTimeFav" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="active" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) -1).ToString("p0") : "" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                            <div class="row">
                            <div class="col-xs-12">                                
                                <div id="posttimefav" class="panel-collapse collapse">
                            <asp:GridView ID="GridView29" runat="server" DataSourceID="SqlDataSourcePostTimeFav_GRP" CssClass="table table-condensed table-hover fw-inputgroup-sm" GridLines="None" HeaderStyle-CssClass="success" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="abbrev" HeaderText="Track" />
                                    <asp:TemplateField HeaderText="Win Rate">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelWinRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("winners") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ITM">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelITMRate" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("rcount"))).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winners: " + Eval("itm") + " / Races: " + Eval("rcount") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Avg Winnings">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelAvgWinnings" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / Convert.ToDouble(Eval("winners"))).ToString("c2") : "" %>' data-toggle="tooltip" title='<%# "Total Payouts: " + Eval("totalwinpayout") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ROI" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <%# Convert.ToInt16(Eval("rcount")) > 0 ? GetROIIcon(Convert.ToInt16(Eval("rcount")), Convert.ToDouble(Eval("totalwinpayout"))) : "" %><asp:Label ID="LabelROI" runat="server" Text='<%# Convert.ToInt16(Eval("rcount")) > 0 ? (Convert.ToDouble(Eval("totalwinpayout")) / (Convert.ToDouble(Eval("rcount")) * 2.0) - 1).ToString("p0") : "" %>' data-toggle="tooltip" title='<%# "Winning ROI (First Place Only)" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                                </div>
                            </div>
                            </div>

                        </div>
                        </div>
    </div>

    <div >
     <asp:SqlDataSource ID="SqlDataSourceLongshots" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM LiveLongshots as d INNER JOIN entry_results ON d.id = entry_results.entryid  WHERE ccrank <= @ccrank">
         <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceLongshots_GRP" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT abbrev, COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM LiveLongshots as d INNER JOIN entry_results ON d.id = entry_results.entryid INNER JOIN races ON races.id = entry_results.raceid INNER JOIN tracks ON tracks.id = races.track  WHERE ccrank <= @ccrank GROUP BY abbrev">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
       
    <asp:SqlDataSource ID="SqlDataSourceDSTCRS" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM DST_CRS_PERFECT as d INNER JOIN entry_results ON d.id = entry_results.entryid WHERE ccrank <= @ccrank">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceDSTCRS_GRP" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT abbrev, COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM DST_CRS_PERFECT as d INNER JOIN entry_results ON d.id = entry_results.entryid INNER JOIN races ON races.id = entry_results.raceid INNER JOIN tracks ON tracks.id = races.track WHERE ccrank <= @ccrank GROUP BY abbrev">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceJOCKTRAINROI" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM JOCK_TRAN_ROI as d INNER JOIN entry_results ON d.id = entry_results.entryid WHERE ccrank <= @ccrank">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceJOCKTRAINROI_GRP" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT abbrev, COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM JOCK_TRAN_ROI as d INNER JOIN entry_results ON d.id = entry_results.entryid INNER JOIN races ON races.id = entry_results.raceid INNER JOIN tracks ON tracks.id = races.track WHERE ccrank <= @ccrank GROUP BY abbrev">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceLifeTimeJockeyTrainer" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM LifeTimeJockeyTrainer as d INNER JOIN entry_results ON d.id = entry_results.entryid WHERE ccrank <= @ccrank">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceLifeTimeJockeyTrainer_GRP" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT abbrev, COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM LifeTimeJockeyTrainer as d INNER JOIN entry_results ON d.id = entry_results.entryid INNER JOIN races ON races.id = entry_results.raceid INNER JOIN tracks ON tracks.id = races.track WHERE ccrank <= @ccrank GROUP BY abbrev">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceRecentJockey" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM RecentJockey as d INNER JOIN entry_results ON d.id = entry_results.entryid WHERE ccrank <= @ccrank">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceRecentJockey_GRP" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT abbrev, COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM RecentJockey as d INNER JOIN entry_results ON d.id = entry_results.entryid INNER JOIN races ON races.id = entry_results.raceid INNER JOIN tracks ON tracks.id = races.track WHERE ccrank <= @ccrank GROUP BY abbrev">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceRecentJockey60" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM RecentJockey_60 as d INNER JOIN entry_results ON d.id = entry_results.entryid WHERE ccrank <= @ccrank">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceRecentJockey60_GRP" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT abbrev, COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM RecentJockey_60 as d INNER JOIN entry_results ON d.id = entry_results.entryid INNER JOIN races ON races.id = entry_results.raceid INNER JOIN tracks ON tracks.id = races.track WHERE ccrank <= @ccrank GROUP BY abbrev">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceRecentTrainer" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM RecentTrainer as d INNER JOIN entry_results ON d.id = entry_results.entryid WHERE ccrank <= @ccrank">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceRecentTrainer_GRP" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT abbrev, COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM RecentTrainer as d INNER JOIN entry_results ON d.id = entry_results.entryid INNER JOIN races ON races.id = entry_results.raceid INNER JOIN tracks ON tracks.id = races.track WHERE ccrank <= @ccrank GROUP BY abbrev ">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceRecentTrainer60" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM RecentTrainer_60 as d INNER JOIN entry_results ON d.id = entry_results.entryid WHERE ccrank <= @ccrank">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceRecentTrainer60_GRP" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT abbrev, COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM RecentTrainer_60 as d INNER JOIN entry_results ON d.id = entry_results.entryid INNER JOIN races ON races.id = entry_results.raceid INNER JOIN tracks ON tracks.id = races.track WHERE ccrank <= @ccrank GROUP BY abbrev ">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClassDrop" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM ClassDrop as d INNER JOIN entry_results ON d.id = entry_results.entryid WHERE ccrank <= @ccrank">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClassDrop_GRP" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT abbrev, COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM ClassDrop as d INNER JOIN entry_results ON d.id = entry_results.entryid INNER JOIN races ON races.id = entry_results.raceid INNER JOIN tracks ON tracks.id = races.track WHERE ccrank <= @ccrank GROUP BY abbrev ">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTopLastSR" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM TopLastSR as d INNER JOIN entry_results ON d.id = entry_results.entryid WHERE ccrank <= @ccrank">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTopLastSR_GRP" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT abbrev, COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM TopLastSR as d INNER JOIN entry_results ON d.id = entry_results.entryid INNER JOIN races ON races.id = entry_results.raceid INNER JOIN tracks ON tracks.id = races.track WHERE ccrank <= @ccrank GROUP BY abbrev ">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTopAVGSR" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM TopAVGSR as d INNER JOIN entry_results ON d.id = entry_results.entryid WHERE ccrank <= @ccrank">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTopAVGSR_GRP" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT abbrev, COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM TopAVGSR as d INNER JOIN entry_results ON d.id = entry_results.entryid INNER JOIN races ON races.id = entry_results.raceid INNER JOIN tracks ON tracks.id = races.track WHERE ccrank <= @ccrank GROUP BY abbrev ">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceTopClass" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM TopClass as d INNER JOIN entry_results ON d.id = entry_results.entryid WHERE ccrank <= @ccrank">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceTopClass_GRP" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT abbrev, COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM TopClass as d INNER JOIN entry_results ON d.id = entry_results.entryid INNER JOIN races ON races.id = entry_results.raceid INNER JOIN tracks ON tracks.id = races.track WHERE ccrank <= @ccrank GROUP BY abbrev ">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceWinStreak" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM WinStreak as d INNER JOIN entry_results ON d.id = entry_results.entryid WHERE ccrank <= @ccrank">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceWinStreak_GRP" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT abbrev, COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM WinStreak as d INNER JOIN entry_results ON d.id = entry_results.entryid INNER JOIN races ON races.id = entry_results.raceid INNER JOIN tracks ON tracks.id = races.track WHERE ccrank <= @ccrank GROUP BY abbrev ">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourcePostTimeFav" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM PostTimeFav as d INNER JOIN entry_results ON d.id = entry_results.entryid WHERE ccrank <= @ccrank">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcePostTimeFav_GRP" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT abbrev, COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM PostTimeFav as d INNER JOIN entry_results ON d.id = entry_results.entryid INNER JOIN races ON races.id = entry_results.raceid INNER JOIN tracks ON tracks.id = races.track WHERE ccrank <= @ccrank GROUP BY abbrev ">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceClassDropAndClose" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM ClassDropAndClose as d INNER JOIN entry_results ON d.id = entry_results.entryid WHERE ccrank <= @ccrank">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceClassDropAndClose_GRP" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT abbrev, COUNT(d.id) as rcount, SUM(CASE WHEN officialfinish = 1 THEN 1 ELSE 0 END) as winners, SUM(CASE WHEN officialfinish <= 3 THEN 1 ELSE 0 END) as itm, SUM(CASE WHEN officialfinish = 1 THEN winpayoff ELSE 0 END) as totalwinpayout, SUM(CASE WHEN officialfinish <= 3 THEN placepayoff ELSE 0 END) as totalshowpayout FROM ClassDropAndClose as d INNER JOIN entry_results ON d.id = entry_results.entryid INNER JOIN races ON races.id = entry_results.raceid INNER JOIN tracks ON tracks.id = races.track WHERE ccrank <= @ccrank GROUP BY abbrev ">
        <SelectParameters>
             <asp:ControlParameter Name="ccrank" ControlID="RBLCCRank" PropertyName="SelectedValue" />
         </SelectParameters>
    </asp:SqlDataSource>
    </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UP_Angles" >
        <ProgressTemplate>
                                <div class="loading-animation">
	                                <div class="loading-container">
	                                  <div class="loader">
	                                    <div class="loading-bars">
	                                      <div class="bar"></div>
	                                      <div class="bar"></div>
	                                      <div class="bar"></div>
	                                      <div class="bar"></div>
	                                      <div class="bar"></div>
	                                    </div>
	                                  </div>
	                                </div>
	                                <div class="loading-label">
		                                LOADING
	                                </div>
                                </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>
