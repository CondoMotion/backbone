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

    pane: ->
      new PropertiesApp.Pane.Controller
        region: App.paneRegion

    new: (noList) ->
      new PropertiesApp.List.Controller unless noList
      new PropertiesApp.New.Controller
        region: App.paneRegion

    edit: (id, property, noList) ->
      new PropertiesApp.List.Controller unless noList
      new PropertiesApp.Edit.Controller
        region: App.paneRegion
        id: id
        property: property

  App.vent.on "new:property:button:clicked", (noList) ->
    App.navigate "properties/new"
    API.new(noList)

  App.vent.on "property:clicked", (property, noList) ->
    App.navigate "properties/#{property.id}/edit"
    API.edit property.id, property, noList

  App.vent.on "edit:property:cancelled create:property:cancelled", ->
    App.navigate "properties"
    API.pane()

  App.vent.on "property:destroyed property:updated property:created", (property) ->
    App.navigate "properties"
    API.list()

  App.addInitializer ->
    new PropertiesApp.Router
      controller: API
