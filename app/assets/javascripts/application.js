// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$(document).ready(function(){
    // Clear location field when selected with cursor
  $("#location").focus(function(){
    if($(this).val() == "Search Location") {
      $(this).val("");
    }
  });

  $("#location").blur(function() {
    if( $(this).val() == "" || $(this).val() == " " ) {
      $(this).text("Search Location");
    }
  });


getGeoLoc();


});


function getGeoLoc(){
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(geoSuccess, geoError);
  } else {
    return 'not supported';
  }
}

function geoSuccess(position){
  $.ajax({url:'/images/'+ position.coords.latitude +'/'+ position.coords.longitude +'/snow.json', success: function(data){
    $.each(data, function(index, value) {
      $('#content').append('<img src="'+ value +'" width="200" height="200" />');
    });
  }
});


}

function geoError(msg) {
  var s = document.querySelector('#status');
  s.innerHTML = typeof msg == 'string' ? msg : "failed";
  s.className = 'fail';
}