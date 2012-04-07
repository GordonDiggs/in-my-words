class app.dom.ReplacesWords
  replace: (entries) ->
    $("*").each (el, i) ->
      if $(this).children().length == 0
        replaceAsNeeded = (word) ->
          match = _(entries).find (entry) -> entry.original == word
          if match then match.replacement else word

        $(this).text _($(this).text()).chain().words().reduce((memo, word) ->
          "#{memo} #{replaceAsNeeded(word)}"
        , "").value()
