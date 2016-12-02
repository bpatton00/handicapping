<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="myaccount_Default" Codebehind="Default.aspx.cs" %>

<%@ Register Src="~/ascx/myselections.ascx" TagPrefix="uc1" TagName="myselections" %>
<%@ Register Src="~/ascx/userstats.ascx" TagPrefix="uc1" TagName="userstats" %>



<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style>
        @import url(http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700);
.board{
    width: 75%;
margin: 60px auto;

background: #fff;
/*box-shadow: 10px 10px #ccc,-10px 20px #ddd;*/
}
.board .nav-tabs {
    position: relative;
    /* border-bottom: 0; */
    /* width: 80%; */
    margin: 40px auto;
    margin-bottom: 0;
    box-sizing: border-box;

}

.board > div.board-inner{
    /*background: #fafafa url(http://subtlepatterns.com/patterns/geometry2.png);*/
    background-size: 30%;
}

p.narrow{
    width: 60%;
    margin: 10px auto;
}

.liner{
    height: 2px;
    background: #ddd;
    position: absolute;
    width: 80%;
    margin: 0 auto;
    left: 0;
    right: 0;
    top: 50%;
    z-index: 1;
}

.nav-tabs > li.active > a, .nav-tabs > li.active > a:hover, .nav-tabs > li.active > a:focus {
    color: #555555;
    cursor: default;
    /* background-color: #ffffff; */
    border: 0;
    border-bottom-color: transparent;
}

span.round-tabs{
    width: 70px;
    height: 70px;
    line-height: 70px;
    display: inline-block;
    border-radius: 100px;
    background: white;
    z-index: 2;
    position: absolute;
    left: 0;
    text-align: center;
    font-size: 25px;
}

span.round-tabs.one{
    color: rgb(34, 194, 34);border: 2px solid rgb(34, 194, 34);
}

li.active span.round-tabs.one{
    background: #fff !important;
    border: 2px solid #ddd;
    color: rgb(34, 194, 34);
}

span.round-tabs.two{
    color: #febe29;border: 2px solid #febe29;
}

li.active span.round-tabs.two{
    background: #fff !important;
    border: 2px solid #ddd;
    color: #febe29;
}

span.round-tabs.three{
    color: #3e5e9a;border: 2px solid #3e5e9a;
}

li.active span.round-tabs.three{
    background: #fff !important;
    border: 2px solid #ddd;
    color: #3e5e9a;
}

span.round-tabs.four{
    color: #f1685e;border: 2px solid #f1685e;
}

li.active span.round-tabs.four{
    background: #fff !important;
    border: 2px solid #ddd;
    color: #f1685e;
}

span.round-tabs.five{
    color: #999;border: 2px solid #999;
}

li.active span.round-tabs.five{
    background: #fff !important;
    border: 2px solid #ddd;
    color: #999;
}

.nav-tabs > li.active > a span.round-tabs{
    background: #fafafa;
}
.nav-tabs > li {
    width: 20%;
}
/*li.active:before {
    content: " ";
    position: absolute;
    left: 45%;
    opacity:0;
    margin: 0 auto;
    bottom: -2px;
    border: 10px solid transparent;
    border-bottom-color: #fff;
    z-index: 1;
    transition:0.2s ease-in-out;
}*/
li:after {
    content: " ";
    position: absolute;
    left: 45%;
   opacity:0;
    margin: 0 auto;
    bottom: 0px;
    border: 5px solid transparent;
    border-bottom-color: #ddd;
    transition:0.1s ease-in-out;
    
}
li.active:after {
    content: " ";
    position: absolute;
    left: 45%;
   opacity:1;
    margin: 0 auto;
    bottom: 0px;
    border: 10px solid transparent;
    border-bottom-color: #ddd;
    
}
.nav-tabs > li a{
   width: 70px;
   height: 70px;
   margin: 20px auto;
   border-radius: 100%;
   padding: 0;
}

.nav-tabs > li a:hover{
    background: transparent;
}

.tab-content{
}
.tab-pane{
   position: relative;
padding-top: 50px;
}
.tab-content .head{
    font-family: 'Roboto Condensed', sans-serif;
    font-size: 25px;
    text-transform: uppercase;
    padding-bottom: 10px;
}
.btn-outline-rounded{
    padding: 10px 40px;
    margin: 20px 0;
    border: 2px solid transparent;
    border-radius: 25px;
}

