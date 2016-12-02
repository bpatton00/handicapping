/// <reference path="../Scripts/jquery-1.10.2.js" />
/// <reference path="../Scripts/jquery.signalR-2.1.1.js" />

/*!
    ASP.NET SignalR Stock Ticker Sample
*/
function getQueryVariable(variable) {
    var query = window.location.search.substring(1);
    var vars = query.split("&");
    for (var i = 0; i < vars.length; i++) {
        var pair = vars[i].split("=");
        if (pair[0] == variable) { return pair[1]; }
    }
    return (false);
}

// Crockford's supplant method (poor man's templating)
if (!String.prototype.supplant) {
    String.prototype.supplant = function (o) {
        return this.replace(/{([^{}]*)}/g,
            function (a, b) {
                var r = o[b];
                return typeof r === 'string' || typeof r === 'number' ? r : a;
            }
        );
    };
}

// A simple background color flash effect that uses jQuery Color plugin
jQuery.fn.flash = function (color, duration) {
    var current = this.css('backgroundColor');
    this.animate({ backgroundColor: 'rgb(' + color + ')' }, duration / 2)
        .animate({ backgroundColor: current }, duration / 2);
};

$(function () {

    var tournid = getQueryVariable("id");
    var lb = $.connection.LeaderboardHub, // the generated client-side hub proxy
        up = '▲',
        down = '▼',
        $LeaderboardTable = $('#LeaderboardTable'),
        $LeaderboardTableBody = $LeaderboardTable.find('tbody'),
        rowTemplate = '<tr data-symbol="{teid}"><td>{Rank}<span class="dir {DirectionClass}">{Direction}</span></td><td>{username}</td><td>{Earnings}</td><td>{EarningsChange}</td></tr>';

    function formatLB(LeaderboardStanding) {
        return $.extend(LeaderboardStanding, {
            Rank: LeaderboardStanding.rank,
            Earnings: LeaderboardStanding.earnings.toFixed(2),
            Direction: LeaderboardStanding.Change === 0 ? '' : LeaderboardStanding.Change >= 0 ? up : down,
            DirectionClass: LeaderboardStanding.Change === 0 ? 'even' : LeaderboardStanding.Change >= 0 ? 'up' : 'down'
        });
    }

    function init() {
        return lb.server.getAllStandings(tournid).done(function (LeaderboardStandings) {
            $LeaderboardTableBody.empty();
            $.each(LeaderboardStandings, function () {
                var LeaderboardStanding = formatLB(this);
                $LeaderboardTableBody.append(rowTemplate.supplant(LeaderboardStanding));
            });
        });
    }

    // Add client-side hub methods that the server will call
    $.extend(lb.client, {
        UpdateLeaderboard: function (LeaderboardStanding) {
            var displayStanding = formatLB(LeaderboardStanding),
            $row = $(rowTemplate.supplant(displayStanding))
            , bg = displayStanding.EarningsChange < 0
                        ? '255,148,148' // red
                        : '154,240,117'; // green;
            $LeaderboardTableBody.find('tr[data-symbol=' + displayStanding.teid + ']')
                .replaceWith($row);

            $row.flash(bg, 1000);
        },

        leaderboardOpened: function () {
            $("#open").prop("disabled", true);
            $("#close").prop("disabled", false);
            $("#reset").prop("disabled", true);
        },

        leaderboardClosed: function () {
            $("#open").prop("disabled", false);
            $("#close").prop("disabled", true);
            $("#reset").prop("disabled", false);
        },

        leaderboardReset: function () {
            return init();
        }
    });

    // Start the connection
    $.connection.hub.logging = true;
    $.connection.hub.start()
        .then(init)
        .then(function () {
            return lb.server.getLeaderboardState();
        })
        .done(function (state) {
            if (state === 'Open') {
                lb.client.leaderboardOpened();
            } else {
                lb.client.leaderboardClosed();
            }
            // Wire up the buttons
            $("#open").click(function () {
                lb.server.openLeaderboard();
            });

            $("#close").click(function () {
                lb.server.closeLeaderboard();
            });

            $("#reset").click(function () {
                lb.server.reset();
            });
        });
});