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
    parent.displayPartial($(this), $(this).data("target"), xhr.responseText)

  $(".grid-stack").gridstack
    cell_height: 80
    vertical_margin: 10

  $("body").on "click", ".add-block", (e) ->
    $("#new-block").append("<img src='http://placehold.it/300x250' class='img-responsive' />")
    $("#blocks-modal").modal("hide")