@Cmo.module "PropertiesApp.Pane", (Pane, App, Backbone, Marionette, $, _) ->

  class Pane.Show extends App.Views.ItemView
    template: "properties/pane/show"