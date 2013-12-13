@Cmo.module "PropertiesApp", (PropertiesApp, App, Backbone, Marionette, $, _) ->

  class PropertiesApp.Router extends Marionette.AppRouter
    appRoutes:
      "properties"          : "list"

  API =
    list: ->
      new PropertiesApp.List.Controller

  App.addInitializer ->
    new PropertiesApp.Router
      controller: API
