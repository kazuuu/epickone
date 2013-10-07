$(document).ready(function() {
  $('#user-form').on("change", "#user-form-state_id", function () {
    // Access the data-cities-url set in the region field to submit JS request
    $.getScript($(this).attr('data-cities-url') + '?state_id=' + document.getElementById("user_state_id").value);
  });
});
