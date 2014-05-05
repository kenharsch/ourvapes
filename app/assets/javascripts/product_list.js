$(document).on('ready page:load', function() {
	// compatibility click listeners
	$('.compat-filter').click(function(){update(this, 'compat');});

	// manufacturer clear button click listener
	$('#compat-filter-clear').click(function(){clear('compats');});

	// type filter click listeners
	$('.type-filter').click(function(){setType(this);});

	// manufacturer filter click listeners
	$('.manu-filter').click(function(){update(this, 'manu');});

	// manufacturer clear button click listener
	$('#manu-filter-clear').click(function(){clear('manus');});
});

function update(filter_el, type) {
	var key_prefix = $(filter_el).is("[checked]") ? "remove" : "add";
	var url = "update?"+key_prefix + "_" + type + "=" + $(filter_el).attr("filter_name");
	window.location = url
}

function clear(type) {
	window.location = "update?clear_" + type + "=true";
}

function setType(filter_el) {
	window.location = "update?set_type="+$(filter_el).attr("filter_name");
}