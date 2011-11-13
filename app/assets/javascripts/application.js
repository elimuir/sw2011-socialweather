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


  //getGeoLoc();

  geolookup_city("seattle", "rain", "#carousel-seattle");

  getCities();


});


function getCities(){

  var city_arr = new Array("chicago", "miami", "aspen");
  var city_weather = new Array("snow", "sunny", "snow");
  
  $.each(city_arr, function(index){
    geolookup_city(city_arr[index], city_weather[index], "#carousel-"+city_arr[index] +" ul");
    /*
     $.get({
      url: 'http://maps.googleapis.com/maps/api/geocode/json?address='+ city_arr[index] +'&sensor=false',
      success: function(data){
        var lat = data.results.geometry.location.lat;
        var lng = data.results.geometry.location.lng;
        var name = data.results.address_components;
        var myJSONObject = {
          "coords": [
            {"latitude": lat},
            {"longitude": lng},]
        };
      
        
      }
    })
    */
  });

}

function geolookup_city(city, keyword, trg){
  //$('#carousel-latest').html("<li>Loading Images</li>");
  $('#status-'+city).html('<img src="/loader.gif" /> Loading Images...');
  $('#status-'+city).show();
  //$('#latest-photos-status').show();
  $.ajax({
    //url:'/images/'+ position.coords.latitude +'/'+ position.coords.longitude +'/snow.json',
    url:'/twitter/index/'+ city +'/'+ keyword +'.json',
    success: function(data){
      $('#status-'+city).hide();
      $(trg).html('');
      $.each(data, function(index, value) {
        $(trg).prepend('<li>'+ value +'</li>');
      });
      $(function() {
          $(trg +" ul").jCarouselLite();
      });

      /*$(function(){
        $("div.latest-photos").carousel({ dispItems: 3 });
      });*/
      
    }

  });

}

function getGeoLoc(){
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(geolookup, geoError);
  } else {
    return 'not supported';
  }
}

function geolookup(position){

  $('#latest-photos-status').html('<img src="/loader.gif" /> Loading Images...');
  $('#latest-photos-status').show();
  $.ajax({
    //url:'/images/'+ position.coords.latitude +'/'+ position.coords.longitude +'/snow.json',
    url:'/twitter/index/chicago/snow.json',
    success: function(data){
      $('#latest-photos-status').hide();
      $('#carousel-latest').html('');
      $.each(data, function(index, value) {
        $('#carousel-latest').prepend('<li><img src="'+ value +'" width="200" height="200" /></li>');
      });
      /*$(function(){
        $("div.latest-photos").carousel({ dispItems: 3 });
      });*/
    }

  });

}

function geoError(msg) {
  var s = document.querySelector('#status');
  s.innerHTML = typeof msg == 'string' ? msg : "failed";
  s.className = 'fail';
}