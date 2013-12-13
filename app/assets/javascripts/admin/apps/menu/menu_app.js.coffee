@Cmo.module "MenuApp", (MenuApp, App, Backbone, Marionette, $, _) ->
  @startWithParent = false

  API = 
    list: ->
      new MenuApp.List.Controller
        region: App.menuRegion

  MenuApp.on "start", ->
    API.list()