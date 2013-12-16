@Cmo.module "PropertiesApp.Pane", (Pane, App, Backbone, Marionette, $, _) ->

  class Pane.Controller extends App.Controllers.Base
    initialize: (options)->
      paneView = @getPaneView()
      @show paneView

    getPaneView: ->
      new Pane.Show