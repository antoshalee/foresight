initLikeButtons = function() {

	//document.getElementById('vk_share_button').innerHTML = VK.Share.button('http://mysite.com', {type: 'link'});

	$('.vk_like').each(function(){
		var divId = $(this).attr('id');
		var memberPhoto = $(this).attr('data-image');
		var memberId = $(this).attr('data-id');
		VK.Widgets.Like(
			divId,
			{
				type: 'button',
				pageImage: memberPhoto,
				pageTitle: 'Красноярский Foresight',
				pageDescription: 'Участвуй в выборе'
			},
			memberId
		);
	})


	// $('.member_share_button').each(function(){
	// 	var memberId = ($(this).attr('data-id'));
	// 	var memberImage = ($(this).attr('data-image'));
	// 	var memberDescription = ($(this).attr('data-description'));
	// 	$(this).html(VK.Share.button(
	// 		{
	// 			url:'http://kmfuture.herokuapp.com/member/'+memberId,
	// 			title: 'Голосуй за участника Foresight',
	// 			description: memberDescription,
	// 			image: memberImage,
	// 			noparse: true
	// 		},
	// 		{type: 'round'
	// 		})
	// 	);
	// });

};