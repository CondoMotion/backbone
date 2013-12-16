@Cmo.module "PropertiesApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.Controller extends App.Controllers.Base

    initialize: (options={}) ->
      {property, id} = options
      property or= App.request "property:entity", id

      @listenTo property, "updated", ->
        App.vent.trigger "property:updated", property

      @listenTo property, "destroy", ->
        App.vent.trigger "property:destroyed"

      App.execute "when:fetched", property, =>
        @layout = @getLayoutView property

        @listenTo @layout, "show", =>
          @titleRegion property
          @formRegion property

        @show @layout

    titleRegion: (property) ->
      titleView = @getTitleView property

      @layout.titleRegion.show titleView

    formRegion: (property) ->
      editView = @getEditView property

      @listenTo editView, "form:cancel", ->
        App.vent.trigger "edit:property:cancelled", property

      formView = App.request "form:wrapper", editView,
        footer: true

      @layout.formRegion.show formView

    getLayoutView: (property) ->
      new Edit.Layout
        model: property

    getEditView: (property) ->
      new Edit.Property
        model: property

    getTitleView: (property) ->
      new Edit.Title
        model: property

