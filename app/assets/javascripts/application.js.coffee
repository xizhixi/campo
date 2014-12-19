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
#= require meny
#= require jquery.fluidbox.min
#= require ms
#= require jquery.smoothState


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
  Meny.create({
    menuElement: document.querySelector('.meny'),
    contentsElement: document.querySelector('.contents'),
    position: Meny.getQuery().p || 'left',
    height: 200,
    width: 260,
    threshold: 40,
    overlap: 0,
    mouse: true,
    touch: true
  });