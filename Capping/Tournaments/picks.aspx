<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="Tournaments_picks" Codebehind="picks.aspx.cs" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<%@ Register src="~/ascx/leaderboard.ascx" tagname="leaderboard" tagprefix="uc1" %>
<%@ Register Src="~/ascx/myselections.ascx" TagPrefix="uc1" TagName="myselections" %>
<%@ Register Src="~/ascx/cc_score.ascx" TagPrefix="uc1" TagName="cc_score" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">


    <script src="/js/jquery.mobile.custom.min.js"></script>


    <script type="text/javascript">
        $(window).load(function () {
            $(".firstloader").fadeOut("slow");
        })
        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
            return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderLeft" Runat="Server">
    
    <uc1:leaderboard ID="leaderboard1" runat="server" />
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<div class="firstloader">
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
</div>


    <asp:HiddenField ID="HFPickID" runat="server" />
    <asp:HiddenField ID="hdnSelectedTab" runat="server" Value="0" />
    <asp:Label ID="LabelResponse" runat="server" ></asp:Label>
    <div id="div_reg" runat="server">
        <asp:FormView ID="FVTournReg" runat="server" DataSourceID="SqlDataSourceTournament" RenderOuterTable="False">
            <ItemTemplate>
                <!--Tournament Details-->
                <div class="row">
                <div class="">
                    <div class="imgoverlay">
                <h2 style="margin-top:0px;"><%# Eval("name") %></h2>
                        <div class="col-xs-9 col-md-4 col-lg-3">
                            <div class="">
                                <div class="btn btn-default btn-ghost">
                                    <div class="">Players</div>
                                    <div class=""><%# Eval("nument") %> / <%# Eval("maxplayers") %></div>
                                </div>
                                <div class="btn btn-default btn-ghost">
                                    <div class="">Prizes</div>
                                    <div class=""><%# Eval("prize","{0:c}") %></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-3 pull-right">
                            <asp:DropDownList ID="DDLEntries" runat="server" DataSourceID="SqlDataSourceEntries" DataTextField="id" DataValueField="id" 
                            AutoPostBack="true" OnDataBound="EntriesBound" CssClass="form-control hidden" >                
                            </asp:DropDownList>
                        </div>                
                        <div class="row"></div>
                    </div>
                </div>                
                </div>
            </ItemTemplate>
        </asp:FormView>
        Register for the tournament
        <asp:Button ID="ButtonReg" Text="Register" runat="server" OnClick="ButtonReg_Click" />       
        <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="ButtonReg" ConfirmText="Are you sure you wish to enter this tournament?"></asp:ConfirmButtonExtender>
        <asp:Label ID="LabelRegStatus" runat="server" ></asp:Label>
    </div>
    
     <div id="div_picks" runat="server" visible="false">


        <asp:FormView ID="FVTourn" runat="server" DataSourceID="SqlDataSourceTournament" RenderOuterTable="False">
            <ItemTemplate>
                <!--Tournament Details-->  
                <div class="row">
                <div class="">
                    <div class='<%# "imgoverlay " + "img" + shared.GetRndImg() %>'>
                <h2 style="margin-top:0px;"><%# Eval("name") %></h2>
                
                
                        <div class="col-xs-9 col-md-4 col-lg-3">
                            <div class="">
                            <div class="btn btn-default btn-ghost">
                                <div class="">Players</div>
                                <div class=""><%# Eval("nument") %> / <%# Eval("maxplayers") %></div>
                            </div>
                            <div class="btn btn-default btn-ghost">
                                <div class="">Prizes</div>
                                <div class=""><%# Eval("prize","{0:c}") %></div>
                            </div>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-3 pull-right">
                            <asp:DropDownList ID="DDLEntries" runat="server" DataSourceID="SqlDataSourceEntries" DataTextField="id" DataValueField="id" 
                            AutoPostBack="true" OnDataBound="EntriesBound" CssClass="form-control hidden" >                
                            </asp:DropDownList>
                            <a class="btn btn-default btn-ghost" data-toggle="collapse" data-target="#selections" aria-expanded="false">See My Selections</a>
                        </div>                
                        <div class="row"></div>
                        <div class="row">
                            <div class="col-xs-12 col-lg-9 pull-right">
                                <div id="selections" class="collapse">
                                    <uc1:myselections runat="server" tournamentid='<%# Convert.ToInt64(Request.QueryString["id"]) %>' id="myselections" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>                
                </div>
                
                <asp:SqlDataSource ID="SqlDataSourceEntries" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
                            SelectCommand="SELECT * FROM tourn_entry WHERE (tournid = @id) AND (userid = @userid)">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="id" QueryStringField="id" />
                                <asp:SessionParameter Name="userid" SessionField="userid" />
                            </SelectParameters>
                </asp:SqlDataSource>
                



                <!--Repeater for tab menu-->
                <div id="race-repeater" class="row row-tabs" role="tabpanel">
                    <div class="">
                    <nav class="navbar navbar-custom" role="navigation">
                        <!-- Brand and toggle get grouped for better mobile display -->
                            <div class="navbar-header">
                                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#races-navbar-collapse">
                                    <span class="sr-only">Toggle navigation</span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                                <a class="navbar-brand" href="#">Races</a>
                            </div>
                <div id="tabs-v1" class="tabs-top tabs-justified-top">                                        
                <asp:Repeater ID="RepeaterRacesMenu" runat="server" DataSourceID="SqlDataSourceRaces">
                    <HeaderTemplate>     
                        <div class="collapse navbar-collapse" id="races-navbar-collapse">
                        <div id="tabs-inner" class="tabs-top tabs-justified-top">
                        <ul id="tabs" class="nav nav-tabs nav-justified" role="tablist">
                    </HeaderTemplate>                    
                    <ItemTemplate>

                        <li class='<%# (Container.ItemIndex == 0) ? "active" : "" %>'>
                            <a href='<%# "#ui-tabs-" + (Container.ItemIndex + 1) %>' role="tab" aria-controls='<%# "ui-tabs-" + Eval("rnum") %>' data-toggle="tab"><%# Eval("abbrev") + " " + Eval("rnum") %></a>
                        </li>
                    </ItemTemplate>
                    <FooterTemplate>
                        <!--
                        <li id="lastTab">
                            <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
                              More <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu" id="collapsed">
              
                            </ul>
                          </li>-->
                        </ul>
                        </div>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>
                <!--Repeater with all races-->
                <div class="tab-content">
                <asp:Repeater ID="RepeaterRaces" runat="server" DataSourceID="SqlDataSourceRaces"> 
                    <ItemTemplate>
                        <asp:HiddenField ID="HFRaceid" runat="server" Value='<%# Eval("raceid") %>' />
                        <div id='<%# "ui-tabs-" + (Container.ItemIndex + 1) %>' class='<%# (Container.ItemIndex == 0) ? "tab-pane fade in active" : "tab-pane fade" %>'>
                            <!--featured items for the race-->                                                                                                  
                        <div class="row">
                        <div class="col-xs-12 col-md-4">
                            <div class="visible-xs visible-sm">
                                <span class="hr-before title-sm"><%# Eval("abbrev") + " " + Eval("rnum") %></span></div>
                                                <b>
                                                <%# shared.FormatNumber(Convert.ToInt32(Eval("purse"))) + " " + Eval("rtype") + ": "%>
                                                <asp:Label ID="Label2" runat="server" Text='<%# " Claiming Price: " + Eval("claimamt","{0:C0}") %>' Visible='<%# String.IsNullOrEmpty(Eval("claimamt").ToString()) ? false : Convert.ToInt32(Eval("claimamt")) > 0 %>' />
                                                <%# " For " + Eval("age_restr") %> 
                                                <small style="color:lightgray" ><%# "#" + Eval("raceid") %></small>                                            
                                                </b>
                                                <div class="fw-inputgroup">
                                                    <div class="input-group">
                                                        <div class="input-group-addon">Post Time: </div>
                                                        <div class="form-control"><%# shared.ConvertDateTimeToLocalTime(shared.ReFormatTime(Convert.ToDateTime(Eval("rdate")), Eval("rtime").ToString()), Convert.ToInt64(Eval("track")), user_functions.GetTimeOffset(Membership.GetUser().ProviderUserKey.ToString())).ToShortTimeString() %></div>
                                                    </div>
                                                    <div class="input-group">
                                                        <div class="input-group-addon">Distance: </div>
                                                        <div class="form-control"><%# Eval("distance") %></div>
                                                    </div>
                                                    <div class="input-group">
                                                        <div class="input-group-addon">Surface: </div>
                                                        <div class="form-control"><asp:Label id="Label3" runat="server" Text='<%# Eval("surface") %>' ForeColor='<%# shared.GetColor(Eval("surface").ToString())  %>' /></div>
                                                    </div>
                                                    <div class="input-group">
                                                        <div class="input-group-addon">Purse: </div>
                                                        <div class="form-control"><%# Convert.ToInt32(Eval("purse")).ToString("C0") %></div>
                                                    </div>
                                                </div>
                                                <br />
                                                <div class="col-md-12">
                                                <div class="btn btn-primary btn-ghost">
                                                    <div class="title-sm hr-before">Class</div>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("todays_cls") %>' ToolTip="Class Rating for Race" />
                                                </div>
                                                <div class="btn btn-primary btn-ghost">
                                                    <div class="title-sm hr-before">Par Time</div>
                                                    <asp:Label ID="Label5" runat="server" Text='<%# FormatParTime(Eval("partime").ToString()) %>' ToolTip="Par Time" />
                                                </div>
                                                </div>
                        </div>
                        <div class="col-xs-12 col-md-8">
                                    <div class="accordion-wrapper">
                                    <div class="panel-acc panel-group panel-group-v1 panel-group-icon-v2 icon-right accv2" id='<%# "accordion" + Eval("id") %>'  role="tablist" aria-multiselectable="false">
                                        <div class="panel panel-default ">
                                            <div class="panel-heading" id="headingInfo">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent='<%# "#accordion" + Eval("id") %>' aria-expanded="false" aria-controls='<%# "#info" + Eval("id") %>' href='<%# "#info" + Eval("id") %>' >Handicapping Info</a>
                                                </h4>
                                            </div>
                                        </div>
                                        <div id='<%# "info" + Eval("id") %>' class="panel-collapse collapse panelbordered" role="tabpanel" aria-labelledby="headingInfo">
                                               <div class="panel-body">
                                                    Info Coming Soon
                                                </div>
                                        </div>
                                            
                                                
                                        <div class="panel panel-default ">
                                            <div class="panel-heading" id="headingPicks">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent='<%# "#accordion" + Eval("id") %>' aria-expanded="true" class="acc-on" aria-controls='<%# "#ccs" + Eval("id") %>' href='<%# "#ccs" + Eval("id") %>' data-original-title="Computer Rankings">Picks</a>
                                                </h4>
                                            </div>
                                        </div>
                                        <div id='<%# "ccs" + Eval("id") %>' class="panel-collapse collapse in panelbordered" role="tabpanel" aria-labelledby="headingPicks">
                                                <div class="panel-body">
                                                    <uc1:cc_score runat="server" raceid='<%# Convert.ToInt64(Eval("id")) %>' id="cc_score" />
                                                </div>
                                        </div>
                                    </div>
                                    </div>
                         
                                    
                        </div>
                        </div>
                        <asp:UpdatePanel ID="UP_RaceCard" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true" >
                        <ContentTemplate>                                                
                        <!--results-->
                        <div class="row">
                            <div class="col-xs-12">                            
                            <div id="div_resultscontainer" runat="server" class="panel panel-danger" style="margin-top:10px;" visible='<%# GVResults.Rows.Count > 0 %>' >
                                <div class="panel-heading">Results</div>
                            
        <asp:GridView ID="GVResults" runat="server" DataSourceID="SqlDataSourceResults" CssClass="table mobilecolumnfriendly" GridLines="None" AutoGenerateColumns="False" HeaderStyle-CssClass="active">
            <Columns>
                <asp:TemplateField HeaderText="Horse" ItemStyle-CssClass="visible-xs" HeaderStyle-CssClass="visible-xs">
                    <ItemTemplate>
                        <div class="row">
                            <div class="col-xs-2">
                                <div class='<%# "blanket horse" + races.GetSaddleClothNumber(Eval("program").ToString()) %>'>
                                    <asp:Label ID="LabelProgram" runat="server" Text='<%# Eval("program") %>'  Width="22px" ToolTip='<%# "Program Number: " + Eval("program") + " / Post Number: " + Eval("post") %>' />
                                </div>                                         
                            </div>
                            <div class="col-xs-6"><%# Eval("name") %></div>
                            <div class="col-xs-2">
                                <asp:Label ID="LabelRank" runat="server" Text='<%# Eval("ccrank") %>' />                        
                                <i id="I1" class="fa fa-plus" runat="server" visible='<%# Convert.ToBoolean(Eval("livelongshot")) %>'></i>

                            </div>
                            <div class="col-xs-2">
                                <asp:Label ID="LabelScore" runat="server" Text='<%# Eval("ccscore","{0:p0}") + " <i>[" + Eval("ccpoints") + "]</i>" %>' />
                            </div>
                        </div>
                        <div class="row text-right">
                            <div class="col-xs-4">Win</div>
                            <div class="col-xs-4">Place</div>
                            <div class="col-xs-4">Show</div>
                        </div>
                        <div class="row text-right">
                            <div class="col-xs-4"><asp:Label ID="LabelPayout" runat="server" Text='<%# Convert.ToDouble(Eval("winpayoff")) > 0 ? Convert.ToDouble(Eval("winpayoff")).ToString("C2") : "-" %>' /></div>
                            <div class="col-xs-4"><asp:Label ID="Label6" runat="server" Text='<%# Convert.ToDouble(Eval("placepayoff")) > 0 ? Convert.ToDouble(Eval("placepayoff")).ToString("C2") : "-" %>' /></div>
                            <div class="col-xs-4"><asp:Label ID="Label7" runat="server" Text='<%# Convert.ToDouble(Eval("showpayoff")) > 0 ? Convert.ToDouble(Eval("showpayoff")).ToString("C2") : "-" %>' /></div>
                        </div>
                        
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" >
                    <ItemTemplate>                        
                        <div style="max-width:25px;" class='<%# "blanket horse" + races.GetSaddleClothNumber(Eval("program").ToString()) %>'>
                            <asp:Label ID="LabelProgram" runat="server" Text='<%# Eval("program") %>'  Width="22px" ToolTip='<%# "Program Number: " + Eval("program") + " / Post Number: " + Eval("post") %>' />
                        </div>                                         
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs"  DataField="name" HeaderText="Horse" SortExpression="name" />
                <asp:TemplateField HeaderText="Win" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" >
                    <ItemTemplate>
                        <asp:Label ID="LabelPayout" runat="server" Text='<%# Convert.ToDouble(Eval("winpayoff")) > 0 ? Eval("winpayoff") : "-" %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Place" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" >
                    <ItemTemplate>
                        <asp:Label ID="LabelPayout" runat="server" Text='<%# Convert.ToDouble(Eval("placepayoff")) > 0 ? Eval("placepayoff") : "-" %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Show" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" >
                    <ItemTemplate>
                        <asp:Label ID="LabelPayout" runat="server" Text='<%# Convert.ToDouble(Eval("showpayoff")) > 0 ? Eval("showpayoff") : "-" %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="officialfinish" HeaderText="Finish" SortExpression="officialfinish" Visible="false" />
                <asp:TemplateField  HeaderText="TL Rank" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" >
                    <ItemTemplate>
                        <asp:Label ID="LabelRank" runat="server" Text='<%# Eval("ccrank") %>' />                        
                        <i id="I1" class="fa fa-plus" runat="server" visible='<%# Convert.ToBoolean(Eval("livelongshot")) %>'></i>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="TL Score" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs" >
                    <ItemTemplate>
                        <asp:Label ID="LabelScore" runat="server" Text='<%# Eval("ccscore","{0:p0}") + " <i>[" + Eval("ccpoints") + "]</i>" %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ccrank" HeaderText="Rank" SortExpression="ccrank" Visible="false" />
                <asp:BoundField DataField="ccpoints" HeaderText="TL points" SortExpression="ccpoints" Visible="false" />
                <asp:CheckBoxField DataField="livelongshot" HeaderText="livelongshot" SortExpression="livelongshot" Visible="false" />
                <asp:BoundField DataField="ccscore" HeaderText="TL score" SortExpression="ccscore" Visible="false" />
                
            </Columns>
        </asp:GridView>                
                                <div class="panel-body">
                                    
                                <asp:FormView ID="FVExotics" runat="server" RenderOuterTable="false" DataSourceID="SqlDataSourceResults">
                                    <ItemTemplate>
                                        <div class="col-xs-12">Exotics</div>
                                        <div class="col-xs-3">
                                            <div class="input-group">
                                                <div class="input-group-addon">
                                                    <%# Convert.ToBoolean(Eval("ex_cold")) ? "<i style=\"color:blue\" class=\"fa fa-cubes fa-fw\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Exacta Predicted (Cold)\"></i>" : "" %>
                                                    <%# Convert.ToBoolean(Eval("ex_box")) ? "<i class=\"fa fa-bomb fa-fw\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Exacta Predicted (Box)\"></i>" :  "" %>
                                                    <%# Convert.ToBoolean(Eval("ex_boxplusone")) ? "<i class=\"fa fa-check fa-fw\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Exacta Predicted (Box Plus One)\"></i>" :  "" %>
                                                    Exacta</div>
                                                <div class="form-control"><%# Eval("exacta","{0:c2}") %></div>
                                            </div>
                                        </div>
                                        <div class="col-xs-3">
                                            <div class="input-group">
                                                <div class="input-group-addon">
                                                    <%# Convert.ToBoolean(Eval("tri_cold")) ? "<i style=\"color:blue\" class=\"fa fa-cubes fa-fw\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Trifecta Predicted (Cold)\"></i>" : "" %>
                                                    <%# Convert.ToBoolean(Eval("tri_box")) ? "<i class=\"fa fa-bomb fa-fw\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Trifecta Predicted (Box)\"></i>" :  "" %>
                                                    <%# Convert.ToBoolean(Eval("tri_boxplusone")) ? "<i class=\"fa fa-check fa-fw\" data-toggle=\"tooltip\" data-placement=\"top\" title=\"Trifecta Predicted (Box Plus One)\"></i>" :  "" %>
                                                    Trifecta</div>
                                                <div class="form-control"><%# Eval("trifecta","{0:c2}") %></div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:FormView>

                                </div>

                            </div>
                            
                            </div>
                        </div>

                        <div class="row">
                                                
                            <br />
                                <!--Speed Rating-->
                                <div class="col-xs-12 col-md-4 col-lg-offset-3 col-lg-3">     
                                <div class="panel panel-default ">
                                    <div class="panel-heading">Top Last SR</div>                                
                                    <div class="list-group">
                                <asp:Repeater ID="RepeaterTopSR" runat="server" DataSourceID="SqlDataSourceSR">
                                    <ItemTemplate>
                                        <div class="list-group-item">
                                            <asp:Label ID="LabelHorse" runat="server" Text='<%# System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(Eval("name").ToString().ToLower()) %>' CssClass=""   />
                                            <asp:Label ID="LabelProgram" runat="server" Text='<%#" <sup>" + Eval("program") + "</sup>" %>' ToolTip="Program #" />
                                        
                                            <span class="badge"><%# Eval("SR") %></span>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <asp:SqlDataSource ID="SqlDataSourceSR" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
                                    SelectCommand="SELECT TOP (3) *, (SELECT name FROM      entries WHERE   entries.id = entryid) AS name, (SELECT program FROM      entries WHERE   entries.id = entryid) AS program FROM     (SELECT ROW_NUMBER() OVER (PARTITION BY ENTRYID ORDER BY rdate DESC) AS RowNum, SR, rdate, entryid FROM pp WHERE  entryid IN (SELECT id FROM      entries WHERE   raceid = @raceid) AND (rtype <> 'SCR')) mytable WHERE  rownum < 2 ORDER BY SR DESC">
                                    <SelectParameters>
                                        <asp:ControlParameter Name="raceid" ControlID="HFRaceid" PropertyName="Value" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                    </div>
                                </div>
                                </div>
                                <!--LIFETIME Speed Rating-->
                                <div class="col-xs-12 col-md-4 col-lg-3"> 
                                    <div class="panel panel-default ">
                                    <div class="panel-heading">Top AVG SR</div>                               
                                    <div class="list-group">
                                <asp:Repeater ID="RepeaterSR" runat="server" DataSourceID="SqlDataSourceAVGSR">
                                    <ItemTemplate>
                                        <div class="list-group-item">
                                            <asp:Label ID="LabelHorse" runat="server" Text='<%# System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(Eval("name").ToString().ToLower()) %>' CssClass=""   />
                                            <asp:Label ID="LabelProgram" runat="server" Text='<%#" <sup>" + Eval("program") + "</sup>" %>' ToolTip="Program #" />
                                            <span class="badge"><%# Eval("avgrating")%></span>
                                        </div>                                        
                                    </ItemTemplate>
                                </asp:Repeater>
                                <asp:SqlDataSource ID="SqlDataSourceAVGSR" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
                                    SelectCommand="SELECT TOP (3) name, program, (SELECT AVG(sr) AS Expr1 FROM      pp WHERE   (entryid = e.id) AND (sr > 0) AND (rtype <> 'SCR')) AS avgrating FROM     entries AS e WHERE  (raceid = @raceid) ORDER BY avgrating DESC">
                                    <SelectParameters>
                                        <asp:ControlParameter Name="raceid" ControlID="HFRaceid" PropertyName="Value" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                    </div>
                                </div>
                                </div>
                                <!--Class Rating-->
                                <div class="col-xs-12 col-md-4 col-lg-3">
                                    <div class="panel panel-default ">
                                    <div class="panel-heading">Top Class</div>
                                    <div class="list-group">
                                <asp:Repeater ID="Repeaterclass" runat="server" DataSourceID="SqlDataSourceClass">
                                    <ItemTemplate>
                                        <div class="list-group-item">
                                            <asp:Label ID="LabelHorse" runat="server" Text='<%# System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(Eval("name").ToString().ToLower()) %>' CssClass=""   />
                                            <asp:Label ID="LabelProgram" runat="server" Text='<%#" <sup>" + Eval("program") + "</sup>" %>' ToolTip="Program #" />
                                            <span class="badge"><%# Eval("avgrating")%></span>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                                <asp:SqlDataSource ID="SqlDataSourceClass" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
                                    SelectCommand="SELECT TOP (3) name, program, (SELECT AVG(classratin) AS Expr1 FROM pp WHERE (entryid = e.id) AND (classratin > 0) AND (rtype <> 'SCR')) AS avgrating FROM entries AS e WHERE  (raceid = @raceid) ORDER BY avgrating DESC">
                                    <SelectParameters>
                                        <asp:ControlParameter Name="raceid" ControlID="HFRaceid" PropertyName="Value" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                        </div>
                                </div>
                                </div>
                        
                        </div>

                        <div class="row">
                        <div class="">
                            <asp:Label ID="LabelChangeView" runat="server" CssClass="" onclick="ChangeView()" ><i class="toggleswitch fa fa-2x fa-toggle-on" style="color:#27AE60;"></i></asp:Label>
                            
                            <asp:Repeater ID="RPT_Horses" runat="server" DataSourceID="SqlDataSourceRDetails">
                                <ItemTemplate>                                
                                    <div class='<%# "horsecard horsecard_compressed "+ isSelected(Convert.ToInt32(races.GetSaddleClothNumber(Eval("program").ToString())), Convert.ToInt64(Eval("raceid"))) %>'>
                                        <div class='<%# "panel-body horsecardbg horsecardpanel "  + GetPickCSS(Convert.ToInt32(Eval("ccrank"))) %>' data-program='<%# races.GetSaddleClothNumber(Eval("program").ToString()) %>' data-raceid='<%# Eval("raceid") %>' >
                                        <span class="cpupick" runat="server" visible='<%# Convert.ToInt16(Eval("ccrank")) <= 3 %>' title='<%# "TL Rank: " + Eval("ccrank") %>'></span>
                                        <div class="">                                            
                                    <div class="col-md-5 col-sm-8 col-xs-8">
                                        
                                        <div class="row">
                                        <div class="col-xs-2 col-lg-1 text-center">
                                            <asp:HiddenField ID="HFentryid" runat="server" Value='<%# Eval("id") %>' />
                                            
                                            <div class="hidden-xs">
                                                <div class="row">
                                                <div style="max-width:25px;" class='<%# "blanket horse" + races.GetSaddleClothNumber(Eval("program").ToString()) %>'>
                                                    <asp:Label ID="LabelProgram" runat="server" Text='<%# Eval("program") %>'  Width="22px" ToolTip='<%# "Program Number: " + Eval("program") + " / Post Number: " + Eval("post") %>' />
                                                </div>       
                                                </div>
                                                <div class="row visisble-sm">
                                                <asp:Label ID="Label8" runat="server" CssClass="font-xs visible-sm" Text='<%# shared.FracToDouble(Eval("morningline").ToString()).ToString("#.#") %>' data-toggle="tooltip" data-placement="right" data-original-title="Morning Line Odds"></asp:Label>
                                                </div>
                                            </div>
                                            <div class="visible-xs">
                                                <div style="max-width:20px;" class='<%# "blanket blanket_s horse" + races.GetSaddleClothNumber(Eval("program").ToString()) %>'>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("program") %>'  Width="18px" ToolTip='<%# "Program Number: " + Eval("program") + " / Post Number: " + Eval("post") %>' />
                                                </div>  
                                                <br /> 
                                                <asp:Label ID="LabelOdds" runat="server" CssClass="font-xs" Text='<%# shared.FracToDouble(Eval("morningline").ToString()).ToString("#.#") %>' data-toggle="tooltip" data-placement="right" data-original-title="Morning Line Odds"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="col-xs-10 col-lg-11">
                                            <asp:Label ID="LabelRank" runat="server" Text='<%# Eval("ccrank").ToString().Trim() == "1" ? "<i class=\"fa fa-diamond\"></i>" : Eval("ccrank").ToString().Trim() == "2" ? "<i class=\"fa fa-certificate\"></i>" : Eval("ccrank").ToString().Trim() == "3" ? "<i class=\"fa fa-thumbs-o-up\"></i>" : Eval("ccrank").ToString().Trim() == "4" ? "<i class=\"fa fa-certificate\"></i>" : "" %>' CssClass="ccrank" Visible='<%# Convert.ToInt32(Eval("ccrank")) <= 3 && Convert.ToDouble(Eval("ccscore")) >= .30 %>' ToolTip='<%# "Rank : " + Eval("ccscore","{0:p0}") %>' ></asp:Label>
                                            <span data-poload='<%# "../tooltips/edetails.aspx?eid=" + Eval("id") %>' data-placement="right" id='<%# "ed" + Eval("id") %>' data-original-title="Entry Details:" style="text-decoration:none;">
                                                <asp:Label ID="LabelHorse" runat="server" Text='<%# System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(Eval("name").ToString().ToLower()) %>' CssClass="text-success" Font-Strikeout='<%# Eval("scratched") %>'  />
                                            </span>
                                        <asp:Label ID="LabelBreeding" runat="server" Text='<%# Eval("sirename") + " - " + Eval("damname")  %>' Font-Size="X-Small" ForeColor="GrayText" CssClass="blockstyle" />
                                        <asp:Label ID="LabelOwners" runat="server" Text='<%# Eval("owner") %>' Font-Size="X-Small" CssClass="blockstyle" /> 
                                        
                                        
                                        <div class="visible-xs visible-sm">
                                            <br />
                                            <asp:Label ID="LabelJockeyXS" runat="server" Text='<%# Eval("jockey") %>' Font-Size="X-Small" ForeColor="GrayText" CssClass="" data-poload='<%# "../tooltips/jockey.aspx?eid=" + Eval("id") %>' data-placement="top" data-original-title="Jockey Stats" />
                                            <br />
                                            <asp:Label ID="LabelTrainerXS" runat="server" Text='<%# Eval("trainer") %>' CssClass="" data-poload='<%# "../tooltips/trainer.aspx?eid=" + Eval("id") %>' data-placement="top" data-original-title="Trainer Stats" Font-Size="Small"  />
                                        </div>
                                        </div>
                                        </div>
                                    </div>
                                    <div class="col-md-2 hidden-xs hidden-sm">
                                        <div class="row">
                                            <asp:Label ID="LabelJockey" runat="server" Text='<%# Eval("jockey") %>' Font-Size="X-Small" ForeColor="GrayText" CssClass="" data-poload='<%# "../tooltips/jockey.aspx?eid=" + Eval("id") %>' data-placement="top" data-original-title="Jockey Stats" />
                                        </div>
                                        <div class="row">
                                            <asp:Label ID="LabelTrainer" runat="server" Text='<%# Eval("trainer") %>' CssClass="" data-poload='<%# "../tooltips/trainer.aspx?eid=" + Eval("id") %>' data-placement="top" data-original-title="Trainer Stats" Font-Size="Small"  />
                                        </div>
                                    </div>
                                    <div class="col-md-2 hidden-xs hidden-sm">
                                        <div class="fracodds" style="font-family: 'Minion Pro';" data-toggle="tooltip" title='<%#  shared.FracToDouble(Eval("morningline").ToString())  %>'>
                                        <sup><%# shared.GetFractionNum(Eval("morningline").ToString()) %></sup>
                                        &frasl;
                                        <sub><%# shared.GetFractionDenom(Eval("morningline").ToString()) %></sub>
                                        </div>
                                        <div class="visible-lg">
                                        <br />
                                            <div class="progress progress-sm" data-toggle="tooltip" title='<%# "TL Score: " + Convert.ToInt16(Convert.ToDouble(Eval("ccscore")) * 100) + "%"  %>'>
                                                <div class="progress-bar" role="progressbar" aria-valuenow='<%# Convert.ToDouble(Eval("ccscore")) > 0 ? Convert.ToInt16(Convert.ToDouble(Eval("ccscore")) * 100) : 0 %>' aria-valuemin="-2" aria-valuemax="60" >
                                                  <span class="sr-only">TL Score</span>
                                                  <div runat="server" id="div_bartxt" visible='<%# Convert.ToDouble(Eval("ccscore")) > 0  %>' >
                                                    <span class="countto-bar " data-from="-2" data-speed="1250" data-refresh-interval="50" data-to='<%# Convert.ToInt16(Convert.ToDouble(Eval("ccscore")) * 100) %>'><%# Convert.ToInt16(Convert.ToDouble(Eval("ccscore")) * 100) %></span>
                                                   </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-xs-4">
                                            <asp:Button ID="ButtonSelect" runat="server" Text="Select" Enabled='<%# Convert.ToBoolean(Eval("ropen")) %>' CssClass="btn btn-ghost btn-primary btn-xs" CommandArgument='<%# Eval("id") %>' UseSubmitBehavior="false" OnClick='<%# "return savePick(" + Eval("id") + ",this)" %>' />
                                             <br class="visible-sm visible-xs" />                                                   
                                                <asp:Label ID="LabelWin" runat="server" Text='<%# entries.WinStreak(Convert.ToInt64(Eval("id"))) %>' Visible='<%# entries.WinStreak(Convert.ToInt64(Eval("id"))) > 0  %>' CssClass="winstreak" data-toggle="tooltip" data-placement="top" title="Current Win Streak"/>
                                                <asp:Image ID="IMGBeatenFav" runat="server" ImageUrl="~/images/icons/bullseye.png" Height="15px" Visible='<%# entries.BeatenFav(Convert.ToInt64(Eval("id"))) %>' data-toggle="tooltip" data-placement="top" title="Beaten favorite last race" />
                                                <asp:Image ID="ImageJock" runat="server" ImageURL="~/images/icons/jockey.png" Height="15px"  Visible='<%# (Convert.ToDouble(Eval("jockey_30_wins")) / Convert.ToDouble(Eval("jockey_30_starts"))) >= .20  %>' data-toggle="tooltip" data-placement="top" title='<%# "Last 30 Days Jockey Win " + (Convert.ToDouble(Eval("jockey_30_wins")) / Convert.ToDouble(Eval("jockey_30_starts"))).ToString("p0") + " (" + Eval("jockey_30_starts") + ":" + Eval("jockey_30_wins") + "-" + Eval("jockey_30_places") + "-" + Eval("jockey_30_shows") + ")" %>' />
                                                <asp:Image ID="ImageTrain" runat="server" ImageURL="~/images/icons/train_1.png" Height="15px"  Visible='<%# (Convert.ToDouble(Eval("trainer_30_wins")) / Convert.ToDouble(Eval("trainer_30_starts"))) >= .30  %>' data-toggle="tooltip" data-placement="top" title='<%# "Last 30 Days Trainer Win " + (Convert.ToDouble(Eval("trainer_30_wins")) / Convert.ToDouble(Eval("trainer_30_starts"))).ToString("p0") + " (" + Eval("trainer_30_starts") + ":" + Eval("trainer_30_wins") + "-" + Eval("trainer_30_places") + "-" + Eval("trainer_30_shows") + ")" %>' />
                                                <asp:Image ID="IMGJockTrain" runat="server" ImageURL="~/images/icons/fire.png" Height="15px" Visible='<%# (Convert.ToDouble(Eval("JOCK_TRAN_wins")) / Convert.ToDouble(Eval("JOCK_TRAN_starts"))) >= .30  %>' data-toggle="tooltip" data-placement="top" title='<%# "Trainer/Jock Winning at " + (Convert.ToDouble(Eval("JOCK_TRAN_wins")) / Convert.ToDouble(Eval("JOCK_TRAN_starts"))).ToString("p0") + " (" + Eval("JOCK_TRAN_starts") + ":" + Eval("JOCK_TRAN_wins") + "-" + Eval("JOCK_TRAN_places") + "-" + Eval("JOCK_TRAN_shows") + ")" %>' />
                                                <asp:Image ID="IMGDistCrs" runat="server" ImageURL="~/images/icons/key.png" Height="15px"  Visible='<%# (Convert.ToDouble(Eval("DST_CRS_wins")) / Convert.ToDouble(Eval("DST_CRS_starts"))) >= .30  %>' data-toggle="tooltip" data-placement="top" title='<%# "Distance and Course Win " + (Convert.ToDouble(Eval("DST_CRS_wins")) / Convert.ToDouble(Eval("DST_CRS_starts"))).ToString("p0") + " (" + Eval("DST_CRS_starts") + ":" + Eval("DST_CRS_wins") + "-" + Eval("DST_CRS_places") + "-" + Eval("DST_CRS_shows") + ")" %>' />
                                                <asp:HiddenField ID="HFRaceid" runat="server" Value='<%# Eval("raceid") %>' />
                                                <asp:HiddenField ID="HFProgram" runat="server" Value='<%# Regex.Replace(Eval("program").ToString(), @"[a-zA-Z\s]+", string.Empty)  %>' />
                                           <div class="hidden-xs pull-right">
                                            <span data-poload='<%# "../tooltips/workouts.aspx?entryid=" + Eval("id")%>' data-placement="left" id='<%# "wr" + Eval("id") %>' data-original-title="Workout Data" style="text-decoration:none;">
                                                <i class="fa fa-newspaper-o"></i>
                                            </span>
                                            <a href="javascript:;" class="pploader" data-toggle="collapse" data-target='<%# "#ppexp" + Eval("id") %>' rel='<%# Eval("id") %>' >
                                                <img id="Img1" style="cursor: pointer" src="/images/plus.png" runat="server" visible='<%# entries.GetStartCount(Convert.ToInt64(Eval("id"))) > 0 %>' />
                                            </a>
                                            </div>
                                            <div class="visible-xs text-right pull-right">
                                                <span data-poload='<%# "../tooltips/workouts.aspx?entryid=" + Eval("id")%>' data-placement="left" id='<%# "wr" + Eval("id") %>' data-original-title="Workout Data" style="text-decoration:none;">
                                                <i class="fa fa-newspaper-o"></i>
                                                </span>
                                                <br />
                                                <a href="javascript:;" class="pploader" data-toggle="collapse" data-target='<%# "#ppexp" + Eval("id") %>' rel='<%# Eval("id") %>' >
                                                    <img style="cursor: pointer" src="/images/plus.png" runat="server" visible='<%# entries.GetStartCount(Convert.ToInt64(Eval("id"))) > 0 %>' />
                                                </a>
                                            </div>
                                        </div>
                 
                                        </div>
                                        
                                        </div>
                                        
                                            <div id='<%# "ppexp" + Eval("id") %>' class="collapse inlinepp">                                            
                                                    <div id='<%# "ppcontent" + Eval("id")  %>'>Loading Race History </div>                        
                                            </div>
                                        
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="alumnbg">
                        <asp:GridView ID="GVHorses" runat="server" Visible="false" DataSourceID="SqlDataSourceRDetails" DataKeyNames="post" 
                            OnRowDataBound="HorsesDataBound" OnRowCommand="HorseSelected" OnDataBound="HorsesLoaded" HeaderStyle-CssClass="active"
                            AutoGenerateColumns="False" CssClass="table table-hover_cust" GridLines="None" SelectedRowStyle-CssClass="gvselected">
                            <Columns>
                                <asp:TemplateField ItemStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="HFentryid" runat="server" Value='<%# Eval("id") %>' />
                                        <span class="cpupick" runat="server" visible='<%# Convert.ToInt16(Eval("ccrank")) <= 3 %>' title='<%# "TL Rank: " + Eval("ccrank") %>'></span>
                                        <div class="hidden-xs">
                                            <div style="max-width:25px;" class='<%# "blanket horse" + races.GetSaddleClothNumber(Eval("program").ToString()) %>'>
                                                <asp:Label ID="LabelProgram" runat="server" Text='<%# Eval("program") %>'  Width="22px" ToolTip='<%# "Program Number: " + Eval("program") + " / Post Number: " + Eval("post") %>' />
                                            </div>       
                                        </div>
                                        <div class="visible-xs">
                                            <div style="max-width:20px;" class='<%# "blanket blanket_s horse" + races.GetSaddleClothNumber(Eval("program").ToString()) %>'>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("program") %>'  Width="18px" ToolTip='<%# "Program Number: " + Eval("program") + " / Post Number: " + Eval("post") %>' />
                                            </div>  
                                            <br /> 
                                            <asp:Label ID="LabelOdds" runat="server" CssClass="font-xs" Text='<%# shared.FracToDouble(Eval("morningline").ToString()).ToString("#.#") %>' data-toggle="tooltip" data-placement="right" data-original-title="Morning Line Odds"></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Horse" >
                                    <ItemTemplate>
                                        <div class="col-xs-9 col-lg-11">                                            
                                            <asp:Label ID="LabelRank" runat="server" Text='<%# Eval("ccrank").ToString().Trim() == "1" ? "<i class=\"fa fa-diamond\"></i>" : Eval("ccrank").ToString().Trim() == "2" ? "<i class=\"fa fa-certificate\"></i>" : Eval("ccrank").ToString().Trim() == "3" ? "<i class=\"fa fa-thumbs-o-up\"></i>" : Eval("ccrank").ToString().Trim() == "4" ? "<i class=\"fa fa-certificate\"></i>" : "" %>' CssClass="ccrank" Visible='<%# Convert.ToInt32(Eval("ccrank")) <= 3 && Convert.ToDouble(Eval("ccscore")) >= .30 %>' ToolTip='<%# "Rank : " + Eval("ccscore","{0:p0}") %>' ></asp:Label>
                                            <span data-poload='<%# "../tooltips/edetails.aspx?eid=" + Eval("id") %>' data-placement="right" id='<%# "ed" + Eval("id") %>' data-original-title="Entry Details:" style="text-decoration:none;">
                                                <asp:Label ID="LabelHorse" runat="server" Text='<%# System.Globalization.CultureInfo.CurrentCulture.TextInfo.ToTitleCase(Eval("name").ToString().ToLower()) %>' CssClass="text-success" Font-Strikeout='<%# Eval("scratched") %>'  />
                                            </span>
                                        <asp:Label ID="LabelBreeding" runat="server" Text='<%# Eval("sirename") + " - " + Eval("damname")  %>' Font-Size="X-Small" ForeColor="GrayText" CssClass="blockstyle" />
                                        <asp:Label ID="LabelOwners" runat="server" Text='<%# Eval("owner") %>' Font-Size="X-Small" CssClass="nomobile blockstyle" /> 
                                        </div>
                                        
                                        <div class="col-xs-12 visible-xs visible-sm">
                                            <asp:Label ID="LabelJockeyXS" runat="server" Text='<%# Eval("jockey") %>' Font-Size="X-Small" ForeColor="GrayText" CssClass="" data-poload='<%# "../tooltips/jockey.aspx?eid=" + Eval("id") %>' data-placement="top" data-original-title="Jockey Stats" />
                                            <br />
                                            <asp:Label ID="LabelTrainerXS" runat="server" Text='<%# Eval("trainer") %>' CssClass="" data-poload='<%# "../tooltips/trainer.aspx?eid=" + Eval("id") %>' data-placement="top" data-original-title="Trainer Stats" Font-Size="Small"  />
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle />

                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-CssClass="hidden-xs hidden-sm" ItemStyle-CssClass="hidden-xs hidden-sm">
                                    <ItemTemplate>
                                        <div class="row">
                                            <asp:Label ID="LabelJockey" runat="server" Text='<%# Eval("jockey") %>' Font-Size="X-Small" ForeColor="GrayText" CssClass="" data-poload='<%# "../tooltips/jockey.aspx?eid=" + Eval("id") %>' data-placement="top" data-original-title="Jockey Stats" />
                                        </div>
                                        <div class="row">
                                            <asp:Label ID="LabelTrainer" runat="server" Text='<%# Eval("trainer") %>' CssClass="" data-poload='<%# "../tooltips/trainer.aspx?eid=" + Eval("id") %>' data-placement="top" data-original-title="Trainer Stats" Font-Size="Small"  />
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>                
                                <asp:TemplateField HeaderText="ML" ItemStyle-CssClass="hidden-xs" HeaderStyle-CssClass="hidden-xs">
                                    <ItemTemplate>                                        
                                        <div style="font-size:25px;font-family: 'Minion Pro';" data-toggle="tooltip" title='<%#  shared.FracToDouble(Eval("morningline").ToString())  %>'>
                                        <sup><%# shared.GetFractionNum(Eval("morningline").ToString()) %></sup>
                                        &frasl;
                                        <sub><%# shared.GetFractionDenom(Eval("morningline").ToString()) %></sub>
                                        </div>
                                        
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>                                                        
                                            <asp:Button ID="ButtonSelect" runat="server" Text="Select" Enabled='<%# Convert.ToBoolean(Eval("ropen")) %>' CssClass="btn btn-ghost btn-primary btn-xs" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' />
                                             <br class="visible-sm visible-xs" />                                                   
                                                <asp:Label ID="LabelWin" runat="server" Text='<%# entries.WinStreak(Convert.ToInt64(Eval("id"))) %>' Visible='<%# Convert.ToBoolean(Eval("winstreak")) %>' CssClass="winstreak" data-toggle="tooltip" data-placement="top" title="Current Win Streak"/>
                                                <asp:Image ID="IMGBeatenFav" runat="server" ImageUrl="~/images/icons/bullseye.png" Height="15px" Visible='<%# entries.BeatenFav(Convert.ToInt64(Eval("id"))) %>' data-toggle="tooltip" data-placement="top" title="Beaten favorite last race" />
                                                <asp:Image ID="ImageJock" runat="server" ImageURL="~/images/icons/jockey.png" Height="15px"  Visible='<%# (Convert.ToDouble(Eval("jockey_30_wins")) / Convert.ToDouble(Eval("jockey_30_starts"))) >= .20  %>' data-toggle="tooltip" data-placement="top" title='<%# "Last 30 Days Jockey Win " + (Convert.ToDouble(Eval("jockey_30_wins")) / Convert.ToDouble(Eval("jockey_30_starts"))).ToString("p0") + " (" + Eval("jockey_30_starts") + ":" + Eval("jockey_30_wins") + "-" + Eval("jockey_30_places") + "-" + Eval("jockey_30_shows") + ")" %>' />
                                                <asp:Image ID="ImageTrain" runat="server" ImageURL="~/images/icons/train_1.png" Height="15px"  Visible='<%# (Convert.ToDouble(Eval("trainer_30_wins")) / Convert.ToDouble(Eval("trainer_30_starts"))) >= .30  %>' data-toggle="tooltip" data-placement="top" title='<%# "Last 30 Days Trainer Win " + (Convert.ToDouble(Eval("trainer_30_wins")) / Convert.ToDouble(Eval("trainer_30_starts"))).ToString("p0") + " (" + Eval("trainer_30_starts") + ":" + Eval("trainer_30_wins") + "-" + Eval("trainer_30_places") + "-" + Eval("trainer_30_shows") + ")" %>' />
                                                <asp:Image ID="IMGJockTrain" runat="server" ImageURL="~/images/icons/fire.png" Height="15px" Visible='<%# (Convert.ToDouble(Eval("JOCK_TRAN_wins")) / Convert.ToDouble(Eval("JOCK_TRAN_starts"))) >= .30  %>' data-toggle="tooltip" data-placement="top" title='<%# "Trainer/Jock Winning at " + (Convert.ToDouble(Eval("JOCK_TRAN_wins")) / Convert.ToDouble(Eval("JOCK_TRAN_starts"))).ToString("p0") + " (" + Eval("JOCK_TRAN_starts") + ":" + Eval("JOCK_TRAN_wins") + "-" + Eval("JOCK_TRAN_places") + "-" + Eval("JOCK_TRAN_shows") + ")" %>' />
                                                <asp:Image ID="IMGDistCrs" runat="server" ImageURL="~/images/icons/key.png" Height="15px"  Visible='<%# (Convert.ToDouble(Eval("DST_CRS_wins")) / Convert.ToDouble(Eval("DST_CRS_starts"))) >= .30  %>' data-toggle="tooltip" data-placement="top" title='<%# "Distance and Course Win " + (Convert.ToDouble(Eval("DST_CRS_wins")) / Convert.ToDouble(Eval("DST_CRS_starts"))).ToString("p0") + " (" + Eval("DST_CRS_starts") + ":" + Eval("DST_CRS_wins") + "-" + Eval("DST_CRS_places") + "-" + Eval("DST_CRS_shows") + ")" %>' />
                                                <%# Convert.ToBoolean(Eval("improving")) ? "<i class=\"fa fa-line-chart\"></i>" : "" %>
                                                <asp:HiddenField ID="HFRaceid" runat="server" Value='<%# Eval("raceid") %>' />
                                                <asp:HiddenField ID="HFProgram" runat="server" Value='<%# Regex.Replace(Eval("program").ToString(), @"[a-zA-Z\s]+", string.Empty)  %>' />
                                        <div class="visible-xs text-right">
                                            <br /><br />
                                            <span data-poload='<%# "../tooltips/workouts.aspx?entryid=" + Eval("id")%>' data-placement="left" id='<%# "wr" + Eval("id") %>' data-original-title="Workout Data" style="text-decoration:none;">
                                            <i class="fa fa-newspaper-o"></i>
                                            </span>
                                            <br />
                                            <a href="javascript:;" class="pploader" data-toggle="collapse" data-target='<%# "#ppexp" + Eval("id") %>' rel='<%# Eval("id") %>' >
                                                <img style="cursor: pointer" src="/images/plus.png" runat="server" visible='<%# entries.GetStartCount(Convert.ToInt64(Eval("id"))) > 0 %>' />
                                            </a> 
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div class="hidden-xs">
                                        <span data-poload='<%# "../tooltips/workouts.aspx?entryid=" + Eval("id")%>' data-placement="left" id='<%# "wr" + Eval("id") %>' data-original-title="Workout Data" style="text-decoration:none;">
                                            <i class="fa fa-newspaper-o"></i>
                                        </span>
                                        <a href="javascript:;" class="pploader" data-toggle="collapse" data-target='<%# "#ppexp" + Eval("id") %>' rel='<%# Eval("id") %>' >
                                            <img id="Img1" style="cursor: pointer" src="/images/plus.png" runat="server" visible='<%# entries.GetStartCount(Convert.ToInt64(Eval("id"))) > 0 %>' />
                                        </a>
                                        </div>
                                        
                                        <tr>
                                            <td colspan="999" style="padding:0px;">
                                                <div id='<%# "ppexp" + Eval("id") %>' class="collapse">                                            
                                                    <div id='<%# "ppcontent" + Eval("id")  %>'>Loading Race History </div>                        
                                                </div>
                                            </td>
                                        </tr>
                                        
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSourceRDetails" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
                            SelectCommand="SELECT *, races.ropen FROM entries INNER JOIN races ON entries.raceid = races.id WHERE (raceid = @id) ORDER BY CONVERT(int,dbo.ReplaceNonNumericChars(program)),post">
                            <SelectParameters>
                                <asp:ControlParameter Name="id" ControlID="HFRaceid" PropertyName="Value" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                            </div>
                        </div>
                        
            <asp:SqlDataSource ID="SqlDataSourceResults" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
                SelectCommand="SELECT entries.name, entries.post, entries.program, entry_results.officialfinish, entry_results.winpayoff, entry_results.placepayoff, entry_results.showpayoff, entries.ccrank, entries.ccpoints, entries.livelongshot, entries.ccscore, races.exacta, races.trifecta, ISNULL(races.ex_cold, 0) ex_cold,  ISNULL(races.tri_cold, 0) tri_cold,  ISNULL(races.ex_box, 0) ex_box,  ISNULL(races.tri_box, 0) tri_box,  ISNULL(races.ex_boxplusone, 0) ex_boxplusone,  ISNULL(races.tri_boxplusone, 0) tri_boxplusone FROM entries INNER JOIN entry_results ON entries.id = entry_results.entryid INNER JOIN races ON entries.raceid = races.id AND entry_results.raceid = races.id INNER JOIN tracks ON races.track = tracks.id WHERE (entries.scratched = 0) AND (entry_results.officialfinish <= 3) AND (entry_results.raceid = @id) ORDER BY entry_results.officialfinish">
                <SelectParameters>
                    <asp:ControlParameter Name="id" ControlID="HFRaceid" PropertyName="Value" />
                </SelectParameters>
            </asp:SqlDataSource>
                        </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UP_RaceCard" >
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
                        
                        </div>
                        
                    </ItemTemplate>
                   
                </asp:Repeater>
                </div>
                </div>

                </nav>
                    </div>
                </div>
                <asp:SqlDataSource ID="SqlDataSourceRaces" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
                    SelectCommand="SELECT *, tracks.name, tracks.abbrev as tname FROM races INNER JOIN racesintourn ON races.id = racesintourn.raceid INNER JOIN tracks ON races.track = tracks.id WHERE (racesintourn.tournid = @id)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int64" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ItemTemplate>
        </asp:FormView>
        
    </div>
    <asp:SqlDataSource ID="SqlDataSourceTournament" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT * FROM [tournaments] WHERE ([id] = @id)">
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>
    

