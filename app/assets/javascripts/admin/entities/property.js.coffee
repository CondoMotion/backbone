@Cmo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  
  class Entities.Property extends Entities.Model
    urlRoot: -> Routes.api_v1_properties_path()
  
  class Entities.PropertyCollection extends Entities.Collection
    model: Entities.Property
    # comparator: (model) ->
    #   model.get("name")

    url: ->
      Routes.api_v1_properties_path()
  
  API =
    getProperties: ->
      properties = new Entities.PropertyCollection
      properties.fetch
        reset: true
      properties

    getProperty: (id) ->
      property = new Entities.Property
        id: id
      property.fetch()
      property

    newProperty: ->
      new Entities.Property
  
  App.reqres.setHandler "property:entities", ->
    API.getProperties()

  App.reqres.setHandler "property:entity", (id) ->
    API.getProperty id

  App.reqres.setHandler "new:property:entity", ->
    API.newProperty()