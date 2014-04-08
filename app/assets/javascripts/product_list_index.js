// $(document).ready(function() {
// 	$.get('product_list/list', function(data){
// 		$('#product-list').html(data);
// 	});
// });

// this is the label selector
// $(document).ready(function() {
// 	$(".type_list").click(function(event) {
// 		prodType = $("#" + $(event.target).attr("for")).attr("value");
// 		prodType = (prodType == "all_types") ? null : prodType;
// 		$.get('product_list/list', {type: prodType}, function(data){
// 			$('#product-list').html(data);
// 		});
// 	});
// });

// this listener works for both radio buttons and labels



// $(document).ready(function() {
// 	$("input[name='prod_type']").click(function(event) {
// 		prodType = $(event.target).attr("value");
// 		prodType = (prodType == "all_types") ? null : prodType;
// 		$('#product-list').fadeOut();
// 		$.get('product_list/_list', {type: prodType}, function(data){
// 		 	$('#product-list').html(data);
// 		 	$('#product-list').fadeIn();
// 		});
// 	});
// });

$(document).ready(function() {
	$("input[name='prod_type']").click(function(event) {
		prodType = $(event.target).attr("value");
		prodType = (prodType == "all_types") ? null : prodType;
		$('#product-list').fadeOut("fast", function(){
			$.get('product_list/_list', {type: prodType}, function(data){
				$('#product-list').html(data);
				$('#product-list').fadeIn("fast");
			});
		});
		
	});
});