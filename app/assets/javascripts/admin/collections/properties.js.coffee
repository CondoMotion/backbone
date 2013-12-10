class Cmo.Collections.Properties extends Backbone.Collection
  # TODO: where to define this globally?h
  url: ->
    'api/v1/properties'
  model: Cmo.Models.Property
