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
    console.log "Submitting form"
    name = $('#propertyName').val()
    signup_password = $('#signupPassword').val()
    # TODO: validation
    @collection.create {name: name, signup_password: signup_password},
      wait: true
      success: -> 
        $('form')[0].reset()
        $("#propertyModal").modal("hide")
        Backbone.history.navigate('')
      error: @handleError

  handleError: (property, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages