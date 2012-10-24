/*

	Simple jQuery sliding plugin
	(c) Sergey Haritonov, Timophy Chaptykov
	tim.chaptykov@gmail.com

*/

(function ($) {
    $.fn.slideIt = function (options) {
        return this.each(function () {        	
            var offset = 0;
            var self = $(this);
            var settings = $.extend({
                'field': "left",
                'time': 250,
                'anim': "swing",
                'wrap': false
            }, options);

            var field = settings['field'];
            var elemSize = 0, size = 0, stepSize = 0, view = 0, direction = {}, maxOffset = 0, currentStep = 0, maxSteps = 0;

            function init() {
                if (field == 'left') {
                    self.css("width", self.children().outerWidth(true) * (self.children().length + 1));
                    self.css("height", self.children().outerHeight(true));
                } else {
                    self.css("width", self.children().outerWidth(true));
                    self.css("height", self.children().outerHeight(true) * (self.children().length + 1));
                }
                elemSize = (field == 'left' ? self.children().outerWidth() : self.children().outerHeight());
                size = (field == 'left' ? self.width() : self.height());
                stepSize = 0;
                if ('stepSize' in settings) stepSize = settings['stepSize'];
                    else stepSize = elemSize;
                view = (field == 'left' ? self.parent().width() : self.parent().height());
                direction = {};
                maxOffset = 0;
                maxOffset = (size - view - elemSize);
                maxSteps = maxOffset / stepSize;
            }

            init();

            function go(i) {
                init();    
                currentStep = i;
                offset = currentStep * stepSize; 
                if (offset >= maxOffset) offset = maxOffset;
                if (offset <= 0) offset = 0;
                direction[field] = -offset;
                self.stop().animate(direction, settings['time'], settings['anim']);
            }

            if ('prev' in settings) $(settings['prev']).bind('click', function () {                
                if (offset > 0) 
                    go(currentStep - 1);
                else
                    if(settings['wrap'])
                        go( maxSteps );
                return false;
            });

            if ('next' in settings) $(settings['next']).bind('click', function () {
                if (offset < maxOffset) 
                    go(currentStep + 1);
                else
                    if(settings['wrap'])
                        go( 0 );
                return false;
            });
        });
    };
})(jQuery);