class app.initializers.RendersConfiguration
  render: ->
    $(window.document).ready ->
      if $('body').hasClass('js-options-page')
        config = new app.configuration.FetchesConfig().fetch()
        view = new app.views.Configuration(model: config)
        $('.root').append(view.render().el)
