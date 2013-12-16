@Cmo.module "PropertiesApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.Layout
    template: "properties/list/list_layout"

    regions:
      propertiesRegion: "#properties-region"
      panelRegion: "#panel-region"

  class List.Panel extends App.Views.ItemView
    template: "properties/list/panel"

    triggers:
      "click .new-property": "new:property:button:clicked"

  class List.Property extends App.Views.ItemView
    template: "properties/list/property"
    tagName: "li"
    className: "property"
    opacity: "true"

    events:
      "click": -> @trigger "property:clicked", @model
    
    triggers:
      "click .delete-property": "delete:property:link:clicked"
      "click"                 : "property:clicked"

  class List.Empty extends App.Views.ItemView
    template: "properties/list/empty"
    tagName: "li"
    className: "empty"

  class List.Properties extends App.Views.CompositeView
    template: "properties/list/properties"
    itemView: List.Property
    emptyView: List.Empty
    itemViewContainer: "ul"