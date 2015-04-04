@showMenu = () ->
  $('#main').removeClass "full"

@hideMenu = () ->
  $('#main').addClass "full"

@toggleMenu = () ->
  $('#main').toggleClass "full"

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