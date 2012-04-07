class app.models.Dictionary extends Backbone.RelationalModel
  relations: [
    {
      type: Backbone.HasMany
      key: 'entries'
      relatedModel: 'app.models.DictionaryEntry'
      collectionType: 'app.collections.DictionaryEntries'
    }
  ]
