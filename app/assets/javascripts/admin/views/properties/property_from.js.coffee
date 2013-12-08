class Cmo.Views.PropertiesForm extends Backbone.View

  template: JST['properties/form']

  initialize: ->
    @render()

    # listen for modal close event, then change route
    $('#propertyModal').on 'hidden.bs.modal', (e) ->
      Backbone.history.navigate('')
  
    
  render: ->
    $(@el).html(@template())
    this