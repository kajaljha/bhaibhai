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
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/2/jquery.dataTables.bootstrap
//= require dataTables/jquery.dataTables
//= require bootstrap-sprockets
//= require moment
//= require select2
//= require bootstrap-datetimepicker
//= require_tree .


$( document ).ready(function() {
  $(".alert" ).fadeOut(3000);
  $(".alert-success").fadeOut(3000);
  $(".alert-danger").fadeOut(3000);
});