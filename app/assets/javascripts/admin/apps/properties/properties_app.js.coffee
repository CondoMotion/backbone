@Cmo.module "PropertiesApp", (PropertiesApp, App, Backbone, Marionette, $, _) ->

  class PropertiesApp.Router extends Marionette.AppRouter
    appRoutes:
      "properties/:id/edit" : "edit"
      "properties"          : "list"

  API =
    list: ->
      new PropertiesApp.List.Controller

    new: (region) ->
      new PropertiesApp.New.Controller
        region: region

    edit: (id, property) ->
      new PropertiesApp.Edit.Controller
        id: id
        property: property

  App.vent.on "property:created", (property) ->
    App.navigate "properties"
    API.list()

  App.vent.on "property:clicked", (property) ->
    App.navigate "properties/#{property.id}/edit"
    API.edit property.id, property

  App.vent.on "form:cancelled property:cancelled property:updated", (property) ->
    App.navigate "properties"
    API.list()

  App.commands.setHandler "new:property", (region) ->
    API.new region

  App.addInitializer ->
    new PropertiesApp.Router
      controller: API
