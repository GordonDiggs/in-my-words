class app.dom.ReplacesWords
  replace: (entries) ->
    _(@textNodes()).each (el) =>
      currentText = el.textContent
      newText = _(entries).reduce(@replaceEntry, currentText)
      el.textContent = newText unless currentText == newText

  #private

  textNodes: ->
    $('*:not(script)').filter(@notIllegalIframe).contents().filter(@nonEmptyTextNode).toArray()

  replaceEntry: (string, entry) =>
    regex = ///
      (\W|^)
      (#{entry.original})
      (\W|$)
    ///g
    string.replace(regex, "$1#{entry.replacement}$3")

  notIllegalIframe: ->
    !($.nodeName(@, "iframe") && !@contentWindow)

  nonEmptyTextNode: ->
    @nodeType == 3 and not _(@textContent.trim()).isEmpty()