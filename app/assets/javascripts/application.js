// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require turbolinks
//= require_tree
//= require bootstrap
//= require the_comments
//= require jquery_ujs
//= require jquery.raty.min.js
//= require jquery.ui.all

$(document).ready(function() {        
	$('.carousel').carousel()
});

function toggleMessageIndicator(part_type)
{
	$("#message-indicator-"+part_type+"-light").toggle();
	$("#message-indicator-"+part_type+"-dark").toggle();
}

function toggleCitation(id)
{
	$("#citation-"+id+"-show").toggle();
	$("#citation-"+id+"-hide").toggle();
}