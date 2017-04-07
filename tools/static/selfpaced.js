//Wait for page to load before we use jQuery
document.addEventListener('DOMContentLoaded', function(){ 

$(document).ready(function(){

  $('#banner').css({"visibility":"hidden", "height":"0"});
  $('#user-content > .content').removeClass("container");
  $('#user-content > .content').addClass("container-fluid");

  // Dynamically resize videos
  $( window ).resize(function () {
    $('#video > iframe').width($('#instructions').width());
    $('#video > iframe').height(($('#instructions').width() * 9) / 16);
  });

  $( "#toggle-sidebar" ).on( "click", function () { $( window ).trigger( "resize" ); } );
  $( window ).trigger( "resize" );
});

}, false);  
