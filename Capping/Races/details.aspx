<%@ Page Title="Race Details" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="Races_details" Codebehind="details.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">




     
        <asp:FormView ID="FVTourn" runat="server" DataSourceID="SqlDataSourceRace" RenderOuterTable="false">
            <ItemTemplate>
                <span class="title-md hr-left">Race Details</span>
                <h3><%# Eval("name") %></h3>
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
                <br /><br />
                <div class="row">
                                                
                            <br />
                                <!--Speed Rating-->
                                <div class="col-xs-12 col-md-4 col-lg-offset-3 col-lg-3">     
                                <div class="panel panel-default">
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
                                        <asp:QueryStringParameter Name="raceid" QueryStringField="id" Type="Int64" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                    </div>
                                </div>
                                </div>
                                <!--LIFETIME Speed Rating-->
                                <div class="col-xs-12 col-md-4 col-lg-3"> 
                                    <div class="panel panel-default">
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
                                        <asp:QueryStringParameter Name="raceid" QueryStringField="id" Type="Int64" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                    </div>
                                </div>
                                </div>
                                <!--Class Rating-->
                                <div class="col-xs-12 col-md-4 col-lg-3">
                                    <div class="panel panel-default">
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
                                        <asp:QueryStringParameter Name="raceid" QueryStringField="id" Type="Int64" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                        </div>
                                </div>
                                </div>
                        
                        </div>
                        
                        <div class="row">
                        <div class="col-xs-12">
                        <asp:Repeater ID="RPT_Horses" runat="server" DataSourceID="SqlDataSourceRDetails">
                                <ItemTemplate>                                
                                    <div class="horsecard horsecard_compressed ">
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

                
                <asp:SqlDataSource ID="SqlDataSourceRDetails" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
                    SelectCommand="SELECT *, races.ropen FROM entries INNER JOIN races ON entries.raceid = races.id WHERE (raceid = @id) ORDER BY CONVERT(int,dbo.ReplaceNonNumericChars(program)),post">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int64" />
                    </SelectParameters>
                </asp:SqlDataSource>

            </ItemTemplate>
        </asp:FormView>
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
    </script>
    



    <asp:SqlDataSource ID="SqlDataSourceRace" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT *, tracks.name as tname FROM races INNER JOIN tracks ON races.track = tracks.id WHERE (races.id = @id)">
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:GridView ID="GVResults" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="SqlDataSourceResults" CssClass="responstable">
        <Columns>
            <asp:BoundField DataField="post" HeaderText="Post" SortExpression="post" />
            <asp:BoundField DataField="name" HeaderText="Horse" SortExpression="name" />
            <asp:BoundField DataField="finalodds" HeaderText="Final Odds" SortExpression="finalodds" />
            <asp:BoundField DataField="winpayoff" HeaderText="Win" SortExpression="winpayoff" />
            <asp:BoundField DataField="placepayoff" HeaderText="Place" SortExpression="placepayoff" />
            <asp:BoundField DataField="showpayoff" HeaderText="Show" SortExpression="showpayoff" />
            
            
        </Columns>

    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceResults" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT entry_results.id, entry_results.raceid, entry_results.entryid, entry_results.finish, entry_results.officialfinish, entry_results.finalodds, entry_results.weight, entry_results.finaltime, entry_results.trackcondition, entry_results.winpayoff, entry_results.placepayoff, entry_results.showpayoff, entries.name, entries.post FROM entry_results INNER JOIN entries ON entry_results.entryid = entries.id WHERE (entry_results.raceid = @id) ORDER BY entry_results.officialfinish">
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

