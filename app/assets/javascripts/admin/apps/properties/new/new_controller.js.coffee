@Cmo.module "PropertiesApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Controller extends App.Controllers.Base
    initialize: (options)->

      property = App.request "new:property:entity"

      @listenTo property, "created", ->
        App.vent.trigger "property:created", property

      newView = @getNewView(property)

      formView = App.request "form:wrapper", newView

      @listenTo newView, "form:cancel", =>
        @region.close()

      @show formView

    getNewView: (property) ->
      new New.Property
        model: property