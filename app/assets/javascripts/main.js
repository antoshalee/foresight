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
	});

	// Sign up
	popup__init();

});

function commonHandlers() {
	$(window).bind('resize', function(){
		docW = $(document).width();
		docH = $(document).height();
		winW = $(window).outerWidth();
		winH = $(window).height();

		experts();
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


function popup__init() {
	var popup = $('.popup')
	// Normalize indents
	popup.each(function(i){
		var el = $(this)
		var mt = -0.5 * el.height()
		var ml = -0.5 * el.width()
		el.css({'margin':mt+'px 0 0 '+ml+'px'})
	})
	// Open popup
	$('.js_popup').bind('click',function(){
		var rel = $(this).attr('data-rel')
		popup__show(rel)
	})
	// Close popup
	$('#overlay, .popup_close').bind('click',function(){
		$('#overlay, .popup').hide();
	})
}

function popup__show(rel) {
	$('#overlay, .popup').hide();
	if ( $.browser.msie && parseInt($.browser.version, 10) < 9 ) $('#overlay, #'+rel).show()
	else
	$('#overlay, #'+rel)
		.css({'opacity':0,'display':'block'})
		.stop()
		.animate({'opacity':1},300)

	if ( $('.scrollpane_popup').size() ) $('.scrollpane_popup').jScrollPane()
}