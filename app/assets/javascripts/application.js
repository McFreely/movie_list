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
//= require foundation
//= require_tree .


$(document).ready(function() {
function Stylize(element, color) {
	
	var radio = $(element);
	$(radio).wrap('<a href="#" class="stylize-common" > ')
		   .css("visibility", "hidden");
	var wrapper = $(radio).parent();
	
	$(wrapper).on('click', function() {
		
		var $this = $(this);
		var itemTitle = $('input#item_title');
	
		$('.radio_btn').attr("checked", false);
		$('#search a').removeClass('inset');
		$this.addClass('inset')
			 .children(radio).attr("checked", true);
		itemTitle.removeClass('wrapper_blue wrapper_yellow wrapper_red wrapper_purple wrapper_green')
				 .addClass('wrapper_' + color);
	});
}
Stylize("#item_categorie_movie", "blue");
Stylize("#item_categorie_book", "yellow");
Stylize("#item_categorie_tv", "red");
Stylize("#item_categorie_music", "purple");
Stylize("#item_categorie_game", "green");

});