class Cmo.Views.Dashboard extends Backbone.View
  
  template: JST['dashboard/index']

  events:
    'click #sidebar-toggle': 'sidebarToggle'
    
  initialize:->
    @render()

    properties = new Cmo.Collections.Properties()
    properties.fetch({reset:true})
    
    propertiesView = new Cmo.Views.PropertiesIndex(el: '#propertyList', collection: properties)
    propertiesForm = new Cmo.Views.PropertiesForm (el: '#propertyForm', collection: properties)
        
  render: ->
    $(@el).html(@template())
    this

  sidebarToggle: (event) ->
    event.preventDefault()
    $("#dashboard-wrap").toggleClass("active")
