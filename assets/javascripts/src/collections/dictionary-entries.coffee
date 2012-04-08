class app.collections.DictionaryEntries extends Backbone.Collection
  removeEmpties: ->
    @remove(@empties())

  ensureAnAvailableEntry: ->
    if _(@empties()).isEmpty()
      @add({})

  #private

  empties: ->
    @filter (entry) ->
      _(entry.get('original')).isEmpty() && _(entry.get('replacement')).isEmpty()