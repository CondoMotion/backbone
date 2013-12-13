@Cmo.module "PropertiesApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Layout extends App.Views.Layout
    template: "properties/edit/edit_layout"

    regions:
      titleRegion: "#title-region"
      formRegion: "#form-region"

  class Edit.Title extends App.Views.ItemView
    template: "properties/edit/edit_title"

    modelEvents:
      "updated":  "render"

  class Edit.Property extends App.Views.ItemView
    template: "properties/edit/edit_property"