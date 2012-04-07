describe "app.models.Dictionary", ->
  Given -> @subject = new app.models.Dictionary()

  context "initially", ->
    Then -> @subject.get('entries').size() == 0
