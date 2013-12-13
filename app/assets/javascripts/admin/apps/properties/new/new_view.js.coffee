@Cmo.module "PropertiesApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.Property extends App.Views.ItemView
    template: "properties/new/new_property"