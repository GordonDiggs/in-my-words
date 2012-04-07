class app.views.Dictionary extends app.helpers.SuperView
  template: "templates/dictionary"
  events:
    "click .js-add": "handleAdd"

  initialize: ->
    @bind('rendered', @renderItems)

  handleAdd: (e) ->
    e.preventDefault()
    @model.get('entries').add({})
    @renderItem(@model.get('entries').last())

  renderItems: ->
    @model.get('entries').each (item) =>
      @renderItem(item)

  renderItem: (item) ->
    entryView = new app.views.DictionaryEntry(model: item)
    @$el.append(entryView.render().el)
