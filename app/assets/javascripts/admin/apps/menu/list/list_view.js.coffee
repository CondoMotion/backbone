@Cmo.module "MenuApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Menu extends App.Views.ItemView
    template: "menu/list/templates/menu"
    tagName: "li"

  class List.Menus extends App.Views.CompositeView
    template: "menu/list/templates/menus"
    itemView: List.Menu
    itemViewContainer: "#links"