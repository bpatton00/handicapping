<%@ Control Language="C#" AutoEventWireup="true" Inherits="ascx_leaderboard" Codebehind="leaderboard.ascx.cs" %>

<div class="accordion-heading accordion-collapse-in">
    <a class="accordion-toggle " data-toggle="collapse" data-parent="#accorside1" href="#acc_ldb">
        <i class="fa fa-star"></i>Leaderboard
    </a>
</div>
<div id="acc_ldb" class="accordion-body collapse in">
    <div class="accordion-inner">
        
        <table id="LeaderboardTable" border="0" class="table table-hover table-condensed">
            <thead>
                <tr><th>#</th><th>Name</th><th></th></tr>
            </thead>
            <tbody>
                <tr class="loading"><td colspan="3">loading...</td></tr>
            </tbody>
        </table>
        
    </div>
</div>
    
