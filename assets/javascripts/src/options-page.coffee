window.app ||= {}

class app.Options extends Backbone.Model
  defaults:
    dictionary:
      "the": "THE"
      "it": "IT!"
      "Apple": "IBM PC/360"
      "Google": "Silicon Graphics"
      "Android": "iPhone"
      "iOS": "Android"
      "iPhone": "Ultra Thin Galaxy Envy Tingle"
  
class app.OptionsCollection extends Backbone.Collection
  model: app.Options
  localStorage: new Backbone.LocalStorage("Options")
  
  initialize: ->
    @fetch()
  
  instance: ->
    @at(0) || @add({}).at(0)
  
$inputs = ->
  $(':input:not(:button)')
  
save = (options) ->
  $inputs().each (i, el) ->
    val = $(el).val()
    val = JSON.parse(val) if $(el).hasClass('json')
    options.set($(el).attr('name'), val)
  options.save()
  
restore = (options) ->
  $inputs().each (i, el) ->
    val = options.get($(el).attr('name'))
    val = JSON.stringify(val) if $(el).hasClass('json')
    $(el).val(val)
    
$ ->
  if $('body').hasClass('options-page') 
    options = new app.OptionsCollection().instance()
    $('.js-save-button').on
      click: -> save(options)
      
    $('.js-reset-button').on
      click: -> options.destroy()
      
    restore(options)