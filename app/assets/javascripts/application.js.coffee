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

#stanislav.it/how-to-prevent-ios-standalone-mode-web-apps-from-opening-links-in-safari
if ("standalone" of window.navigator) and window.navigator.standalone
  noddy = undefined
  remotes = false
  document.addEventListener "click", ((event) ->
    noddy = event.target
    noddy = noddy.parentNode  while noddy.nodeName isnt "A" and noddy.nodeName isnt "HTML"
    if "href" of noddy and noddy.href.indexOf("http") isnt -1 and (noddy.href.indexOf(document.location.host) isnt -1 or remotes)
      event.preventDefault()
      document.location.href = noddy.href
    return
  ), false