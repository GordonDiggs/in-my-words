describe "app.views.Configuration", ->
  Given -> @model = new Backbone.Model(dictionary: 'foo')
  Given -> @subject = new app.views.Configuration model: @model
  Then -> @subject.template == "templates/configuration"
  Then -> expect(@subject.events).toEqual
    "click .js-save": "save"
    "click .js-reset": "reset"

  describe "rendering the dictionary", ->
    Given -> @$fields = @subject.$el.affix('.js-fields')
    Given -> @dictionaryView = fakeClass(app.views,"Dictionary","render")
    Given -> @dictionaryView.render.andReturn el: $('<div class="dic"/>')
    When -> @subject.trigger('rendered')
    Then -> expect(@dictionaryView.constructor).toHaveBeenCalledWith(model: @model.get('dictionary'))
    Then -> expect(@$fields).toHas('.dic')

  describe "#save", ->
    Given -> @e = fakeEvent()
    Given -> spyOn(@model, "save")
    When -> @subject.save(@e)
    Then -> expect(@e.preventDefault).toHaveBeenCalled()
    Then -> expect(@model.save).toHaveBeenCalled()

  describe "#reset", ->
    Given -> spyOn(@model, "destroy")
    When -> @subject.reset()
    Then -> expect(@model.destroy).toHaveBeenCalled()
