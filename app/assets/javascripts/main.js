$(document).ready(function(){
	
	docW = $(document).width();
	docH = $(document).height();
	winW = $(window).width();
	winH = $(window).height();

	if (winW<980) winW = 980;

	commonHandlers();

	// Experts
	experts();
	$('.sliderexperts__list').slideIt({
		'time' : '400',
		'prev' : '.sliderexperts__prev',
		'next' : '.sliderexperts__next'
	});

	// Community
	community();

	// Orgs
	orgs();
	$('.sliderorgs .sliderpartners__list').slideIt({
		'time' : '400',
		'prev' : '.sliderorgs .sliderorgs__prev',
		'next' : '.sliderorgs .sliderorgs__next'
	});

	// Sign up
	popup__init();

});

function commonHandlers() {
	$(window).resize(function(){
		docW = $(document).width();
		docH = $(document).height();
		winW = $(window).outerWidth();
		winH = $(window).height();

		if (winW<980) winW = 980;

		experts();
		community();
		orgs();
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

function community() {
	var top = $('.community__top_body');
	if (winW>1500) top.css('width','1400px');
	else top.css('width','700px');
}

function orgs() {
	var layer = $('.sliderorgs .sliderpartners__list');
	var elems = $('.sliderorgs .sliderpartners__item');
	var elemsCount = elems.size();
	var elemsWidth = 200;

	// Elems on slide
	var elemsScreenCount = Math.floor((winW-150)/elemsWidth);
	var wrapperWidth = elemsScreenCount * elemsWidth;
	$('.sliderpartners__wrap').css('width', wrapperWidth+'px');
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