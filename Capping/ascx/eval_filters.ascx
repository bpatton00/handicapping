<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="eval_filters.ascx.cs" Inherits="Capping.ascx.eval_filters" %>

<asp:UpdatePanel ID="UP_Eval" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true" >
        <ContentTemplate>          
<div class="title-md hr-before">Filters</div>
    <div class="filters_light filters_hz">
        <div class="form-horizontal">
            <div class="form-group">
            <span data-toggle="tooltip" title="Highest ThoroLab rank allowed in the filter" class=" col-lg-2 control-label" style="color:white;">Max TL Rank</span>
            <div class="col-lg-10">
            <asp:RadioButtonList ID="RBLTLRank" runat="server" RepeatDirection="Horizontal"  CssClass="table-noborder " AutoPostBack="true" >
                <asp:ListItem Text="All" Value="99" Selected="True"></asp:ListItem>
                <asp:ListItem Text="1" Value="1"></asp:ListItem>
                <asp:ListItem Text="2" Value="2"></asp:ListItem>
                <asp:ListItem Text="3" Value="3"></asp:ListItem>
                <asp:ListItem Text="4" Value="4"></asp:ListItem>
                <asp:ListItem Text="5" Value="5"></asp:ListItem>
            </asp:RadioButtonList>
            </div>
            </div>
        
        <div class="form-group">
            <span data-toggle="tooltip" title="Lowest allowed ThoroLab score allowed" class="col-lg-2 control-label" style="color:white;">Min TL Score</span>
            <div class="col-lg-10">
            <asp:RadioButtonList ID="RBLTLScore" runat="server" RepeatDirection="Horizontal"  CssClass="table-noborder " AutoPostBack="true" >
                <asp:ListItem Text="All" Value="0" Selected="True"></asp:ListItem>
                <asp:ListItem Text="5%" Value=".05"></asp:ListItem>
                <asp:ListItem Text="10%" Value=".10"></asp:ListItem>
                <asp:ListItem Text="15%" Value=".15"></asp:ListItem>
                <asp:ListItem Text="20%" Value=".20"></asp:ListItem>
                <asp:ListItem Text="25%" Value=".25"></asp:ListItem>
                <asp:ListItem Text="30%" Value=".30"></asp:ListItem>
                <asp:ListItem Text="35%" Value=".35"></asp:ListItem>
            </asp:RadioButtonList>
            </div>
        </div>
        <div class="form-group">
           <span data-toggle="tooltip" title="Lowest final odds allowed" class="col-lg-2 control-label" style="color:white;">Lowest Final Odds</span>
            <div class="col-lg-10">
            <asp:RadioButtonList ID="RBLOdds_L" runat="server" RepeatDirection="Horizontal"  CssClass="table-noborder " AutoPostBack="true" >
                <asp:ListItem Text="All" Value="0" Selected="True"></asp:ListItem>
                <asp:ListItem Text="Even" Value="2"></asp:ListItem>
                <asp:ListItem Text="2/1" Value="3"></asp:ListItem>
                <asp:ListItem Text="5/1" Value="6"></asp:ListItem>
                <asp:ListItem Text="8/1" Value="9"></asp:ListItem>
                <asp:ListItem Text="10/1" Value="11"></asp:ListItem>
            </asp:RadioButtonList>
            </div>
        </div>        
        <div class="form-group">
            <span data-toggle="tooltip" title="Maximum final odds allowed" class="col-lg-2 control-label" style="color:white;">Highest Final Odds</span>
            <div class="col-lg-10">
            <asp:RadioButtonList ID="RBLOdds_H" runat="server" RepeatDirection="Horizontal"  CssClass="table-noborder " AutoPostBack="true" >
                <asp:ListItem Text="All" Value="99" Selected="True"></asp:ListItem>
                <asp:ListItem Text="Even" Value="2"></asp:ListItem>
                <asp:ListItem Text="2/1" Value="4"></asp:ListItem>
                <asp:ListItem Text="5/1" Value="10"></asp:ListItem>
                <asp:ListItem Text="8/1" Value="16"></asp:ListItem>
                <asp:ListItem Text="10/1" Value="20"></asp:ListItem>
            </asp:RadioButtonList>
            </div>
        </div>        
        <div class="form-group">
            <span data-toggle="tooltip" title="Lowest average class rating for the race" class="col-lg-2 control-label" style="color:white;">Min Class Avg for Race</span>
            <div class="col-lg-10">
            <asp:RadioButtonList ID="RBLClass" runat="server" RepeatDirection="Horizontal"  CssClass="table-noborder " AutoPostBack="true" >
                <asp:ListItem Text="All" Value="0" Selected="True"></asp:ListItem>
                <asp:ListItem Text="80" Value="80"></asp:ListItem>
                <asp:ListItem Text="90" Value="90"></asp:ListItem>
                <asp:ListItem Text="100" Value="100"></asp:ListItem>
                <asp:ListItem Text="110" Value="110"></asp:ListItem>
            </asp:RadioButtonList>
            </div>
        </div>        
        <div class="form-group">
            <span data-toggle="tooltip" title="Lowest total purse for the race" class="col-lg-2 control-label" style="color:white;">Min Purse for Race</span>
            <div class="col-lg-10">
            <asp:RadioButtonList ID="RBLPurse" runat="server" RepeatDirection="Horizontal"  CssClass="table-noborder " AutoPostBack="true" >
                <asp:ListItem Text="All" Value="0" Selected="True"></asp:ListItem>
                <asp:ListItem Text="40000" Value="40000"></asp:ListItem>
                <asp:ListItem Text="60000" Value="60000"></asp:ListItem>
                <asp:ListItem Text="80000" Value="80000"></asp:ListItem>
                <asp:ListItem Text="100000" Value="100000"></asp:ListItem>
                <asp:ListItem Text="120000" Value="120000"></asp:ListItem>
            </asp:RadioButtonList>
            </div>
        </div>
        <div class="form-group">
            <span data-toggle="tooltip" title="Race classification type" class="col-lg-2 control-label" style="color:white;">Race Type</span>
            <div class="col-lg-10">
            <asp:RadioButtonList ID="RBLType" runat="server" RepeatDirection="Horizontal"  CssClass="table-noborder " AutoPostBack="true" >
                <asp:ListItem Text="All" Value="All" Selected="True"></asp:ListItem>
                <asp:ListItem Text="Maiden" Value="MDN"></asp:ListItem>
                <asp:ListItem Text="Claiming" Value="CLM"></asp:ListItem>
                <asp:ListItem Text="Allowance" Value="ALW"></asp:ListItem>
                <asp:ListItem Text="Stakes" Value="STK"></asp:ListItem>
            </asp:RadioButtonList>
            </div>
        </div>
        </div>
        <div class="row">
            <br />
              <div class="col-xs-12">
                    <div class="customfilters">
                            <asp:CheckBox ID="CBFirst" runat="server" Text="First Time Starter" AutoPostBack="true" />
                            <asp:CheckBox ID="CBTLGap" runat="server" Text="10pt TL Gap or Higher" AutoPostBack="true" />
                            <asp:CheckBox ID="CBLastSR" runat="server" Text="Top Last SR" AutoPostBack="true" />
                            <asp:CheckBox ID="CBAvgSR" runat="server" Text="Top AVG SR" AutoPostBack="true" />
                            <asp:CheckBox ID="CBAvgClass" runat="server" Text="Top Avg Class" AutoPostBack="true" />
                            <asp:CheckBox ID="CBClassDrop" runat="server" Text="Class Drop" AutoPostBack="true" />
                            <asp:CheckBox ID="CBWinStreak" runat="server" Text="Win Streak" AutoPostBack="true" />                
                            <asp:CheckBox ID="CBLongshot" runat="server" Text="Live Longshot" AutoPostBack="true" />                
                    </div>
            </div>
        </div>
    </div>


