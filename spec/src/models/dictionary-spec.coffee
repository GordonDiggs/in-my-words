describe "app.models.Dictionary", ->
  Given -> @subject = new app.models.Dictionary()

  context "initially", ->
    Then -> @subject.get('entries').size() == 0

  describe "#removeEmptyEntries", ->
    Given -> spyOn(@subject.get('entries'), "removeEmpties")
    When -> @subject.removeEmptyEntries()
    Then -> expect(@subject.get('entries').removeEmpties).toHaveBeenCalled()
