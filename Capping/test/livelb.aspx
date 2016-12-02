<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" Inherits="test_livelb" Codebehind="livelb.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderLeft" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">

<h2>Live Leaderboard</h2>
    <input type="button" id="open" value="Open LB" />
    <input type="button" id="close" value="Close LB" disabled="disabled" />
    <input type="button" id="reset" value="Reset" />

    <div id="LeaderboardTable">
        <table border="1">
            <thead>
                <tr><th>Rank</th><th>Name</th><th>Winnings</th></tr>
            </thead>
            <tbody>
                <tr class="loading"><td colspan="3">loading...</td></tr>
            </tbody>
        </table>
    </div>

    <script src="../jquery.color-2.1.2.min.js"></script>
    <script src="/Scripts/jquery.signalR-2.1.1.js"></script>
    <script src="/signalr/hubs"></script>
    <script src="SignalR.leaderboard.js"></script>
</asp:Content>