<div class="row">
    <div class="col-xs-12">
        <asp:GridView ID="GVResults" runat="server" DataSourceID="SqlDataSourceResults" AutoGenerateColumns="false" HeaderStyle-CssClass="active" CssClass="table table-condensed table-hover">
            <Columns>
            <asp:BoundField DataField="ccrank" HeaderText="TL Rank" SortExpression="ccrank" />
            <asp:TemplateField HeaderText="Win Rates">
                <ItemTemplate>
                    <asp:Label ID="LabelPct" runat="server" Text='<%# Convert.ToInt16(Eval("winners")) > 0 ? (Convert.ToDouble(Eval("winners")) / Convert.ToDouble(Eval("races"))).ToString("p2") : ""  %>'  />
                    <asp:Label ID="LabelWinners" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("winners") + "/" + Eval("races") + "]</i>"%>' />
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
                    <asp:Label ID="LabelAvgReturn" runat="server" Visible='<%# Convert.ToDouble(Eval("avgwinreturn")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("avgwinreturn")) - 2.0).ToString("c2") %>' data-toggle="tooltip" ToolTip='<%# "Avg: " + Eval("avgwinpayoff","{0:c2}") + " / Total: "+ Eval("totalwinpayoff","{0:c2}") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("avgwinreturn"))) %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Place">
                <ItemTemplate>
                    <asp:Label ID="LabelAvgReturn" runat="server" Visible='<%# Convert.ToDouble(Eval("avgplacereturn")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("avgplacereturn")) - 2.0).ToString("c2") %>' data-toggle="tooltip" ToolTip='<%# "Avg: " + Eval("avgplacepayoff","{0:c2}") + " / Total: "+ Eval("totalplacepayoff","{0:c2}") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("avgplacereturn"))) %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Show">
                <ItemTemplate>
                    <asp:Label ID="LabelAvgReturn" runat="server" Visible='<%# Convert.ToDouble(Eval("avgshowreturn")) > 0 %>' Text='<%# (Convert.ToDouble(Eval("avgshowreturn")) - 2.0).ToString("c2") %>' data-toggle="tooltip" ToolTip='<%# "Avg: " + Eval("avgshowpayoff","{0:c2}") + " / Total: "+ Eval("totalshowpayoff","{0:c2}") %>' ForeColor='<%# shared.GetColor_Returns(Convert.ToDouble(Eval("avgshowreturn"))) %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ITM">
                <ItemTemplate>
                    <asp:Label ID="LabelPct" runat="server" Text='<%# Convert.ToInt16(Eval("itm")) > 0 ? (Convert.ToDouble(Eval("itm")) / Convert.ToDouble(Eval("races"))).ToString("p2") : ""  %>'  />
                    <asp:Label ID="LabelWinners" runat="server" Text='<%# "  <i style=\"color:graytext;font-size:X-Small;\">[" + Eval("itm") + "/" + Eval("races") + "]</i>"%>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSourceResults" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
            SelectCommand="SP_EvalReturns_DTLD" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="false">
            <SelectParameters>
                <asp:ControlParameter ControlID="RBLTLRank" PropertyName="SelectedValue" Name="CCRANK" DefaultValue="99" />
                <asp:ControlParameter ControlID="RBLTLScore" PropertyName="SelectedValue" Name="CCSCORE" DefaultValue="0" />
                <asp:ControlParameter ControlID="RBLClass" PropertyName="SelectedValue" Name="CLASS" DefaultValue="0" />
                <asp:ControlParameter ControlID="RBLPurse" PropertyName="SelectedValue" Name="PURSE" DefaultValue="0" />
                <asp:ControlParameter ControlID="RBLType" PropertyName="SelectedValue" Name="RTYPE" DefaultValue="All" />
                <asp:ControlParameter ControlID="RBLOdds_L" PropertyName="SelectedValue" Name="FODDS_L" DefaultValue="0" />                
                <asp:ControlParameter ControlID="RBLOdds_H" PropertyName="SelectedValue" Name="FODDS_H" DefaultValue="99" />                
                <asp:ControlParameter ControlID="CBFirst" PropertyName="Checked" Name="FIRST" DefaultValue="0" />
                <asp:ControlParameter ControlID="CBTLGap" PropertyName="Checked" Name="GAP" DefaultValue="0" />
                <asp:ControlParameter ControlID="CBLastSR" PropertyName="Checked" Name="TopLastSR" DefaultValue="0" />
                <asp:ControlParameter ControlID="CBAvgSR" PropertyName="Checked" Name="TopAvgSR" DefaultValue="0" />
                <asp:ControlParameter ControlID="CBAvgClass" PropertyName="Checked" Name="TopAvgClass" DefaultValue="0" />
                <asp:ControlParameter ControlID="CBClassDrop" PropertyName="Checked" Name="classdrop" DefaultValue="0" />
                <asp:ControlParameter ControlID="CBWinStreak" PropertyName="Checked" Name="winstreak" DefaultValue="0" />
                <asp:ControlParameter ControlID="CBLongshot" PropertyName="Checked" Name="longshot" DefaultValue="0" />                
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</div>



        </ContentTemplate>
</asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UP_Eval" >
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