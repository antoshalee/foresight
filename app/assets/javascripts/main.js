$(document).ready(function(){
	
	docW = $(document).width();
	docH = $(document).height();
	winW = $(window).width();
	winH = $(window).height();


	commonHandlers();

	// Experts
	experts();
	$('.sliderexperts__list').slideIt({
		'time' : '400',
		'prev' : '.sliderexperts__prev',
		'next' : '.sliderexperts__next'
	})

});

function commonHandlers() {
	$(window).bind('resize', function(){
		docW = $(document).width();
		docH = $(document).height();
		winW = $(window).outerWidth();
		winH = $(window).height();
	});

	$('.sitenav__link').bind('click', function(){
		var target = $(this).attr('data-href');
		$('body').scrollTo( $('.'+target), 1000 );
	});
}

function experts() {
	var layer = $('.sliderexperts__list');
	var elems = $('.sliderexperts__item');
	var elemsCount = elems.size();
	var elemsWidth = 224;

	// Elems on slide
	var elemsScreenCount = Math.floor((winW-150)/elemsWidth);
	var wrapperWidth = elemsScreenCount * elemsWidth;
	$('.sliderexperts__wrap').css('width', wrapperWidth+'px');
}