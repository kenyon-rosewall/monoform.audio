$(document).ready(function() {

	$('.authenticity_token').val($('meta[name="csrf-token"]').attr('content'));
	
});