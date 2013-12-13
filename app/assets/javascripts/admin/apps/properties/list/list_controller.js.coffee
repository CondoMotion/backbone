@Cmo.module "PropertiesApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base
    
    initialize:  ->
      properties = App.request "property:entities"

      App.execute "when:fetched", properties, =>
        @layout = @getLayoutView()

        @listenTo @layout, "close", @close

        @listenTo @layout, "show", =>
          @propertiesRegion properties
          @panelRegion()

        @show @layout

    onClose: ->
      console.info "closing controller!"

    panelRegion: ->
      panelView = @getPanelView()

      panelView.on "new:property:button:clicked", =>
        @newRegion()

      @layout.panelRegion.show panelView

    newRegion: ->
      App.execute "new:property", @layout.newRegion

    propertiesRegion: (properties)->
      propertiesView = @getPropertiesView properties

      @listenTo propertiesView, "childview:property:clicked", (child, args) ->
        App.vent.trigger "property:clicked", args.model

      @listenTo propertiesView, "childview:delete:property:link:clicked", (child, args) ->
        model = args.model
        if confirm "Are you sure you want to delete #{model.get("name")}?" then model.destroy() else false

      @layout.propertiesRegion.show propertiesView

    getLayoutView: ->
      new List.Layout

    getPropertiesView: (properties)->
      new List.Properties
        collection: properties

    getPanelView: ->
      new List.Panel