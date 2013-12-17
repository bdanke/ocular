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

$(document).ready(function(event) {
  $(".signed-in-header-links").on("ajax:success", "a", function(event, data) {
    $(".middle-content").html(data);
  });

  $(".left-sidebar").on("ajax:success", "a", function(event, data) {
    $(".middle-content").html(data);
  });

  // $("a").on("ajax:success", function(event, data) {
  //   $(".middle-content").html(data);
  // });

  // $(".middle-content").on("ajax:success", "a", function(event, data) {
  //   $(".middle-content").html(data);
  // });

  $("messaged-friends-list").on("ajax:success", function(event, data) {
    $(".middle-content").html(data);
  })

  $(".middle-content").on("ajax:success", ".status-form", function(event, data) {
    var $form = $(this);
    console.log("HERE!");
    $(".status-list").prepend(data);
    $form[0].reset();
  });

  $(".status .comment-data").on("ajax:success", ".comment-form", function(event, data) {
    var $form = $(this);
    var $list = $form.parent().children(".comment-list");
    $list.append(data);
    $form[0].reset();
  });

  $(".middle-content").on("ajax:success", ".message-form", function(event, data) {
    $(".middle-content").html(data);
  });

  $(".middle-content").on("ajax:success", ".friend-button", function(event, data) {
    $(".middle-content").html(data);
  });

  $(".middle-content").on("ajax:success", ".like-links a", function(event, data) {
    $(this).closest(".like-links").html(data);
  });

  $(".middle-content").on("ajax:success", ".about-links a", function(event, data) {
    console.log("HERE");
    $(".middle-content").html(data);
  });

  $(".middle-content").on("ajax:success", ".photos a", function(event, data) {
    $(".middle-content").html(data);
  });

  $(".middle-content").on("ajax:success", ".albums a", function(event, data) {
    $(".middle-content").html(data);
  });

  $(".album-button").on("ajax:success", function(event, data) {
    $(".middle-content").html(data);
  });

  $(".middle-content").on("ajax:success", ".photo-form", function(event, data) {
    $(".middle-content").html(data);
  });

  $(".middle-content").on("ajax:success", ".edit-profile-link", function(event, data) {
    $(".middle-content").html(data);
  });
});