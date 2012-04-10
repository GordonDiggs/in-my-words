class app.initializers.TransformsContent
  transform: ->
    chrome.extension.sendRequest {type: "config"}, (config) ->
      replacesWords = new app.dom.ReplacesWords()

      $(document).on
        ready: ->
          replacesWords.replace(config.dictionary.entries)

        DOMNodeInserted: _.debounce( ->
            replacesWords.replace(config.dictionary.entries)
          , 300)