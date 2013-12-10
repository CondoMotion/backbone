class Cmo.Views.PropertiesForm extends Backbone.View

  template: JST['properties/form']

  events:
    'click #propertySubmit': 'propertySubmit'

  initialize: ->
    @render()

    # respond to modal closing
    $('#propertyModal').on 'hidden.bs.modal', (e) ->
      Backbone.history.navigate('')
      
  render: ->
    $(@el).html(@template())
    this

  propertySubmit: (event) ->
    event.preventDefault()
    name = $('#propertyName').val()
    pwd  = $('#signupPassword').val()
    # TODO: validation
    @collection.create({name: name, signup_password: pwd})