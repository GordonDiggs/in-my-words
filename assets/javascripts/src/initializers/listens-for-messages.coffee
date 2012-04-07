class app.initializers.ListensForMessages
  listen: ->
    $(document).ready ->
      if $('body').hasClass('js-background-page')
        chrome.extension.onRequest.addListener (request, sender, sendResponse) ->
          response = switch request.type
            when "config" then new app.configuration.FetchesConfig().fetch().toJSON()
          sendResponse(response)