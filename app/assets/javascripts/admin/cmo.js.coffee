@Cmo = do (Backbone, Marionette) ->
  App = new Marionette.Application

  App.addRegions
    menuRegion:   "#menu-region"
    mainRegion:   "#main-region"
    paneRegion:   "#pane-region"

  App.addInitializer ->
    App.module("MenuApp").start()

  App.rootRoute = "/properties"

  App.reqres.setHandler "default:region", ->
    App.mainRegion

  App.on "initialize:after", ->
    @startHistory()
    @navigate(@rootRoute, trigger: true) unless @getCurrentRoute()

  App

$ ->
  if $('body').hasClass("index") #This is a temporary solution...need to organize JS so backbone stuff is only included on the relevant page
    Cmo.start()