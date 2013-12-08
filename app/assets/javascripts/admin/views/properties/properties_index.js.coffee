class Cmo.Views.PropertiesIndex extends Backbone.View

  template: JST['properties/index']

  events:
    'click #addProperty':    'addProperty'

  initialize: ->
    @render()


  render: ->
    console.log('rendering properties index')
    $(@el).html(@template())
    this

  addProperty: (event) ->
    event.preventDefault()
    $('#propertyModal').modal('show')
    Backbone.history.navigate('properties/new')

