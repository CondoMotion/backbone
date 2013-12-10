class Cmo.Collections.Properties extends Backbone.Collection
  # TODO: where to define this globally?h
  url: ->
    'http://cmobb.dev/api/v1/properties.json'
  model: Cmo.Models.Property
