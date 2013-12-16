@Cmo.module "PropertiesApp", (PropertiesApp, App, Backbone, Marionette, $, _) ->

  class PropertiesApp.Router extends Marionette.AppRouter
    appRoutes:
      "properties/:id/edit" : "edit"
      "properties"          : "list"
      "properties/new"      : "new"

  API =
    list: ->
      new PropertiesApp.List.Controller
      new PropertiesApp.Pane.Controller
        region: App.paneRegion

    new: (showList) ->
      new PropertiesApp.List.Controller unless showList == "false"
      new PropertiesApp.New.Controller
        region: App.paneRegion

    edit: (id, property, showList) ->
      new PropertiesApp.List.Controller unless showList == "false"
      new PropertiesApp.Edit.Controller
        region: App.paneRegion
        id: id
        property: property

  App.vent.on "new:property:button:clicked", ->
    App.navigate "properties/new"
    API.new "false"

  App.vent.on "property:clicked", (property) ->
    App.navigate "properties/#{property.id}/edit"
    API.edit property.id, property, "false"

  App.vent.on "form:cancelled property:cancelled property:destroyed create:property:cancelled property:updated property:created", (property) ->
    App.navigate "properties"
    API.list()

  App.addInitializer ->
    new PropertiesApp.Router
      controller: API