.btn.green{
    background-color:#5cb85c;
    /*border: 2px solid #5cb85c;*/
    color: #ffffff;
}



@media( max-width : 585px ){
    
    .board {
width: 90%;
height:auto !important;
}
    span.round-tabs {
        font-size:16px;
width: 50px;
height: 50px;
line-height: 50px;
    }
    .tab-content .head{
        font-size:20px;
        }
    .nav-tabs > li a {
width: 50px;
height: 50px;
line-height:50px;
}

li.active:after {
content: " ";
position: absolute;
left: 35%;
}

.btn-outline-rounded {
    padding:12px 20px;
    }
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">


        <section >
        <div class="container">
            <div class="row">
                <div class="board">
                    <div class="board-inner">
                    <ul class="nav nav-tabs" id="myTab">
                    <div class="liner"></div>
                     <li class="active">
                     <a href="#home" data-toggle="tab" title="welcome">
                          <span class="round-tabs one">
                                  <i class="glyphicon glyphicon-home"></i>
                          </span> 
                      </a>
                     </li>
                  <li><a href="#profile" data-toggle="tab" title="Profile">
                     <span class="round-tabs two">
                         <i class="glyphicon glyphicon-user"></i>
                     </span> 
           </a>
                 </li>
                 <li><a href="#upcoming" data-toggle="tab" title="Currently Entered">
                     <span class="round-tabs three">
                          <i class="glyphicon glyphicon-th-list"></i>
                     </span> </a>
                     </li>

                     <li><a href="#finished" data-toggle="tab" title="Completed">
                         <span class="round-tabs four">
                              <i class="glyphicon glyphicon-ok"></i>
                         </span> 
                     </a></li>             
                              
                     <li><a href="#membership" data-toggle="tab" title="Membership">
                         <span class="round-tabs five">
                              <i class="glyphicon glyphicon-star"></i>
                         </span> 
                     </a></li>  
                     </ul></div>
        <div class="tab-content">
            <div class="tab-pane fade in active" id="home">
                <h3 class="head text-center">Welcome to Thoro-Lab</h3>
                <p class="narrow text-center">
                    Your home for the best handicapping information and tournmanets!
                </p>
            </div>

            <div class="tab-pane fade in " id="profile">
               
                <uc1:userstats runat="server" id="userstats" />
                <h3 class="head text-center">My Profile</h3>
                <p class="narrow text-center">
                        <asp:DetailsView ID="DetailsView1" runat="server" CssClass="table table-hover" 
                        AutoGenerateRows="False" DataSourceID="SqlDataSourceAccount">
                        <Fields>
                            <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
                            <asp:BoundField DataField="CreateDate" HeaderText="CreateDate" SortExpression="CreateDate" />
                            <asp:BoundField DataField="LastLoginDate" HeaderText="LastLoginDate" SortExpression="LastLoginDate" />
                            <asp:BoundField DataField="LastActivityDate" HeaderText="LastActivityDate" SortExpression="LastActivityDate" />            
                            <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        </Fields>
                    </asp:DetailsView>
                    <asp:SqlDataSource ID="SqlDataSourceAccount" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
                        SelectCommand="SELECT aspnet_Users.UserName, aspnet_Users.LastActivityDate, aspnet_Membership.Email, aspnet_Membership.CreateDate, aspnet_Membership.LastLoginDate FROM aspnet_Users INNER JOIN aspnet_Membership ON aspnet_Users.UserId = aspnet_Membership.UserId WHERE aspnet_Membership.UserId = @userid">
                            <SelectParameters>
                                <asp:SessionParameter Name="userid" SessionField="userid" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                </p>
                <br />
                <p class="text-center">
                    <asp:LinkButton ID="LinkButtonChangePW" runat="server" Text="Change My Password" CssClass="btn btn-default" PostBackUrl="~/account/ChangePassword.aspx" />
                </p>
            </div>

            <div class="tab-pane fade in " id="upcoming">
                <h3 class="head text-center">Currently Entered</h3>
                <asp:UpdatePanel ID="UPEntered" runat="server" >
            <ContentTemplate>
                    <asp:GridView ID="GridViewEntered" runat="server" AllowPaging="true" PageSize="10" CssClass="table table-hover table-condensed panel panel-default"  
        DataSourceID="SqlDataSourceEntered" PagerStyle-CssClass="pgr" HeaderStyle-CssClass="active" GridLines="None" AutoGenerateColumns="False">
        <Columns>            
            <asp:TemplateField HeaderText="Name">
                <ItemTemplate>
                    <asp:HyperLink ID="HLTourny" runat="server" Text='<%# Eval("name") %>' NavigateUrl='<%# "~/tournaments/details.aspx?id=" + Eval("id") %>' />            
                    <a class="btn btn-xs btn-primary btn-ghost expander"  data-target='<%# "selections" + Eval("id")  %>' >Selections</a>
                    <div id='<%# "selections" + Eval("id")  %>' class="collapse">
                            <uc1:myselections runat="server" tournamentid='<%# Convert.ToInt64(Eval("id")) %>' ID="myselections" />
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="prize" HeaderText="Prize" SortExpression="prize" DataFormatString="{0:c}" />
            <asp:BoundField DataField="tdate" HeaderText="Date" SortExpression="tdate" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSourceEntered" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
        SelectCommand="SELECT aspnet_Users.UserId, tournaments.id, tournaments.name, tournaments.prize, tournaments.tdate FROM tourn_entry INNER JOIN aspnet_Users ON tourn_entry.userid = aspnet_Users.UserId INNER JOIN tournaments ON tourn_entry.tournid = tournaments.id WHERE aspnet_Users.userid = @userid AND tournaments.finished = 'False' ORDER BY tdate">
            <SelectParameters>
                <asp:SessionParameter Name="userid" SessionField="userid" />
            </SelectParameters>
        </asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
            </div>

            <div class="tab-pane fade in " id="finished">
                <h3 class="head text-center">Finished</h3>
                <asp:UpdatePanel ID="UPFinished" runat="server" >
            <ContentTemplate>
            <asp:GridView ID="GridViewFinished" runat="server" AllowPaging="true" PageSize="10" CssClass="table table-hover table-condensed panel panel-default" 
                DataSourceID="SqlDataSourceFinished" PagerStyle-CssClass="pgr" HeaderStyle-CssClass="active" GridLines="None"  AutoGenerateColumns="False">
                <Columns>            
                    <asp:TemplateField HeaderText="Name">
                        <ItemTemplate>
                            <asp:HyperLink ID="HLTourny" runat="server" Text='<%# Eval("name") %>' NavigateUrl='<%# "~/tournaments/picks.aspx?id=" + Eval("id") %>' />
                            <a class="btn btn-xs btn-primary btn-ghost expander"  data-target='<%# "selections" + Eval("id")  %>' aria-expanded="false" aria-controls='<%# "selections" + Eval("id")  %>'>Selections</a>
                            <div id='<%# "selections" + Eval("id")  %>' class="collapse">
                            <uc1:myselections runat="server" tournamentid='<%# Convert.ToInt64(Eval("id")) %>' ID="myselections" />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="prize" HeaderText="Prize" SortExpression="prize" DataFormatString="{0:c}" />
                    <asp:BoundField DataField="tdate" HeaderText="Date" SortExpression="tdate" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSourceFinished" runat="server" 
                ConnectionString="<%$ ConnectionStrings:WageringConn %>" 
                SelectCommand="SELECT aspnet_Users.UserId, tournaments.id, tournaments.name, tournaments.prize, tournaments.tdate FROM tourn_entry INNER JOIN aspnet_Users ON tourn_entry.userid = aspnet_Users.UserId INNER JOIN tournaments ON tourn_entry.tournid = tournaments.id WHERE aspnet_Users.userid = @userid AND tournaments.finished = 'True' ORDER BY tdate DESC">
                    <SelectParameters>
                        <asp:SessionParameter Name="userid" SessionField="userid" />
                    </SelectParameters>
                </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>

            <div class="tab-pane fade in " id="membership">
                <h3 class="head text-center">Membership Information</h3>
                <p class="narrow text-center">
                    Coming Soon
                </p>
            </div>

         </div>
    </div>
            </div>
        </div>
        </section>
    
    <script>
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(FunctionLoader)
        function FunctionLoader() {            
            $(document).on("click", ".expander", function () {
                var selectedVal = $(this).attr('data-target');
                $("#" + selectedVal).collapse("toggle");
            });
            
        }

    </script>
</asp:Content>

