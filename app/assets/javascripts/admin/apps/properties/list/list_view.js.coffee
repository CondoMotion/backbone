@Cmo.module "PropertiesApp.List", (List, App, Backbone, Marionette, $, _) ->

  # class List.Properties extends App.Views.CompositeView
  #   template: "properties/list/templates/list_layout"
  #   collection: properties
  #   childViewCont

  class List.Layout extends App.Views.Layout
    template: "properties/list/list_layout"

    regions:
      propertiesRegion: "#properties-region"

  class List.Property extends App.Views.ItemView
    template: "properties/list/property"
    tagName: "li"
    className: "property"

    events:
      "click": -> @trigger "properties:property:clicked", @model
    
    triggers:
      "click": "properties:property:clicked"

  class List.Empty extends App.Views.ItemView
    template: "properties/list/empty"
    tagName: "li"

  class List.Properties extends App.Views.CompositeView
    template: "properties/list/properties"
    itemView: List.Property
    emptyView: List.Empty
    itemViewContainer: "ul"