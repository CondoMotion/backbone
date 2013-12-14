@Cmo.module "Components.Form", (Form, App, Backbone, Marionette, $, _ ) ->

  class Form.FormWrapper extends App.Views.Layout
    template: "form/form"

    tagName: "form"
    attributes: ->
      "data-type": @getFormDataType()

    regions:
      formContentRegion: "#form-content-region"

    ui:
      buttonContainer: "#buttons"

    triggers:
      "submit": "form:submit"
      "click [data-form-button='cancel']": "form:cancel"

    modelEvents:
      "change:_errors": "changeErrors"
      "sync:start"    : "syncStart"
      "sync:complete" : "syncStop"

    initialize: ->
      @setInstancePropertiesFor "config", "buttons"

    serializeData: ->
      footer: @config.footer
      buttons: @buttons?.toJSON() ? false
      
    onShow: ->
      _.defer =>
        @focusFirstInput() if @config.focusFirstInput
        @buttonPlacement() if @buttons

    focusFirstInput: ->
      @$(':input:visible:enabled:first').focus()

    buttonPlacement: ->
      @ui.buttonContainer.addClass @buttons.placement

    getFormDataType: ->
      if @model.isNew() then "new" else "edit"

    changeErrors: (model, errors, options) ->
      if @config.errors
        if _.isEmpty(errors) then @removeErrors() else @addErrors errors

    removeErrors: ->
      @$('.has-error').removeClass('has-error').find(".help-block").remove()

    addErrors: (errors = {}) ->
      console.log errors
      for name, array of errors
        @addError name, array[0]

    addError: (name, error) ->
      modName = name.replace(".", "_")
      el=@$("##{modName}")
      sm = $("<span class='help-block'>").text(error)
      el.after(sm).closest(".form-group").addClass("has-error")

    syncStart: (model) ->
      @addOpacityWrapper() if @config.syncing

    syncStop: (model) ->
      @addOpacityWrapper(false) if @config.syncing
