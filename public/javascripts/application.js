$(document).ready(function () {
	$('a[href="#help"]').click(function(e){
		if ($('#help:hidden').length > 0) {
			$('#help').slideDown('show');
			$(this).text('Hide help');
		} else {
			$('#help').slideUp('slow');
			$(this).text('Help');
		}
		e.preventDefault();
	});

	// Patch for Mobile Safari's orientation change bug
	// From: http://huffduffer.com/js/global.js
	// Based on http://www.blog.highub.com/mobile-2/a-fix-for-iphone-viewport-scale-bug/
	// See http://adactio.com/journal/4470/ for the gory details.
	if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) {
		$('meta[name="viewport"]').attr('content','width=device-width, minimum-scale=1.0, maximum-scale=1.0');
		document.body.addEventListener("gesturestart",function() {
			$('meta[name="viewport"]').attr('content','width=device-width, minimum-scale=0.25, maximum-scale=1.6');
		}, false);
	}
});
