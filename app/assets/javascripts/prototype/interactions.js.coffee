@showMenu = () ->
  $("#toggle-menu-link", $('#website-iframe').contents()).html("<i class='fa fa-long-arrow-up fa-rotate-315'></i>")
  $('#main').removeClass "full"

@hideMenu = () ->
  $("#toggle-menu-link", $('#website-iframe').contents()).html("<i class='fa fa-long-arrow-up fa-rotate-135'></i>")
  $('#main').addClass "full"

@toggleMenu = () ->
  $("#toggle-menu-link", $('#website-iframe').contents()).html("<i class='fa fa-long-arrow-up fa-rotate-#{angle($('#main').hasClass("full"))}'></i>")
  $('#main').toggleClass "full"

@angle = (full) ->
  if full
    "315"
  else
    "135"

@displayPartial = (link, target, html) ->
  if link.hasClass "show-menu"
    @showMenu()
  if link.hasClass "hide-menu"
    @hideMenu()
  $(target).html html

$ ->
  $(".prototype-partial-link").on "ajax:success", (e, data, status, xhr) ->
    alert data

  $("body").on "ajax:error", ".prototype-partial-link", (e, xhr, status, error) ->
    console.log error
    parent.displayPartial($(this), $(this).data("target"), xhr.responseText)