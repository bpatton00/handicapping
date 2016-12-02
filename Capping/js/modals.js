
Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(InitialiseSettings)

function InitialiseSettings(){

    $('a.exoticdetails').click(function () {

        var selectedVal = $(this).attr('rel');
        BootstrapDialog.show({
            message: function (dialog) {
                var $message = $('<div><div id="modal_loading"><span class="glyphicon glyphicon-refresh spinning"></span> Loading...</div></div>');
                var pageToLoad = dialog.getData('pageToLoad');
                $message.load(pageToLoad);
                dialog.setSize(BootstrapDialog.SIZE_WIDE);
                return $message;
            },
            onshown: function (dialogRef) {
                $("modal_loading").hide();
            },
            data: {
                'pageToLoad': '/tooltips/exotic_details.aspx?' + selectedVal
            }
        });
    });

    /*Sample that will load complex urls
    $('a.openModal').click(function () {
        var link = $(this).data("href");
        BootstrapDialog.show({
            message: function (dialog) {
                var $message = $('<div></div>');
                var pageToLoad = dialog.getData('pageToLoad');
                $message.load(pageToLoad);
                dialog.setSize(BootstrapDialog.SIZE_WIDE);
                return $message;
            },
            data: {
                'pageToLoad': link
            }
        });
    });
    */
}
