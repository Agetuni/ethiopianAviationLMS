$(document).ready(function(){
    $(".authority_preview a").on("click", function(e){
        e.preventDefault();
        var authid = $(this).data("authid");

        $.get("/cgi-bin/koha/authorities/detail.pl", { authid : authid }, function( data ){
            var auth_detail = $(data).find("#authoritiestabs");
            auth_detail.find("ul").remove();
            $("#authorityDetail .modal-title").html(__("Authority") + " " + authid );
            $("#authorityDetail .modal-body").html( auth_detail );
        });

        $("#authorityDetail").modal("show");
    });
    $("#authorityDetail").on("hidden.bs.modal", function(){
        $("#authorityDetail .modal-body, #authorityDetail .modal-title").html("");
        $("#authorityDetail .modal-body").html("<div id=\"loading\"><img src=\"[% interface | html %]/[% theme | html %]/img/spinner-small.gif\" alt=\"\" /></div>");
    });
});