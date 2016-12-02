<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="handicappingedge.aspx.cs" Inherits="Capping.tools.handicappingedge" %>
<%@ Register Src="~/ascx/winstreaks.ascx" TagPrefix="uc1" TagName="winstreaks" %>
<%@ Register Src="~/ascx/sredge.ascx" TagPrefix="uc1" TagName="sredge" %>
<%@ Register src="../ascx/bestbets.ascx" tagname="bestbets" tagprefix="uc2" %>
<%@ Register Src="~/ascx/tips.ascx" TagPrefix="uc1" TagName="tips" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="CPH_Admin" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderLeft" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
        <div>
            <div class="btn btn-group" role="group">
            <asp:HyperLink ID="HLAngleData" runat="server" Text="Exclusive Handicapping Angle Analysis" NavigateUrl="~/tools/angles.aspx" CssClass="btn btn-default" />
            <asp:HyperLink ID="HLCCEval" runat="server" Text="CC Rank Evaluation Reports" NavigateUrl="~/tools/cceval.aspx" CssClass="btn btn-default" />
            </div>
            <br />
            <div>
                <div class="ribboncontainer one">
                <div class="skew l"></div>
                  <div class="ribbonmain">
                    <div class="title-md">Tips</div>   
                  </div>
                </div>
                <div class="font-xs">
                    <uc1:tips runat="server" id="tips" />
                </div>
            </div>
            
            <div>
                <div class="ribboncontainer one">
                <div class="skew l"></div>
                  <div class="ribbonmain">
                    <div class="title-md">Best Values</div>   
                  </div>
                </div>
                <div class="font-xs">
                    <uc2:bestbets ID="bestbets1" runat="server" />
                </div>
            </div>
            <br />
            <div>
                <div class="ribboncontainer one">
                <div class="skew l"></div>
                  <div class="ribbonmain">
                    <div class="title-md">Win Streaks</div>   
                  </div>
                </div>
                <div class="font-xs">
                    <uc1:winstreaks runat="server" ID="winstreaks" />
                </div>
            </div>
            <br />
            <div>
                <div class="ribboncontainer one">
                <div class="skew l"></div>
                  <div class="ribbonmain">
                    <div class="title-md">5pt or greater AVG SR</div>   
                  </div>
                </div>
                <div class="font-xs">
                    <uc1:sredge runat="server" ID="sredge" />
                </div>
            </div>
            <br />
            5pt or greater AVG Class Rating
        </div>
</asp:Content>
