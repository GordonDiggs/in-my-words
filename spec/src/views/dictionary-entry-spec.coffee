describe "app.views.DictionaryEntry", ->
  Given -> @model = new Backbone.Model(a: 'b')
  Given -> @subject = new app.views.DictionaryEntry model: @model

  Then -> @subject.template == "templates/dictionary-entry"
  Then -> expect(@subject.events).toEqual
    "click .js-remove": "handleRemove"
    "change :input": "handleChange"

  describe "event handling", ->
    describe "removing the model from its collection", ->
      Given -> @remove = spyOn(@subject, "remove")
      Given -> @collection = new Backbone.Collection(@model)
      When -> @model.collection.remove(@model)
      Then -> expect(@remove).toHaveBeenCalled()


  describe "#handleRemove", ->
    Given -> @e = fakeEvent()
    Given -> @collection = new Backbone.Collection(@model)
    When -> @subject.handleRemove(@e)
    Then -> expect(@e.preventDefault).toHaveBeenCalled()
    Then -> @collection.size() == 0

  describe "#handleChange", ->
    Given -> @$input = affix('input[name="foo"][value="bar"]')
    When -> @subject.handleChange(target: @$input[0])
    Then -> @model.get("foo") == "bar"
