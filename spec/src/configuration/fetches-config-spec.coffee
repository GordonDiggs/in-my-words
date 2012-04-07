describe "app.configuration.FetchesConfig", ->
  Given -> @configs = fakeClass(app.collections, "Configurations", ['fetch','at','add'])

  Given -> @subject = new app.configuration.FetchesConfig

  describe "#fetch", ->
    context "an item exists already", ->
      Given -> @configs.at.when(0).thenReturn "Yay"
      When -> @result = @subject.fetch()
      Then -> expect(@configs.fetch).toHaveBeenCalled()
      Then -> @result == "Yay"

    context "no item exists", ->
      Given -> @configs.add.when({}).thenCallFake =>
        @configs.at.when(0).thenReturn "woot"
      When -> @result = @subject.fetch()
      Then -> expect(@configs.add).toHaveBeenCalledWith({})
      Then -> @result == "woot"

describe "contracts with dependencies", ->
  describe "saving nested models with backbone-localstorage & backbone-relational", ->
    Given -> @config = new app.configuration.FetchesConfig().fetch()
    Given -> @config.get('dictionary').get('entries').add({foo: "bar"})
    When -> @config.save()
    Then -> new app.configuration.FetchesConfig().fetch().get('dictionary').get('entries').first().get('foo') == "bar"

