@Cmo.module "PropertiesApp.Pane", (Pane, App, Backbone, Marionette, $, _) ->

  class Pane.Controller extends App.Controllers.Base
    initialize: (options)->
      paneView = @getPaneView()

      paneView.on "new:property:button:clicked", =>
        App.vent.trigger "new:property:button:clicked"
        
      @show paneView

    getPaneView: ->
      new Pane.Show