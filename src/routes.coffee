module.exports = (app) ->

  # Notes
  createApiRoutes(app, 'notes')

  app.all '/*', (request, response) ->
    response.render 'index', layout: false

createApiRoutes = (app, resource, version = 1) ->
  required = require "./controllers/api/v#{version}/#{resource}"

  app.get("api/v#{version}/#{resource}", required.index)
  app.get("api/v#{version}/#{resource}/:id", required.show)
  app.post("api/v#{version}/#{resource}", required.create)
  app.put("api/v#{version}/#{resource}/:id", required.update)
  app.delete("api/v#{version}/#{resource}/:id", required.delete)
