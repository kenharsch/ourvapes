$(document).on('ready page:load', function() {
	// set the type filter click listeners
	$('.type-filter').click(function(){setType(this);});

	// set the manufacturer filter click listeners
	$('.manu-filter').click(function(){updateManus(this);});

	// set the manufacturer clear button click listener
	$('#manu-filter-clear').click(function(){clearManusFunction();});
});

function setType(filter_el) {
	window.location = "update?set_type="+$(filter_el).attr("filter_name");
}

function updateManus(filter_el) {
	var key_prefix = $(filter_el).is("[selected]") ? "remove" : "add";
	var url = "update?"+key_prefix+"_manu="+$(filter_el).attr("filter_name");
	window.location = url
}

function clearManusFunction() {
	window.location = "update?clear_manus=true";
}