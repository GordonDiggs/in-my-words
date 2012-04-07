describe "app.dom.ReplacesWords", ->
  Given -> @subject = new app.dom.ReplacesWords

  describe "#replace", ->
    Given -> @$root = affix('.root')
    Given -> @entries = [{original: "foo", replacement: "bar"}]

    context "no matches", ->
      Given -> @$p = @$root.affix('p').text("I am not a match")
      When -> @subject.replace(@entries)
      Then -> expect(@$p.text()).toContain("I am not a match")

    context "1 match", ->
      Given -> @$p = @$root.affix('p').text("I am a foo")
      When -> @subject.replace(@entries)
      Then -> expect(@$p.text()).toContain("I am a bar")

    context "2 matches in one node", ->
      Given -> @$p = @$root.affix('p').text("Hey foo I am a foo")
      When -> @subject.replace(@entries)
      Then -> expect(@$p.text()).toContain("Hey bar I am a bar")

    context "1 match in each of two nodes", ->
      Given -> @$p1 = @$root.affix('p').text("I am a foo")
      Given -> @$p2 = @$root.affix('p').text("What a foo he is")
      When -> @subject.replace(@entries)
      Then -> expect(@$p1.text()).toContain("I am a bar")
      Then -> expect(@$p2.text()).toContain("What a bar he is")
