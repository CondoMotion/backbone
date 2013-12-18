$ ->
  $("body").on "click", ".console-search-result-item", ->
    $(".console-search-result-item").removeClass("active")
    $(this).addClass("active")
    editDiv = $(this).data("edit-div")
    html = $(editDiv).html()
    $(".console-viewport").html(html)

  $("body").on "click", "#nav li a", ->
    el = $(this)
    $("#nav li").removeClass("active")
    el.parents("li").addClass("active")
    filter = el.data("listfilter")
    $(".content-pane").first().attr("data-listfilter", filter)
    $(".console-search-result-item").each ->
      unless $(this).is(":visible")
        $(this).removeClass("active")
    if $(".console-search-result-item.active").length == 0
      $(".console-viewport").html(empty)
      $(".action-pane .btn").text("New " + $("#main-nav li.active a").data("button-text"))

  $("body").on "click", "#main-nav li a", ->
    resource = $(this).text().toLowerCase()
    $(".content-pane").removeClass("issues").removeClass("news").removeClass("documents").removeClass("users").addClass(resource)
    unless $(this).parents("li").hasClass("active")
      $(".console-search-result-item").removeClass("active")
      $("#filter-items").removeClass("btn-danger").addClass("btn-default")
      $(".console-viewport").html(empty)
    $("#main-nav li").removeClass("active")
    $(this).parents("li").addClass("active")
    $(".action-pane .btn").text("New " + $(this).data("button-text"))

  $("body").on "click", ".action-pane .btn, #add-item", ->
    $(".console-search-result-item").removeClass("active")

  $("body").on "click", "#filter-items", ->
    $(this).toggleClass("btn-default").toggleClass("btn-danger")

  $("#nav .property-settings").click ->
    alert "Settings for " + $(this).parents("a").text()
    return false

  empty = $(".console-viewport").html()

  $("body").on "click", ".action-pane .btn, #add-item", ->
    div = $("#main-nav li.active a").data("new-div")
    html = $(div).html()
    $(".console-viewport").html(html)