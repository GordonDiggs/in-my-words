describe "app.models.Configuration", ->
  Given -> @subject = new app.models.Configuration()

  context "initially", ->
    Then -> @subject.get('dictionary') instanceof app.models.Dictionary
