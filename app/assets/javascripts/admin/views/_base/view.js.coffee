@Cmo.module "Views", (Views, App, Backbone, Marionette, $, _) ->
	
  #Store off default remove implementation so it can be called in overriden method
	_remove = Marionette.View::remove
	
	_.extend Marionette.View::,
	
		addOpacityWrapper: (init = true) ->
			@$el.toggleWrapper
				className: "opacity"
			, init
	
		setInstancePropertiesFor: (args...) ->
			for key, val of _.pick(@options, args...)
				@[key] = val
	
    #Overrides default view remove method
		remove: (args...) ->
			console.log "removing", @

      # if the view has a model and is destroyed
			if @model?.isDestroyed?() && @opacity == "true"
				
				wrapper = @$el.toggleWrapper
					className: "opacity"
					backgroundColor: "#F2DEDE"
				
				wrapper.fadeOut 400, ->
					$(@).remove()
				
				@$el.fadeOut 400, =>
					_remove.apply @, args
			else
				_remove.apply @, args
	
		templateHelpers: ->

			currentUser:
				App.request("get:current:user").toJSON()

			currentCompany:
				App.request("get:current:company").toJSON()
			
			linkTo: (name, url, options = {}) ->
				_.defaults options,
					external: false
				
				url = "#" + url unless options.external
				
				"<a href='" + url + "'>" + escape(name) + "</a>"
