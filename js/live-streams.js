$(document).ready(function() {
	jwplayer('live-stream-a').setup({
		file: 'rtmp://batc-uk.org/live/sr2015a',
		height: 576,
		width: 720,
		autostart: true,
	});

	var bInit = false;
	$('#live-stream-b_wrapper').hide();

	jwplayer().onIdle(function() {
		// Restart if the stream is momentarily interrupted
		setTimeout(function() { jwplayer().play(); }, 5000);
	});

	$('#live-stream-controls > a').click(function() {
		$('#live-stream-controls > a').removeClass('selected');
		$(this).addClass('selected');
	});

	$('#live-stream-a-link').click(function() {
		$('#live-stream-b, #live-stream-b_wrapper').hide();
		$('#live-stream-a, #live-stream-a_wrapper').show();
	});

	$('#live-stream-b-link').click(function() {
		if (!bInit) {
			jwplayer('live-stream-b').setup({
				file: 'rtmp://batc-uk.org/live/sr2015b',
				height: 576,
				width: 720,
				autostart: true,
			});
			bInit = true;
		}
		$('#live-stream-a, #live-stream-a_wrapper').hide();
		$('#live-stream-b, #live-stream-b_wrapper').show();
	});

	$('#live-stream-hide-link').click(function() {
		$('#live-stream-a, #live-stream-a_wrapper').hide();
		$('#live-stream-b, #live-stream-b_wrapper').hide();
	});
});
