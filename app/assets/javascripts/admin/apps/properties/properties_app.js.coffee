@Cmo.module "PropertiesApp", (PropertiesApp, App, Backbone, Marionette, $, _) ->

  class PropertiesApp.Router extends Marionette.AppRouter
    appRoutes:
      "properties"          : "list"

  API =
    list: ->
      new PropertiesApp.List.Controller

    new: (region) ->
      new PropertiesApp.New.Controller
        region: region

  App.vent.on "property:created", (property) ->
    App.navigate "properties"
    API.list()

  App.vent.on "form:cancelled", (property) ->
    App.navigate "properties"
    API.list()

  App.commands.setHandler "new:property", (region) ->
    API.new region

  App.addInitializer ->
    new PropertiesApp.Router
      controller: API
