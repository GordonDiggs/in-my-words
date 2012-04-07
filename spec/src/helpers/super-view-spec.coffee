describe "app.helpers.SuperView", ->
  class SomeView extends app.helpers.SuperView
    template: "templates/some"

  Given -> @subject = new SomeView

  describe "#serialize", ->
    context "model", ->
      Given -> @model = new Backbone.Model(a: 'b')
      Given -> @subject.model = @model
      When -> @result = @subject.serialize()
      Then -> expect(@result).toEqual(model: @model.toJSON())

    context "no model", ->
      When -> @result = @subject.serialize()
      Then -> expect(@result).toEqual(model: undefined)

  describe "#render", ->
    Given -> fake(JST, "templates/some", @template = jasmine.createSpy())
    Given -> @subject.bind('rendered', @event = jasmine.createSpy())
    Given -> @template.when(@subject.serialize()).thenReturn("<div class=\"HTML\"></div>")
    When -> @subject.render()
    Then -> expect(@subject.$el).toHas('.HTML')
    Then -> expect(@event).toHaveBeenCalled()
