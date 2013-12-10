$ ->
  $(window).hashchange ->
    tabName = "a[href='" + location.hash + "']"
    $(tabName).tab('show')

  $(window).hashchange()

  $("a[data-toggle=\"tab\"]").on "shown.bs.tab", (e) ->
    document.location.hash = $(this).attr('href')
    window.scrollTo(0,0)

  $("body").on 'submit', '.edit_admin_user, .edit_subscription', ->
    $(this).children('.loading').removeClass('hide')
    $(this).children('input[type=submit]').attr('disabled', true).val("Updating...")