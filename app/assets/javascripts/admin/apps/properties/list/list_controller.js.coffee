@Cmo.module "PropertiesApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base
    
    initialize:  ->
      properties = App.request "property:entities"

      App.execute "when:fetched", properties, =>
        @layout = @getLayoutView()

        @listenTo @layout, "close", @close

        @listenTo @layout, "show", =>
          @propertiesRegion properties

        @show @layout

    onClose: ->
      console.info "closing controller!"

    propertiesRegion: (properties)->
      propertiesView = @getPropertiesView properties

      @listenTo propertiesView, "childview:properties:property:clicked", (child, args) ->
        alert "Clicked a property"

      @layout.propertiesRegion.show propertiesView

    getLayoutView: ->
      new List.Layout

    getPropertiesView: (properties)->
      new List.Properties
        collection: properties