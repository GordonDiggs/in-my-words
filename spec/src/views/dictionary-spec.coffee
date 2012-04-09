describe "app.views.Dictionary", ->
  Given -> @collection = new Backbone.Collection
  Given -> @collection.ensureAnAvailableEntry = jasmine.createSpy()


  Given -> @model = new Backbone.Model(entries: @collection)
  Given -> @subject = new app.views.Dictionary model: @model

  Then -> @subject.template == "templates/dictionary"
  Then -> expect(@collection.ensureAnAvailableEntry).toHaveBeenCalled()


  Then -> expect(@subject.events).toEqual
    "change :input": "ensureAvailableEntry"

  describe "#ensureAvailableEntry", ->
    Given -> @collection.ensureAnAvailableEntry.reset()

    describe "invoking directly", ->
      When -> @subject.ensureAvailableEntry()
      Then -> expect(@collection.ensureAnAvailableEntry).toHaveBeenCalled()

    describe "adding an item", ->
      Given -> @item = @collection.add({}).last()
      When -> @collection.remove(@item)
      Then -> expect(@collection.ensureAnAvailableEntry).toHaveBeenCalled()

  describe "creating child views", ->
    Given -> @item = new Backbone.Model
    Given -> @$itemContainer = @subject.$el.affix('.js-entries')
    Given -> @itemView = fakeClass(app.views, "DictionaryEntry", "render")
    Given -> @itemView.render.andReturn(el: $("<div class=\"entry\"/>")[0])

    describe "~ 'rendered' triggered", ->
      Given -> @model.get('entries').add(@item, silent: true)
      When -> @subject.trigger('rendered')
      Then -> expect(@itemView.constructor).toHaveBeenCalledWith(model: @item)
      Then -> expect(@$itemContainer).toHas('.entry')

    describe "~item is added", ->
      Given -> @model.get('entries').add(@item)
      Then -> expect(@itemView.constructor).toHaveBeenCalledWith(model: @item)
      Then -> expect(@$itemContainer).toHas('.entry')

