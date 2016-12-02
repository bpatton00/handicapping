<%@ Page Title="Tournament Details" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="Tournaments_details" Codebehind="details.aspx.cs" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
<h3>Tournament Details</h3>

    <div>
        <asp:FormView ID="FVTourn" runat="server" DataSourceID="SqlDataSourceTournament" RenderOuterTable="false">
            <ItemTemplate>
                <div class="row">
                <div class="col-xs-12">
                    <div class='<%# "imgoverlay " + "img" + shared.GetRndImg() %>'>
                <h2 style="margin-top:0px;"><%# Eval("name") %></h2>
                    <div class="row">
                
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
                             
                        </div>       
                    </div>         
                    
                    </div>
                </div>                
                </div>
                    <br />
        
                    <b>Races Included</b>
                        <asp:Repeater ID="RepeaterRaces" runat="server" DataSourceID="SqlDataSourceTDetails">
                            <HeaderTemplate>
                                <ul id="races">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <li>
                                    <asp:HyperLink ID="HLRace" runat="server" Text='<%# Eval("rdesc") %>' NavigateUrl='<%# "~/Races/details.aspx?ID=" + Eval("id") %>'></asp:HyperLink>
                                    <font style="font-size:smaller;">  <%# Convert.ToInt32(Eval("purse")).ToString("c0") + "  [" + Eval("todays_cls") + "]"  %> </font>                              
                                </li>
                            </ItemTemplate>
                            <FooterTemplate>
                                </ul>
                            </FooterTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource ID="SqlDataSourceTDetails" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
                            SelectCommand="SELECT *, tracks.name as tname FROM races INNER JOIN racesintourn ON races.id = racesintourn.raceid INNER JOIN tracks ON races.track = tracks.id WHERE (racesintourn.tournid = @id)">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int64" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        
                    
            </ItemTemplate>
            
        </asp:FormView>
        <br />
                    <asp:Button ID="ButtonReg" Text="Register" runat="server" OnClick="ButtonReg_Click" CssClass="btn btn-default" Visible='<%# user_functions.Tourn_NumEntries(Membership.GetUser().ProviderUserKey.ToString(), Convert.ToInt64(Request.QueryString["id"])) == 0  %>'   data-toggle="confirmation-register" data-placement="top" title="Register for this tournament"  />
                    <script>
                        $('[data-toggle="confirmation-register"]').confirmation({
                            singleton: true, btnOkLabel: 'Register',
                            // On confirm, call our btnCancel postback...
                            onConfirm: function () {
                             <%=Page.ClientScript.GetPostBackEventReference(ButtonReg, string.Empty)%>;
                                            }
                        });
                    </script>
                    
                    <asp:Label ID="LabelRegStatus" runat="server" ></asp:Label>
                    <asp:Button ID="ButtonPicks" runat="server" Text="Make Picks" OnClick="ButtonPicks_Click" CssClass="btn btn-default" Visible='<%# user_functions.Tourn_NumEntries(Membership.GetUser().ProviderUserKey.ToString(), Convert.ToInt64(Request.QueryString["id"])) == 1  %>' />
                <br /><br />
    </div>

    <asp:SqlDataSource ID="SqlDataSourceTournament" runat="server" ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT * FROM [tournaments] WHERE ([id] = @id)">
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

