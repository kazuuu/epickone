# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
 $('#user_city_state').autocomplete 
   source: $('#user_city_state').data('autocomplete-source')

jQuery ->
  $(".phonemask").mask("(99) 999999999")

jQuery ->
  $(".datemask").mask("99/99/9999")
