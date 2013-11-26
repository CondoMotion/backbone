class CmoBackbone.Views.Dashboard extends Backbone.View
  
  template: JST['dashboard/index']

  variables = {
    message: "Data from the backbone dashboard view goes here..."
  }

  render: ->
    $(@el).html(@template(variables))
    this