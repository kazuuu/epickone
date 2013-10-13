$(document).ready(function() {
  $('#user-form').on("change", "#user-form-state_id", function () {
    // Access the data-cities-url set in the region field to submit JS request
    $.getScript($(this).attr('data-cities-url') + '?state_id=' + document.getElementById("user_state_id").value);
		$('#city_phone_code').replaceWith("<label id='city_phone_code' style='display:inline;'>(DDD)</label>");
		document.getElementById("user_mobile_phone_number").value='';
  });

  $('#user-form').on("change", "#cities-select-list", function () {
    // Access the data-cities-url set in the region field to submit JS request
    $.getScript($(this).attr('city_phone_code_url') + '?city_id=' + document.getElementById("user_city_id").value);
		document.getElementById("user_mobile_phone_number").value='';
  });
});
