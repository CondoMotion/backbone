@Cmo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  
  class Entities.Property extends Entities.Model
    urlRoot: -> Routes.api_v1_properties_path()
  
  class Entities.PropertyCollection extends Entities.Collection
    model: Entities.Property

    url: ->
      Routes.api_v1_properties_path()
  
  API =
    getProperties: ->
      console.log "Getting properties"
      properties = new Entities.PropertyCollection
      properties.fetch
        reset: true
      console.log properties
      properties
  
  App.reqres.setHandler "property:entities", ->
    API.getProperties()