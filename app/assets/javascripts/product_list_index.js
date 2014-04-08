// var ready;
// ready = function() {
// 		$.get('configuration', {}, function(data){
// 			$('#product-list').html(data);
// 		});

// 	};

// $(document).ready(ready);

$(document).ready(function() {
	$.get('product_list/list', function(data){
		$('#product-list').html(data);
	});
});

$(document).ready(function() {
	$(".type_list").click(function(event) {
		$.get('product_list/list', {type: $("#" + $(event.target).attr("for")).attr("value")} ,function(data){
			$('#product-list').html(data);
		});
	});
});