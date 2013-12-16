@Cmo = do (Backbone, Marionette) ->
  App = new Marionette.Application

  App.on "initialize:before", (options) ->
    @currentUser = App.request "set:current:user", options.currentUser
    @currentCompany = App.request "set:current:company", options.currentCompany

  App.addRegions
    menuRegion:   "#menu-region"
    mainRegion:   "#main-region"
    paneRegion:   "#pane-region"

  App.addInitializer ->
    App.module("MenuApp").start()

  App.rootRoute = "/properties"

  App.reqres.setHandler "default:region", ->
    App.mainRegion

  App.reqres.setHandler "get:current:user", ->
    App.currentUser

  App.reqres.setHandler "get:current:company", ->
    App.currentCompany

  App.on "initialize:after", (options) ->
    @startHistory()
    @navigate(@rootRoute, trigger: true) unless @getCurrentRoute()

  App

$ ->
  if $('body').hasClass("index") #This is a temporary solution...need to organize JS so backbone stuff is only included on the relevant page
    Cmo.start
      currentUser: gon.current_user
      currentCompany: gon.current_company