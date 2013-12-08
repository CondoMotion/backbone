class Cmo.Views.PropertiesForm extends Backbone.View

  template: JST['properties/form']

  initialize: ->
    @render()

  render: ->
    $(@el).html(@template())
    this