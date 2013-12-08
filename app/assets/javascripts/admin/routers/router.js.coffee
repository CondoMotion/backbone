class Cmo.Router extends Backbone.Router
  routes: 
    ''               :   'dashboard'
    'properties'     :   'dashboard'
    'properties/new' :   'newProperty'
    
  dashboard: ->

  newProperty: ->
    $('#propertyModal').modal('show')