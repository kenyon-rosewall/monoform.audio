$(document).ready(function() {
	$('#recording').autocomplete({
		source: '/api/search/recordings',
		appendTo: '#recordings-search-results',
		messages: {
			noResults: '',
			results: function*() {}
		},
		select: function(e, ui) {
			$('#recording').val(ui.item.full_title);
			$('#recording_id').val(ui.item.id);
			return false;
		}
	})
	.autocomplete('instance')._renderItem = function(ul, item) {
		var markup = [
			'<span class="name">' + item.full_title + '</span>'
		];
		return $('<li>')
			.append(markup.join(''))
			.appendTo(ul);
	}
});