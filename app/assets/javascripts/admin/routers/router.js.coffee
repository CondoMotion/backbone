class CmoBackbone.Router extends Backbone.Router
  routes: 
    '': 'dashboard'

  dashboard: ->
    view = new CmoBackbone.Views.Dashboard
    $("#dashboard").html(view.render().el)