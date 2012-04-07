class app.views.DictionaryEntry extends app.helpers.SuperView
  template: "templates/dictionary-entry"
  events:
    "click .js-remove": "handleRemove"
    "change :input": "handleChange"

  handleRemove: ->
    @model.collection.remove(@model)
    @remove()

  handleChange: (e) ->
    $input = $(e.target)
    @model.set($input.attr('name'), $input.val())
