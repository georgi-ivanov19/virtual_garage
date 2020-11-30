// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
$(function() {
    // Add click event binding to `Save search` link
    $("#save_search").on("click", function(event) {
        event.preventDefault(); // don't trigger default

        // get the value inside the text field
        var name = $("#search_name").val();

        $.post('/save_search', { search_name: name }, function(data) {
            // log the result from the server, or whatever...
            console.log(data);
        });
    });
});