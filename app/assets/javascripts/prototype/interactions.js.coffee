@toggleNav = () ->
  $(".sidebar-nav").toggleClass "panel-open"

@openNav = () ->
  $(".sidebar-nav").addClass "panel-open"

@closeNav = () ->
  $(".sidebar-nav").removeClass "panel-open"

@showMenu = () ->
  $('#main').removeClass "full"

@hideMenu = () ->
  $('#main').addClass "full"

@toggleMenu = () ->
  $('#main').toggleClass "full"

@toggleThirdMenu = () ->
  $(".sidebar-nav").toggleClass "third-panel-open"

@displayPartial = (link, target, html) ->
  if link.hasClass "show-menu"
    @showMenu()
  if link.hasClass "hide-menu"
    @hideMenu()
  $(target).html html

$ ->
  $("body").on "click", ".properties-nav-link", (e) ->
    e.preventDefault()
    parent.toggleThirdMenu()
    
  $(".prototype-partial-link").on "ajax:success", (e, data, status, xhr) ->
    alert data

  $("body").on "ajax:error", ".prototype-partial-link", (e, xhr, status, error) ->
    parent.displayPartial($(this), $(this).data("target"), xhr.responseText)
    $(".sidebar-nav__panel-secondary").html($(this).data('menu'))

  $(".grid-stack").gridstack
    cell_height: 80
    vertical_margin: 10

  $("body").on "click", ".add-block", (e) ->
    $("#new-block").append("<img src='http://placehold.it/300x250' class='img-responsive' />")
    $("#blocks-modal").modal("hide")

  $("body").on "click", ".issue-tab", (e) ->
    $(".issue-tab").removeClass "active"
    $(@).addClass "active"

  $("body").on "click", ".toggle-nav", (e) ->
    parent.toggleNav()

  $("body").on "click", ".close-nav", (e) ->
    parent.closeNav()

  $("body").on "click", ".open-nav", (e) ->
    parent.openNav()