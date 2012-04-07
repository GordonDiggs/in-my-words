describe "app.collections.Configurations", ->
  Given -> @subject = new app.collections.Configurations

  describe "synchronously adding & retrieving a config", ->
    Given -> @subject.add(foo: "bar")
    Given -> @subject.last().save()
    Given -> @other = new app.collections.Configurations()
    When -> @other.fetch()
    Then -> @other.last().get('foo') == 'bar'
    Then -> @other.last() instanceof app.models.Configuration
