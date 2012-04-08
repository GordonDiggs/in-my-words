class app.models.Configuration extends Backbone.RelationalModel
  relations: [
    {
      type: Backbone.HasOne
      key: 'dictionary'
      relatedModel: 'app.models.Dictionary'
    }
  ]

  defaults: ->
    dictionary: new app.models.Dictionary

  save: ->
    @get('dictionary').removeEmptyEntries()
    super