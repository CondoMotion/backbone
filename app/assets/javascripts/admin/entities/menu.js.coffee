@Cmo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  
  class Entities.Menu extends Entities.Model
  
  class Entities.MenuCollection extends Entities.Collection
    model: Entities.Menu
  
  API =
    getMenus: ->
      new Entities.MenuCollection [
        { name: "Issues", url: "#/issues" }
        { name: "News", url: "#/news" }
        { name: "Documents", url: "#/documents" }
        { name: "Properties", url: "#/properties" }
        { name: "Users", url: "#/users" }
      ]
  
  App.reqres.setHandler "menu:entities", ->
    API.getMenus()