<script type="text/javascript">
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(SetupPPLoader)

    function SetupPPLoader() {

        $('.pploader').click(function () {
            var selectedVal = $(this).attr('rel');
            $('#ppcontent' + selectedVal).load('/tooltips/pp.aspx?eid=' + selectedVal + " #pps");            
        });

        $(document).on("click", "[src*=plus]", function () {
            $(this).attr("src", "/images/minus.png");
        });
        $(document).on("click", "[src*=minus]", function () {
            $(this).attr("src", "/images/plus.png");
        });
      
    }
    function ChangeView()
    {
        $('.horsecard').each(function () {
            $(this).toggleClass('horsecard_compressed');
            $(this).toggleClass('boxshadow');
            
        })
        $('.toggleswitch').each(function () {
            $(this).toggleClass('fa-toggle-on fa-toggle-off')
        })
        
    }


</script>
    <div id="divResult"></div>
    <script type="text/javascript">
        function savePick(eid, sender) {
            var obj = {};
            obj.eid = eid.toString();;
            obj.tentry = $.trim($("[id*=DDLEntries]").val())
                        $.ajax({                            
                            type: "POST",
                            url: 'picks.aspx/SaveSelection',
                            data: JSON.stringify(obj),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (msg) {
                                if (msg.d == "Race Closed")
                                {
                                    BootstrapDialog.show({ type: BootstrapDialog.TYPE_DANGER, title: 'Pick Confirmation', message: msg.d })
                                }
                                if (msg.d == "Your picks have been saved." || msg.d == "Your picks have been updated.")
                                {
                                    BootstrapDialog.show({ type: BootstrapDialog.TYPE_SUCCESS, title: 'Pick Confirmation', message: msg.d })
                                    var targetctrl = sender;
                                    $(targetctrl).parents('.horsecard').siblings('.horsecard').each(function () {
                                        $(this).removeClass('horseselected');
                                    })
                                    $(targetctrl).parents('.horsecard').addClass('horseselected');

                                }                                
                                return false;
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                BootstrapDialog.show({ type: BootstrapDialog.TYPE_WARNING, title: 'Something Went Wrong', message : errorThrown })                                
                            }
                        });
                    }
        /*
        $('.horsecardpanel').each(function () {
            var $this = $(this);
            var program = $this.data('program');
            var raceid = $this.data('raceid');
            var obj = {};

            obj.currentprogram = program.toString();
            obj.raceid = raceid.toString();
            obj.tournid = getParameterByName('id');
            obj.tentry = $.trim($("[id*=DDLEntries]").val());

            $.ajax({
                type: "POST",
                url: 'picks.aspx/isSelected',
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {

                    if (msg.d == " horseselected") { $this.addClass('horseselected'); }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $("#divResult").html("Something Wrong." + errorThrown + " / " + textStatus);
                }
            });
        });
        */
    </script>

    <script>
    $(function() {
        $(".tab-content").swiperight(function () {            
            var $tab = $('#tabs .active').prev();
            //$('#collapsed').children('li').removeClass('active');
            if ($tab.length > 0)
                $tab.find('a').tab('show');            
        });
        $(".tab-content").swipeleft(function() {
            var $tab = $('#tabs .active').next();
            $('#collapsed').children('li').removeClass('active');
            if ($tab.length > 0)
                $tab.find('a').tab('show');
        });
        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            var target = $(this).attr('href');

            $(target).css('right', '-' + $(window).width() / 2 + 'px');
            var right = $(target).offset().right;
            $(target).css({ right: right }).animate({ "right": "0px" }, "10");
        })
    });
    </script>
</asp:Content>

