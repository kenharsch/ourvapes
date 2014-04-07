var ready;
ready = function() {

	$.get('shared/list', {}, function(data){
		$('#product-list').html(data);
	});

};

$(document).ready(ready);
$(document).on('page:load', ready);