class CmoBackbone.Views.Dashboard extends Backbone.View
  
  template: JST['dashboard/index']

  variables = {
    message: "Data from the view goes here..."
  }

  render: ->
    $(@el).html(@template(variables))
    this