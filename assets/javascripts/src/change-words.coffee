$ ->
  _.mixin(_.str.exports())
  
  WORDS = new app.OptionsCollection().instance().get('dictionary')
  
  replaceIfBannz0rred = (word) ->
    if WORDS[word]? then WORDS[word] else word
  
  _(WORDS).each (replacement, original) ->
    $("*").each (el, i) ->
      if $(this).children().length == 0
        woot = _($(this).text()).chain().words().reduce((memo, word) -> 
          "#{memo} #{replaceIfBannz0rred(word)}"
        ,"").value()
        $(this).text(woot)
