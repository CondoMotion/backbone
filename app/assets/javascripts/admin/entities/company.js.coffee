@Cmo.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  
  class Entities.Company extends Entities.Model
  
  class Entities.CompaniesCollection extends Entities.Collection
    model: Entities.Company

  API = 
    setCurrentCompany: (currentCompany) ->
      new Entities.Company currentCompany

  App.reqres.setHandler "set:current:company", (currentCompany) ->
    API.setCurrentCompany currentCompany