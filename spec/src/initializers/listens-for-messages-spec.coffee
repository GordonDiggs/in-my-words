describe "app.initializers.ListensForMessages", ->
  Given -> @subject = new app.initializers.ListensForMessages

  describe "#listen", ->
    Given -> spyOn($.fn, "ready")
    When -> @subject.listen()

    describe "~on domready", ->
      Given -> @listener = jasmine.createSpy()
      Given -> fake(window, "chrome", extension: { onRequest: { addListener: @listener }})

      context "on the background page", ->
        Given -> $('body').addClass('js-background-page')
        afterEach -> $('body').removeClass('js-background-page')
        When -> $.fn.ready.mostRecentCall.args[0]()

        describe "~ when handling a request", ->
          Given -> @sendResponse = jasmine.createSpy()

          describe "~ handling a config request", ->
            Given -> @fetchesConfig = fakeClass(app.configuration, 'FetchesConfig', 'fetch')
            Given -> @fetchesConfig.fetch.andReturn toJSON: -> "woot"
            When -> @listener.mostRecentCall.args[0]({type: "config"}, null, @sendResponse)
            Then -> expect(@sendResponse).toHaveBeenCalledWith("woot")

      context "not on the background page", ->
        When -> $.fn.ready.mostRecentCall.args[0]()
        Then -> expect(@listener).not.toHaveBeenCalled()