class CmoBackbone.Views.Dashboard extends Backbone.View
  
  template: JST['dashboard/index']

  render: ->
    $(@el).html(@template(message: "Data from the view goes here..."))
    this