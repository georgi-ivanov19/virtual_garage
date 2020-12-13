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
//= require jquery
//= require rails-ujs
//= require jquery.validate
//= require activestorage
//= require turbolinks
// = require_tree .
//= require bootstrap-sprockets

function ValidateCarForm(){
     $('#car_form').validate({
          rules: {
               'car[make]': {required: true},
               'car[model]': {required: true},
               'car[engine]': {required: true},
               'car[transmission]': {required: true},
               'car[description]': {required: true}
          },
          messages: {
               'car[make]': {required: 'You must provide the brand of your car'},
               'car[model]': {required: 'You must provide the model of your car'},
               'car[engine]': {required: 'You must provide the engine of your car'},
               'car[transmission]': {required: 'You must provide the type of transmission your car uses'},
               'car[description]': {required: 'Please provide a description of your car'}
          },
          errorElement : 'div'
     });
}

function ValidateNewUserForm(){
     $('#new_user_form').validate({
          rules: {
               'user[username]': {required: true, remote: '/check_username', minlength: 3, maxlength: 20},
               'user[email]': {required: true, email: true, remote: '/check_email'},
               'user[password]': {required: true, minlength: 6},
               'user[password_confirmation]': {required: true, equalTo: user_password}
          },
          messages: {
               'user[username]': {required: 'Please provide your username', remote: 'Username is already taken', minlength: 'Username must be longer than 3 characters', maxlength: 'Username cannot be longer than 20 characters'},
               'user[email]': {required: 'Please provide your email', email: 'Please enter a valid email address', remote: 'Email is already taken'},
               'user[password]': {required:'Please enter your password', minlength: 'Please enter 6 or more characters'},
               'user[password_confirmation]': {required:'Please confirm your password', equalTo: 'Password confirmation does not match'}
          },
          errorElement : 'div'
     });
}

function ValidateLoginForm(){
     $('#login_form').validate({
          rules: {
               'user[email]': {required: true, email: true},
               'user[password]': {required: true, minlength: 6},
          },
          messages: {
               'user[email]': {required: 'Please provide your email', email: 'Please enter a valid email address'},
               'user[password]': {required:'Please enter your password', minlength: 'Please enter 6 or more characters'},
          },
          errorElement : 'div'
     });
}

function ValidateEditUserForm(){
     $('#edit_user_form').validate({
          rules: {
               'user[email]': {required: true, email: true},
               'user[password]': {required: true, minlength: 6},
               'user[password_confirmation]': {required: true},
               'user[current_password]': {required: true}
          },
          messages: {
               'user[email]': {required: 'Please provide your email', email: 'Please enter a valid email address'},
               'user[password]': {required:'Please enter your password', minlength: 'Please enter 6 or more characters'},
               'user[password_confirmation]': {required:'Please confirm your password'},
               'user[current_password]': {required:'Please provide your current password'}
          },
          errorElement : 'div'
     });
}
function ValidateContactForm(){
     $('#contact_form').validate({
          rules: {
               'contact[name]': {required: true},
               'contact[email]': {required: true, email: true},
               'contact[message]': {required: true}
          },
          messages: {
               'contact[name]': {required: 'Please provide your name'},
               'contact[email]': {required: 'Please provide your email', email: 'Please provide a valid email address'},
               'contact[message]': {required: 'Please provide your message to us'}
          },
          errorElement : 'div'
     });
}
function ValidateCommentForm(){
     $('#comment_form').validate({
          rules: {
               'comment[content]': {required: true},

          },
          messages: {
               'comment[content]': {required: 'Comment cannot be empty'},
          },
          errorElement : 'div'
     });
}

// using this because the document.ready function would only work when the current page was refreshed
document.addEventListener("turbolinks:load", function() {
    var carShowImage = document.getElementById("show-img")
    var carShowSmallImages = document.getElementsByClassName('show-img-small')
    $(carShowSmallImages).click(function(){
         carShowImage.src = this.src
    })

    if(document.getElementById('car_form')){
          ValidateCarForm();
     }

     if(document.getElementById('new_user_form')){
          ValidateNewUserForm();
     }

     if(document.getElementById('login_form')){
          ValidateLoginForm();
     }

     if(document.getElementById('edit_user_form')){
          ValidateEditUserForm();
     }

     if(document.getElementById('contact_form')){
          ValidateContactForm();
     }

     if(document.getElementById('comment_form')){
          ValidateCommentForm();
     }
  });
