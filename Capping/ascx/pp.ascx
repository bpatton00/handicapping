<%@ Control Language="C#" AutoEventWireup="true" Inherits="ascx_pp" Codebehind="pp.ascx.cs" %>

<div id="pps" style="font-size:x-small;">
        
        <asp:GridView ID="GridViewPP" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSourcePP"
                                                GridLines="None" CssClass="table table-condensed table-hover" EnableViewState="false"  >
                                                <Columns>                
                                                    <asp:TemplateField HeaderText="Race">
                                                    <ItemTemplate>
                                                        <asp:Label ID="LabelRaceDtls" runat="server" Text='<%# Eval("rdate","{0:M-d-yy}") + " " + Eval("tcode")  %>' />
                                                        <asp:Label ID="labelRace" runat="server" Text='<%# " " + shared.FormatNumber(Convert.ToInt32(Eval("purse")))  %>' />
                                                        <asp:Label ID="LabelDist" runat="server" CssClass="visible-xs visible-sm" Text='<%# " " + shared.ConvertDist(Convert.ToInt32(Eval("distance")), Eval("disttype").ToString()) %>' />
                                                        <asp:Label ID="LabelTrackCond" runat="server" CssClass="visible-xs visible-sm" Text='<%# Eval("trackcond")  %>' ForeColor='<%# shared.GetColor(Eval("surface").ToString())  %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>                                                                                               
                                                <asp:TemplateField HeaderText="Dist" HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm">
                                                    <ItemTemplate>
                                                        <asp:Label ID="LabelDist" runat="server" Text='<%# shared.ConvertDist(Convert.ToInt32(Eval("distance")), Eval("disttype").ToString()) %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>           
                                                <asp:TemplateField HeaderText="Cond" HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm">
                                                    <ItemTemplate>
                                                        <asp:Label ID="LabelTrackCond" runat="server" Text='<%# Eval("trackcond")  %>' ForeColor='<%# shared.GetColor(Eval("surface").ToString())  %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="weight" HeaderText="Wgt" SortExpression="weight" ItemStyle-HorizontalAlign="Right" HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm" />
                                                <asp:BoundField DataField="pace" HeaderText="Pace" SortExpression="pace" ItemStyle-HorizontalAlign="Right" HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm" Visible="false" />
                                                <asp:BoundField DataField="pace2" HeaderText="Pace2" SortExpression="pace2" ItemStyle-HorizontalAlign="Right" HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm" Visible="false" />                
                                                <asp:BoundField DataField="winsr" HeaderText="WinSr" SortExpression="winsr"  ItemStyle-HorizontalAlign="Right" HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm" Visible="false"/>
                                                <asp:TemplateField HeaderText="SR" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:Label ID="LabelSR" runat="server" Text='<%# Eval("sr") %>' ToolTip='<%# "Winners SR: " + Eval("winsr") %>' ForeColor='<%# entries.SetSRColor(Convert.ToInt16(Eval("sr"))) %>'/>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="tvar" HeaderText="TVar" SortExpression="tvar" Visible="False" ItemStyle-HorizontalAlign="Right" HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm" />
                                                <asp:BoundField DataField="post" HeaderText="Post" SortExpression="post" Visible="false" ItemStyle-HorizontalAlign="Right" HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm" />
                                                <asp:BoundField DataField="odds" HeaderText="Odds" SortExpression="odds" ItemStyle-HorizontalAlign="Right" />
                                                <asp:TemplateField HeaderText="Fin" ItemStyle-HorizontalAlign="Right" >
                                                    <ItemTemplate>                                                              
                                                        <asp:Label ID="LabelFin" runat="server" Text='<%# Eval("posfin") %>' Font-Bold='<%# Convert.ToInt16(Eval("posfin")) == 1 %>' />
                                                        <sup><asp:Label ID="LabelFinL" runat="server" Text='<%# Math.Round(Convert.ToDouble(Eval("lenbackfin")) / 100, 2) %>'  /></sup>                                                        
                                                    </ItemTemplate>
                                                </asp:TemplateField>        
                                                <asp:TemplateField HeaderText="Time" ItemStyle-HorizontalAlign="Right" >
                                                    <ItemTemplate>
                                                        <asp:Label ID="LabelTime" runat="server" Text='<%# shared.ConvertToTime_Short(Convert.ToDouble(Eval("horsetimef"))) %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="shortcomme" HeaderText="Comments" SortExpression="shortcomme" HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm" />
                                                <asp:TemplateField HeaderText="CompanyLines" HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm fontsmaller" ItemStyle-HorizontalAlign="Left" >
                                                    <ItemTemplate>
                                                        <asp:Label ID="LabelComp1" runat="server" Text='<%# Eval("complineho")  %>' />,     
                                                        <asp:Label ID="LabelComp2" runat="server" Text='<%# Eval("complineh2")  %>' />,     
                                                        <asp:Label ID="LabelComp3" runat="server" Text='<%# Eval("complineh3") %>' />    
                                                        [ <asp:Label ID="classratinLabel" runat="server" data-toggle="tooltip" ToolTip="Class Rating" Text='<%# Bind("classratin") %>' /> ]
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
    
            
    </div>
        <asp:SqlDataSource ID="SqlDataSourcePP" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
            SelectCommand="SELECT * FROM [pp] WHERE ([entryid] = @entryid) AND rtype <> 'SCR' ORDER BY rdate DESC">
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="" Name="entryid" QueryStringField="eid" Type="Int64" />
            </SelectParameters>
        </asp:SqlDataSource>
