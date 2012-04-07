describe "app.initializers.RendersConfiguration", ->
  Given -> @subject = new app.initializers.RendersConfiguration

  describe "#render", ->
    Given -> spyOn($.fn, "ready")

    When -> @subject.render()
    Then -> expect($.fn.ready).toHaveBeenCalled()

    describe "~on domready", ->
      Given -> @$root = affix('.root')
      Given -> @fetchesConfig = fakeClass(app.configuration, "FetchesConfig", "fetch")
      Given -> @fetchesConfig.fetch.andReturn('CONFIG')
      Given -> @configView = fakeClass(app.views, "Configuration", "render")
      Given -> @configView.render.andReturn el: $('<div class="woot"></div>')[0]

      context "when body has an 'js-options-page' class", ->
        Given -> $('body').addClass('js-options-page')
        afterEach -> $('body').removeClass('js-options-page')

        When -> $.fn.ready.mostRecentCall.args[0]()
        Then -> expect(@configView.constructor).toHaveBeenCalledWith(model: 'CONFIG')
        Then -> expect(@$root).toHas('.woot')

      context "when body has no 'js-options-page' class", ->
        When -> $.fn.ready.mostRecentCall.args[0]()
        Then -> expect(@$root).not.toHas('.woot')
