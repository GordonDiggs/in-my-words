describe "app.views.Dictionary", ->
  Given -> @model = new Backbone.Model(entries: new Backbone.Collection)
  Given -> @subject = new app.views.Dictionary model: @model

  Then -> @subject.template == "templates/dictionary"

  Then -> expect(@subject.events).toEqual
    "click .js-add": "handleAdd"

  describe "creating child views", ->
    Given -> @itemView = fakeClass(app.views, "DictionaryEntry", "render")
    Given -> @itemView.render.andReturn(el: $("<div class=\"entry\"/>")[0])

    describe "handling rendered", ->
      Given -> @item = new Backbone.Model
      Given -> @model.get('entries').add(@item)

      When -> @subject.trigger('rendered')
      Then -> expect(@itemView.constructor).toHaveBeenCalledWith(model: @item)
      Then -> expect(@subject.$el).toHas('.entry')

    describe "#handleAdd", ->
      Given -> @e = fakeEvent()
      When -> @subject.handleAdd(@e)
      Then -> expect(@e.preventDefault).toHaveBeenCalled()
      Then -> @model.get('entries').size() == 1
      Then -> expect(@itemView.constructor).toHaveBeenCalledWith(model: @model.get('entries').last())
      Then -> expect(@subject.$el).toHas('.entry')
