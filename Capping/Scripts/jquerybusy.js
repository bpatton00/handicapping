// prepare the form when the DOM is ready 
$(document).ready(function () {

    // Setup the ajax indicator
    $('body').append('<div id="ajaxBusy"><p><img src="/images/loading.gif"></p></div>');

    $('#ajaxBusy').css({
        display: "none",
        margin: "0px",
        paddingLeft: "0px",
        paddingRight: "0px",
        paddingTop: "0px",
        paddingBottom: "0px",
        position: "absolute",
        right: "0px",
        top: "0px",
        width: "auto"
    });
});

// Ajax activity indicator bound to ajax start/stop document events
$(document).ajaxStart(function () {
    $('#ajaxBusy').show();
}).ajaxStop(function () {
    $('#ajaxBusy').fadeOut("slow");
});