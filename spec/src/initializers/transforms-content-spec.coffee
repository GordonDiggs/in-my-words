describe "app.initializers.TransformsContent", ->
  Given -> @subject = new app.initializers.TransformsContent

  describe "#transform", ->
    Given -> @sendRequest = jasmine.createSpy()
    Given -> fake(window, 'chrome', extension: { sendRequest: @sendRequest })
    When -> @subject.transform()

    Then -> expect(@sendRequest).toHaveBeenCalledWith({type: "config"}, jasmine.any(Function))

    describe "~ after response", ->
      Given -> @replacesWords = fakeClass(app.dom, 'ReplacesWords', 'replace')
      Given -> spyOn(_, "debounce").andCallFake (f) -> f()

      Given -> @config = dictionary: { entries: 'entries!' }
      When -> @sendRequest.mostRecentCall.args[1](@config)

      describe "~ on domready", ->
        When -> $(document).trigger('ready')
        Then -> expect(@replacesWords.replace).toHaveBeenCalledWith(@config.dictionary.entries)

      describe "~ DOMNodeInserted", ->
        When -> $(document).trigger('DOMNodeInserted')
        Then -> expect(@replacesWords.replace).toHaveBeenCalledWith(@config.dictionary.entries)
        Then -> expect(_.debounce).toHaveBeenCalledWith(jasmine.any(Function), 300)



