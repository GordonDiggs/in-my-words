class app.initializers.TransformsContent
  transform: ->
    chrome.extension.sendRequest {type: "config"}, (config) ->
      $(document).ready ->
        new app.dom.ReplacesWords().replace(config.dictionary.entries)
