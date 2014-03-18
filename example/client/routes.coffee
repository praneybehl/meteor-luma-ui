# Define the base application layout, this can be modified per route using the `layoutTemplate` property
Session.setDefault 'routes_initialized', false

Router.configure
  autoStart: false
  notFoundTemplate: "error404"
  loadingTemplate: "loading"
  waitOn: -> Meteor.subscribe 'all_pages'

Meteor.subscribe 'all_pages', ->
  unless Session.get 'routes_initialized'
    Router.map ->
      self = @
      Pages.find().forEach (page) ->
        self.route page.route, page
    console.log Router
    Session.set 'routes_intialized', true
    Router.start()