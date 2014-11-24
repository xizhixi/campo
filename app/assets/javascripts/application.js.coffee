#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require jquery.autosize
#= require jquery.validate
#= require jquery.timeago
#= require nprogress
#= require love
#= require_tree ./plugins
#= require jquery.bxslider.min
#= require hammer.min
#= require jquery.mmenu.min
#= require jquery.fluidbox.min
#= require ms



$(document).on 'page:update', ->
  $('[data-behaviors~=autosize]').autosize()

  $("time[data-behaviors~=timeago]").timeago()

$(document).on 'page:fetch', ->
  NProgress.start()
$(document).on 'page:change', ->
  NProgress.done()
$(document).on 'page:restore', ->
  NProgress.remove()

$(document).on 'page:change', ->
  $("#left").mmenu({
    offCanvas: {
      position: "left",
      zposition: "next"
    },
    classes: "mm-white"
  });
  $("#right").mmenu({
    offCanvas: {
      position: "right",
      zposition: "next"
    },
    classes: "mm-white"
  });