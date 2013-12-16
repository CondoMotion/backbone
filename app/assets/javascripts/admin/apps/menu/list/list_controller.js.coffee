@Cmo.module "MenuApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: ->
      links = App.request "menu:entities"

      listView = @getListView(links)

      @listenTo listView, "signOut:button:clicked", ->
        alert "Hello"

      @show listView

    getListView: (links) ->
      new List.Menus
        collection: links