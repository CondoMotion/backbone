class Cmo.Views.Dashboard extends Backbone.View
  
  template: JST['dashboard/index']

  events:
    'click #sidebar-toggle': 'sidebarToggle'
    
  initialize:->
    @render()
    propertiesView = new Cmo.Views.PropertiesIndex(el: '#propertyList')
    propertiesForm = new Cmo.Views.PropertiesForm(el: '#propertyForm')
    
  render: ->
    $(@el).html(@template())
    this

  sidebarToggle: (event) ->
    event.preventDefault()
    $("#dashboard-wrap").toggleClass("active")
