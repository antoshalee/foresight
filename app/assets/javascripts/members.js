$(document).ready(function() {
	$('.rating').on('ajax:success', '.vote_link', function(evt, data, status, xhr) {
      	// refresh rating of user
      	$(this).parent().find('.member_rating').html(data.rating);
     })
})