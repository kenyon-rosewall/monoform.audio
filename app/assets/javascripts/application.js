// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/widgets/autocomplete
//= require bootstrap
//= require bootstrap-datepicker/core

/* =====================================================
   Change Header Styling on Scroll
   ===================================================== */

$(window).scroll(function() {
    if ($(this).scrollTop() > 151) { //use `this`, not `document`
        $('header').addClass('sticky');
        $('.main').addClass('sticky');
    }
});

$(window).scroll(function() {
    if ($(this).scrollTop() <= 151) { //use `this`, not `document`
        $('header').removeClass('sticky');
        $('.main').removeClass('sticky');
    }
});

/* =====================================================
   Dropdown
   ===================================================== */
$(document).on('ready', function(){

  var $dropdown = $('div.dropdownWrapper'),
      $drpBtn   = $dropdown.find('div.dropdownLabel');

  $drpBtn.on('click', function(e){
    e.stopPropagation();
    var $element = $(this).parent();
    $element.find('.dropdownPanel').fadeToggle(200);
  });

  $("body").click(function(){
    $('.dropdownPanel').hide(200);
  });

});

/* =====================================================
   Player Slideout Functionality
   ===================================================== */

$(document).ready(function($) {
  $('.col-player-filter').find('.filter-block').click(function(){
    //Expand or collapse this panel
    $(this).next().toggleClass('open');
    $(this).next().siblings().removeClass('open');
    if ( $( '.filter-wrap-level-2').hasClass( 'open' ) ) { 
        $( '.col-player' ).addClass('open')
    }
    if ( !$( '.filter-wrap-level-2').hasClass( 'open' ) ) { 
        $( '.col-player' ).removeClass('open')
    }
  });
});

/* =====================================================
   Accordion
   ===================================================== */

$(document).ready(function($) {
  $('.playlist-main-item .accordion-toggle').click(function(){
    //Expand or collapse this panel
    $(this).closest('.playlist-main-item').find('.accordion-content').toggle();
    $(this).closest('.playlist-main-item').toggleClass('open');
    $(this).toggleClass('open');
  });
});

$(document).ready(function($) {
  $('.accordion').find('.accordion-toggle').click(function(){
    //Expand or collapse this panel
    $(this).next().slideToggle('fast');
    $(this).toggleClass('open');
  });
});

/* =====================================================
   Mobile Navigation
   ===================================================== */

$(document).ready(function($) {
  $('#mobNavLink').click(function(){
    $('.top-nav').toggleClass('open');
  });
});

/* =====================================================
   Filter Block
   ===================================================== */

$(document).ready(function($) {
  $('.mobile-filters').click(function(){
    $('.col-player-filter').toggleClass('open');
  });
});

$(document).ready(function($) {
  $('.filter-block.close').click(function(){
    $('.col-player-filter').toggleClass('open');
  });
});

$(document).ready(function($) {
  $('.close-filters').click(function(){
    $('.col-player').toggleClass('open');
    $(this).closest('.filter-wrap-level-2').toggleClass('open');
    $('.col-player-filter').toggleClass('open');
  });
});

/* Add Filter to Filter List */
$(document).on('click', '.filter-wrap-level-2 li:not(:first-child)', function() {
  var filterText = $(this).text();
  var filterType = $(this).data('type');
  if (filterType == 'mood') {
    filterText = filterText.toLowerCase();
  }
  var html_check = '<i class="fa fa-times" aria-hidden="true"></i>&nbsp;' + filterText;
  var add_filter = true;
  var hash = makeid();

  $.each($('.filter-choice'), function(i,choice) {
    if ($(choice).html() == html_check) {
      add_filter = false;
    }
  });
  if (!(filterType == 'mood' || filterType == 'genre')) {
    add_filter = false;
  }

  if (add_filter) {
    $('.filter-bank').append('<div class="filter-choice" data-link="' + hash + '">' + html_check + '</div>');
    $('.filter-bank').append('<input type="hidden" class="' + hash + '" name="' + filterType + '" value="' + filterText + '" />');
    load_songs();
  }
});

/* Remove Selected Filtered When Clicked */
$(document).on('click', '.filter-choice', function() {
  var link = $(this).data('link');
  $('.' + link).remove();
  $(this).remove();

  load_songs();
});


function makeid() {
  var text = "";
  var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  for (var i = 0; i < 5; i++)
    text += possible.charAt(Math.floor(Math.random() * possible.length));

  return text;
}

$(document).ready(function() {
  if ($.cookie) {
    $.cookie.json = true;
    update_cart();
  }
});

function update_cart() {
  var song_list = $.cookie('song_list');
  if (song_list != undefined && song_list.length > 0) {
    $('#cart').addClass('dynamic-badge');
    $('#cart').attr('data-badge', song_list.length);
  } else {
    $('#cart').removeClass('dynamic-badge');
    $('#cart').attr('data-badge', '');
  }
  $('#songs_for_request').val(song_list);
}