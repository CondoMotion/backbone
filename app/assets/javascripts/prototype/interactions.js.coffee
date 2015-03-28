@displayPartial = (target, html) ->
  # $('#main').removeClass "full"
  $(target).html html

$ ->
  $(".prototype-partial-link").on "ajax:success", (e, data, status, xhr) ->
    alert data

  $("body").on "ajax:error", ".prototype-partial-link", (e, xhr, status, error) ->
    console.log error
    parent.displayPartial($(this).data("target"), xhr.responseText)