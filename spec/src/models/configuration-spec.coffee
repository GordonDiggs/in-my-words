describe "app.models.Configuration", ->
  Given -> @subject = new app.models.Configuration()

  context "initially", ->
    Then -> @subject.get('dictionary') instanceof app.models.Dictionary

  describe "#save", ->
    Given -> spyOn(@subject.get('dictionary'), 'removeEmptyEntries')
    Given -> spyOn(app.models.Configuration.__super__, "save")
    When -> @subject.save()
    Then -> expect(@subject.get('dictionary').removeEmptyEntries).toHaveBeenCalled()
    Then -> expect(app.models.Configuration.__super__.save).toHaveBeenCalled()
