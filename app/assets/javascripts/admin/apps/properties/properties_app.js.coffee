@Cmo.module "PropertiesApp", (PropertiesApp, App, Backbone, Marionette, $, _) ->

  class PropertiesApp.Router extends Marionette.AppRouter
    appRoutes:
      "properties"          : "paneList"
      "properties/new"      : "newList"
      "properties/:id/edit" : "editList"

  API =
    list: ->
      new PropertiesApp.List.Controller

    pane: ->
      new PropertiesApp.Pane.Controller
        region: App.paneRegion

    new: ->
      new PropertiesApp.New.Controller
        region: App.paneRegion

    edit: (id, property) ->
      new PropertiesApp.Edit.Controller
        region: App.paneRegion
        id: id
        property: property

    paneList: ->
      new PropertiesApp.List.Controller
      new PropertiesApp.Pane.Controller
        region: App.paneRegion

    newList: ->
      new PropertiesApp.List.Controller
      new PropertiesApp.New.Controller
        region: App.paneRegion

    editList: (id, property) ->
      new PropertiesApp.List.Controller
      new PropertiesApp.Edit.Controller
        region: App.paneRegion
        id: id
        property: property

  App.vent.on "new:property:button:clicked", ->
    App.navigate "properties/new"
    API.new()

  App.vent.on "property:clicked", (property) ->
    App.navigate "properties/#{property.id}/edit"
    API.edit property.id, property

  App.vent.on "edit:property:cancelled create:property:cancelled property:destroyed ", ->
    App.navigate "properties"
    API.pane()

  App.vent.on "property:updated property:created", (property) ->
    App.navigate "properties"
    API.paneList()

  App.addInitializer ->
    new PropertiesApp.Router
      controller: API
