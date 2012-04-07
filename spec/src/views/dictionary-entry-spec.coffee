describe "app.views.DictionaryEntry", ->
  Given -> @model = new Backbone.Model(a: 'b')
  Given -> @subject = new app.views.DictionaryEntry model: @model

  Then -> @subject.template == "templates/dictionary-entry"
  Then -> expect(@subject.events).toEqual
    "click .js-remove": "handleRemove"
    "change :input": "handleChange"

  describe "#handleRemove", ->
    Given -> @collection = new Backbone.Collection(@model)
    Given -> @remove = spyOn(@subject, "remove")
    When -> @subject.handleRemove()
    Then -> @collection.size() == 0
    Then -> expect(@remove).toHaveBeenCalled()

  describe "#handleChange", ->
    Given -> @$input = affix('input[name="foo"][value="bar"]')
    When -> @subject.handleChange(target: @$input[0])
    Then -> @model.get("foo") == "bar"
