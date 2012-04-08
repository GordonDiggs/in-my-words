describe "app.dom.ReplacesWords", ->
  Given -> @subject = new app.dom.ReplacesWords

  describe "#replace", ->
    Given -> @$root = affix('.root')
    Given -> @entries = [{original: "foo", replacement: "bar"}]

    describe "basics", ->

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

    describe "technical stuffs", ->

      context "match in a script tag", ->
        Given -> @$script = @$root.affix('script').text("var foo")
        When -> @subject.replace(@entries)
        Then -> expect(@$script.text()).toContain("var foo")

      context "in a node with children & text elements", ->
        Given -> @$mixed = @$root.append('<div><div>lol</div> but also foo</div>')
        When -> @subject.replace(@entries)
        Then -> expect(@$mixed.text()).toContain("lol but also bar")


    describe "language", ->

      context "match is near punctuation", ->
        Given -> @$p = @$root.affix('p').text("I am a foo.")
        When -> @subject.replace(@entries)
        Then -> expect(@$p.text()).toContain("I am a bar.")

      context "match is with another word", ->
        Given -> @$p = @$root.affix('p').text("I'm no fufoo")
        When -> @subject.replace(@entries)
        Then -> expect(@$p.text()).toContain("I'm no fufoo")

      context "match is the entire word", ->
        Given -> @$p = @$root.affix('p').text("foo")
        When -> @subject.replace(@entries)
        Then -> expect(@$p.text()).toContain("bar")
