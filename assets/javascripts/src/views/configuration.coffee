class app.views.Configuration extends app.helpers.SuperView
  template: "templates/configuration"
  events:
    "click .js-save": "save"
    "click .js-reset": "reset"

  initialize: ->
    @bind('rendered', @renderDictionary)

  renderDictionary: ->
    @$('.fields').append(new app.views.Dictionary(model: @model.get('dictionary')).render().el)

  save: (e) ->
    e.preventDefault()
    @model.save()

  reset: ->
    @model.destroy()
