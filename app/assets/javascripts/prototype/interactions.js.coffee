$ ->
  $("body").on "click", ".console-search-result-item", ->
    $(".console-search-result-item").removeClass("active")
    $(this).addClass("active")

  $("body").on "click", "#nav li a", ->
    el = $(this)
    $("#nav li").removeClass("active")
    el.parents("li").addClass("active")
    filter = el.data("listfilter")
    $(".content-pane").first().attr("data-listfilter", filter)

  $("body").on "click", "#main-nav li a", ->
    resource = $(this).text().toLowerCase()
    $(".content-pane").removeClass("issues").removeClass("news").removeClass("documents").removeClass("users").addClass(resource)
    $(".action-pane .btn").text("New " + $(this).data("button-text"))
    unless $(this).parents("li").hasClass("active")
      $(".console-search-result-item").removeClass("active")
      $("#filter-items").removeClass("btn-danger").addClass("btn-default")
    $("#main-nav li").removeClass("active")
    $(this).parents("li").addClass("active")

  $("body").on "click", ".action-pane .btn, #add-item", ->
    $(".console-search-result-item").removeClass("active")

  $("body").on "click", "#filter-items", ->
    $(this).toggleClass("btn-default").toggleClass("btn-danger")

  $("#nav .property-settings").click ->
    alert "Settings for " + $(this).parents("a").text()
    return false