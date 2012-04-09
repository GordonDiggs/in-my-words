class app.collections.DictionaryEntries extends Backbone.Collection
  removeEmpties: ->
    @remove(@empties())

  ensureAnAvailableEntry: ->
    @add({}) if _(@empties()).isEmpty()

  #private

  empties: ->
    @filter (entry) ->
      _(entry.get('original')).isEmpty() && _(entry.get('replacement')).isEmpty()