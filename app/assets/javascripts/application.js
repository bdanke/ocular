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
//= require_tree .
//= require_tree ../../../vendor/assets/javascripts

$(document).pjax(".signed-in-header-links a", ".middle-content")
$(document).pjax(".left-sidebar a", ".middle-content")
$(document).pjax(".messaged-friends-list a", ".middle-content")
$(document).pjax(".about-links a", ".middle-content")
$(document).pjax(".photos a", ".middle-content")
$(document).pjax(".albums a", ".middle-content")

$(document).ready(function(event) {
  $(".middle-content").on("ajax:success", ".status-form", function(event, data) {
    event.preventDefault();
    var $form = $(this);
    console.log("HERE!");
    $(".status-list").prepend(data);
    $form[0].reset();
  });

  $(".middle-content").on("ajax:success", ".tag-form", function(event, data) {
    event.preventDefault();
    $(".tagging").html(data);
  })

  $(".middle-content").on("ajax:success", ".comment-form", function(event, data) {
    event.preventDefault();
    var $form = $(this);
    var $list = $form.parent().children(".comment-list");
    $list.append(data);
    $form[0].reset();
  });

  $(".middle-content").on("ajax:success", ".message-form", function(event, data) {
    event.preventDefault();
    $(".middle-content").html(data);
  });

  $(".middle-content").on("ajax:success", ".friend-form", function(event, data) {
    event.preventDefault();
    $(".middle-content").html(data);
  });

  $(".middle-content").on("ajax:success", ".like-links a", function(event, data) {
    event.preventDefault();
    $(this).closest(".like-links").html(data);
  });

  $(".middle-content").on("ajax:success", ".photo-like-links a", function(event, data) {
    event.preventDefault();
    $(this).closest(".photo-like-links").html(data);
  });  

  $(".album-button").on("ajax:success", function(event, data) {
    event.preventDefault();
    $(".middle-content").html(data);
  });

  $(".middle-content").on("ajax:success", ".photo-form", function(event, data) {
    event.preventDefault();
    $(".middle-content").html(data);
  });

  $(".middle-content").on("ajax:success", ".edit-profile-link", function(event, data) {
    event.preventDefault();
    $(".middle-content").html(data);
  });
});