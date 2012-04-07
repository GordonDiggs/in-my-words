class app.collections.Configurations extends Backbone.Collection
  model: app.models.Configuration
  localStorage: new Backbone.LocalStorage("Configurations")
