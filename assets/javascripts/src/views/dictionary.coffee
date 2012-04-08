class app.views.Dictionary extends app.helpers.SuperView
  template: "templates/dictionary"
  events:
    "change :input": "ensureAvailableEntry"

  initialize: ->
    @bind('rendered', @renderItems)
    @model.get('entries').bind('add', @renderItem)
    @ensureAvailableEntry()

  ensureAvailableEntry: ->
    @model.get('entries').ensureAnAvailableEntry()

  renderItems: ->
    @model.get('entries').each (item) =>
      @renderItem(item)

  renderItem: (item) =>
    entryView = new app.views.DictionaryEntry(model: item)
    @$('.js-entries').append(entryView.render().el)
