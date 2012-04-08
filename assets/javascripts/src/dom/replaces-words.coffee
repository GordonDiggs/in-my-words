class app.dom.ReplacesWords
  replace: (entries) ->
    _(@textNodes()).each (el) =>
      currentText = el.textContent
      newText = _(entries).reduce(@replaceEntry, currentText)
      el.textContent = newText unless currentText == newText

  #private

  textNodes: ->
    $('*:not(script)').contents().filter(->
      @nodeType == 3 and not _(@textContent.trim()).isEmpty()
    ).toArray()

  replaceEntry: (string, entry) =>
    regex = ///
      (\W|^)
      (#{entry.original})
      (\W|$)
    ///g
    string.replace(regex, "$1#{entry.replacement}$3")
