// var ready;
// ready = function() {

// 	$.get('/shared/list', {}, function(data){
// 		$('#product-list').html(data);
// 	});

// };

// $(document).ready(ready);
// $(document).on('page:load', ready);

$(document).on('ready page:load', function() {
	var types = ["mouthpiece", "tank", "wick", "button", "battery", "charger"];
	for (var i = 0; i < types.length; i++) {
		$("#prod_type_"+types[i]).on("click",function() {
			var type = String(this.id).charAt(10).toUpperCase()+String(this.id).slice(11);
			window.location = "?type="+type;
		});
	}
});
$(document).on('ready page:load', function() {
	$("#prod_type").on("click",function() {
		window.location = "?type=";
	});
});