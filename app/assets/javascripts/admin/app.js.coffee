window.CmoBackbone =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> 
    new CmoBackbone.Router
    Backbone.history.start()

$ ->
  CmoBackbone.initialize()