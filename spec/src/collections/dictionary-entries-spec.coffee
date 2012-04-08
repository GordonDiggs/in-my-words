describe "app.collections.DictionaryEntries", ->
  Given -> @subject = new app.collections.DictionaryEntries

  describe "#removeEmpties", ->
    context "no items", ->
      When -> @subject.removeEmpties()
      Then -> @subject.size() == 0

    context "1 non-empty item", ->
      Given -> @subject.add({original: "foo"})
      When -> @subject.removeEmpties()
      Then -> @subject.size() == 1

    context "1 empty item", ->
      Given -> @subject.add({})
      When -> @subject.removeEmpties()
      Then -> @subject.size() == 0

    context "1 empty, 1 non-empty item", ->
      Given -> @subject.add([{original: "foo"},{}])
      When -> @subject.removeEmpties()
      Then -> @subject.size() == 1

  describe "#ensureAnAvailableEntry", ->
    context "empty collection", ->
      When -> @subject.ensureAnAvailableEntry()
      Then -> @subject.size() == 1

    context "one full item", ->
      Given -> @subject.add({original: "a", replacement: "b"})
      When -> @subject.ensureAnAvailableEntry()
      Then -> @subject.size() == 2

    context "one half-full item", ->
      Given -> @subject.add({original: "a"})
      When -> @subject.ensureAnAvailableEntry()
      Then -> @subject.size() == 2

    context "one empty item", ->
      Given -> @subject.add({})
      When -> @subject.ensureAnAvailableEntry()
      Then -> @subject.size() == 1


