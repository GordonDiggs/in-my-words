class app.views.DictionaryEntry extends app.helpers.SuperView
  template: "templates/dictionary-entry"
  events:
    "click .js-remove": "handleRemove"
    "change :input": "handleChange"

  initialize: ->
    @model.bind('remove', => @remove())

  handleRemove: (e) ->
    e.preventDefault()
    @model.collection.remove(@model)

  handleChange: (e) ->
    $input = $(e.target)
    @model.set($input.attr('name'), $input.val())
