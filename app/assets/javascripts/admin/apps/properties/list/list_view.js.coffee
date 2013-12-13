@Cmo.module "PropertiesApp.List", (List, App, Backbone, Marionette, $, _) ->

  # class List.Properties extends App.Views.CompositeView
  #   template: "properties/list/templates/list_layout"
  #   collection: properties
  #   childViewCont

  class List.Layout extends App.Views.Layout
    template: "properties/list/list_layout"

    regions:
      propertiesRegion: "#properties-region"
      panelRegion: "#panel-region"
      newRegion: "#new-region"

  class List.Panel extends App.Views.ItemView
    template: "properties/list/panel"

    triggers:
      "click #new-property": "new:property:button:clicked"

  class List.Property extends App.Views.ItemView
    template: "properties/list/property"
    tagName: "li"
    className: "property"

    triggers:
      "click .delete-property": "delete:property:link:clicked"

  class List.Empty extends App.Views.ItemView
    template: "properties/list/empty"
    tagName: "li"
    className: "empty"

  class List.Properties extends App.Views.CompositeView
    template: "properties/list/properties"
    itemView: List.Property
    emptyView: List.Empty
    itemViewContainer: "ul"