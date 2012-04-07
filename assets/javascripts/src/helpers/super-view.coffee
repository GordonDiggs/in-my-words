class app.helpers.SuperView extends Backbone.View
  render: ->
    @$el.html(JST[@template](@serialize?()))
    @trigger('rendered')

  serialize: -> model: @model?.toJSON()
