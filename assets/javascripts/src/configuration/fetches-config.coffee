class app.configuration.FetchesConfig
  fetch: ->
    configs = new app.collections.Configurations
    configs.fetch()
    if config = configs.at(0)
      config
    else
      configs.add({})
      configs.at(0)