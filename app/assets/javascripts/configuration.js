function toggleArrow(part_type)
{
	$("#desc-"+part_type+"-less").toggle();
	$("#desc-"+part_type+"-more").toggle();
}

var ready;
ready = function() {

	$.get('product/', {id: 100}, function(data){
		$('#mydiv').html(data);
	});

};

$(document).ready(ready);
$(document).on('page:load', ready);