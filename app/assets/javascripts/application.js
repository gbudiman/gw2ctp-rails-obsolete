// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

// $(document).ready(function() {
// 	$(".drillthrough").click(drillthrough($(this)));
// });
$(document).on('click', '.drillthrough', function(e) {
	drillthrough($(this));
});

function drillthrough(o) {
	tree = o.attr('id').split();
	node = tree[tree.length - 1];
	children_class = tree.join('-') + '-';
	depth = o.attr('depth') || 0;
	$('tr#' + o.attr('id')).after(
		'<tr class="removable">' +
			'<td colspan = 8> ... fetching data ... </td>' +
		'</tr>'
	);
	$('tr[id^=' + children_class + ']').remove();

	$.ajax({
		type: 'GET',
		url: 'crafts/' + node
	}).done(function(msg) {
		$('.removable').remove();
		$('tr#' + o.attr('id')).after(msg);
	});
}
