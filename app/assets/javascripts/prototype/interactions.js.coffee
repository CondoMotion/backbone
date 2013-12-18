$ ->
  $("body").on "click", ".console-search-result-item", ->
    $(".console-search-result-item").removeClass("active")
    $(this).addClass("active")

  $("body").on "click", "#nav li a", ->
    $("#nav li").removeClass("active")
    $(this).parents("li").addClass("active")

  $("body").on "click", "#main-nav li a", ->
    $("#main-nav li").removeClass("active")
    $(this).parents("li").addClass("active")
    resource = $(this).text().toLowerCase()
    $(".content-pane").removeClass("issues").removeClass("news").removeClass("documents").removeClass("users").addClass(resource)
    $(".action-pane .btn").text("New " + $(this).data("button-text"))
    $(".console-search-result-item").removeClass("active")

  $("#nav button").click ->
    alert "Settings for " + $(this).parents("a").text()