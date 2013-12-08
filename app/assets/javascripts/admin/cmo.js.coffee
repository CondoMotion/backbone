window.Cmo =

  Models: {}
  Collections: {}
  Views: {}
  
  init: ->
    @dashView = new Cmo.Views.Dashboard({el:"#dashboard"})
    new Cmo.Router
    Backbone.history.start()

$ ->
  Cmo.init()

