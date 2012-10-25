// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

var showAll = false;

$(document).ready(function(){

  if (returnTo) {
    if (returnTo=='participate' || returnTo=='recommend')
    {
      popup__show(returnTo);
    }

    $('body').scrollTo( $('.community'), 1000 );
  }

  // global form handlers
	$("body")
      .on('ajax:success', "form, .destroy_link", function(evt, data, status, xhr) {
      	refreshRating();
      })
      .on('ajax:error', "form, .destroy_link", function(xhr, status, error) {
      	alert($.parseJSON(status.responseText).errors);
      })
      .on('ajax:success', '.button.vote', function(evt, data, status, xhr) {
          $(this).hide();
          $(this).parent().parent().find('.member__count').html(data.rating);
      });

      // handlers for participate form
      $("#participate form").bind('ajax:success', function(evt, data, status, xhr) {
            $('#participate_btn').hide();
            showMessage('Поздравляем!', 'Вы успешно зарегистрировались как участник');
      });

      // handlers for recommend form
      $("#recommend form").bind('ajax:success', function(evt, data, status, xhr) {
            $('#recommend-url').val('');
            $('#recommend-desc').val('');
            showMessage('Все получилось!', data.name + ' был зарегистрирован как участник Foresight');
            refreshRating();
      });

      // handlers for get all rating
      $("#allmembers_link").bind('ajax:success', function(evt, data, status, xhr) {
          $('.members').html(data);
          $('#allmembers_link').hide();
          showAll = true;
      });

});

showMessage = function(header, message) {
  $('#message h2').html(header);
  $('#message .label').html(message);
  popup__show('message');
}


refreshRating = function() {
  $.get(
    '/members',
    {all: showAll},
    function(data) {
      $('.members').html(data);
    }
  );

}