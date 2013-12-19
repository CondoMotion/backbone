$ ->
  $("body").on "click", "#add-doc", ->
    $("#new-doc-panel").slideDown('fast')

  $("body").on "click", "#cancel-add-doc, #submit-add-doc", ->
    $("#new-doc-panel").slideUp('fast')

  $("body").on "click", ".console-search-result-item", ->
    $(".console-search-result-item").removeClass("active")
    $(this).addClass("active")
    unless $(this).hasClass("doc")
      panel = $("#main-nav li.active a").data("panel-div")
      div = "#edit" + panel
      html = $(div).html()
      $(".console-viewport").html(html)

  $("body").on "click", "#doc-filters .categories .category, #doc-filters ul li a", ->
    $("#list-docs").removeClass("category1").removeClass("category2").removeClass("category3").removeClass("category4")
    if $(this).hasClass("category")
      unless $(this).hasClass("active")
        $("#list-docs").addClass($(this).data("filtertext"))
    if $(this).hasClass("active")
      $(this).removeClass("active")
    else
      $("#doc-filters .categories .category.active, #doc-filters ul li a.active").removeClass("active")
      $(this).addClass("active")

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
      panel = $("#main-nav li.active a").data("panel-div")
      div = "#empty" + panel
      html = $(div).html()
      $(".console-viewport").html(html)
    $("#doc-filters .categories .category.active").each ->
      $("#list-docs").addClass($(this).data("filtertext"))

  $("body").on "click", "#main-nav li a", ->
    if $(this).parents("li").hasClass("active")
      return false
    else
      resource = $(this).text().toLowerCase()
      $(".content-pane").removeClass("issues").removeClass("news").removeClass("documents").removeClass("users").addClass(resource)
      $(".console-search-result-item").removeClass("active")
      $("#filter-items").removeClass("btn-danger").addClass("btn-default")
      panel = $(this).data("panel-div")
      div = "#empty" + panel
      html = $(div).html()
      $(".console-viewport").html(html)
      $("#main-nav li, #doc-filters .categories .category, #doc-filters ul li a").removeClass("active")
      $("#list-docs").removeClass("category1").removeClass("category2").removeClass("category3").removeClass("category4")
      $(this).parents("li").addClass("active")

  $("body").on "click", ".cancel", ->
    $(".console-search-result-item").removeClass("active")
    panel = $("#main-nav li.active a").data("panel-div")
    div = "#empty" + panel
    html = $(div).html()
    $(".console-viewport").html(html)

  $("body").on "click", ".action-pane .btn, #add-item", ->
    $(".console-search-result-item").removeClass("active")

  $("#nav .property-settings").click ->
    alert "Settings for " + $(this).parents("a").text()
    return false

  empty = $(".console-viewport").html()

  $("body").on "change", "#user_role", ->
    if $(this).val() == "Manager"
      $("#manager_permissions").show()
      $("#resident_permissions").hide()
    else
      $("#resident_permissions").show()
      $("#manager_permissions").hide()


  $("body").on "click", ".action-pane .btn, #add-item", ->
    panel = $("#main-nav li.active a").data("panel-div")
    div = "#new" + panel
    html = $(div).html()
    $(".console-viewport").html(html)

  $("body").on "click", ".navbar-collapse.in li a", ->
    $(".navbar-collapse").collapse("hide") unless $(this).hasClass("dropdown-toggle")