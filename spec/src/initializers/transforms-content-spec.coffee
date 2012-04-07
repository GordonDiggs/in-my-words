describe "app.initializers.TransformsContent", ->
  Given -> @subject = new app.initializers.TransformsContent

  describe "#transform", ->
    Given -> @sendRequest = jasmine.createSpy()
    Given -> fake(window, 'chrome', extension: { sendRequest: @sendRequest })
    When -> @subject.transform()

    Then -> expect(@sendRequest).toHaveBeenCalledWith({type: "config"}, jasmine.any(Function))

    describe "~ after response", ->
      Given -> spyOn($.fn, "ready")
      Given -> @config = dictionary: { entries: 'entries!' }
      When -> @sendRequest.mostRecentCall.args[1](@config)

      describe "~ on domready", ->
        Given -> @replacesWords = fakeClass(app.dom, 'ReplacesWords', 'replace')
        When -> $.fn.ready.mostRecentCall.args[0]()
        Then -> expect(@replacesWords.replace).toHaveBeenCalledWith(@config.dictionary.entries)



