notes = require './controllers/api/notes'

module.exports = (app) ->

  # Notes
  app.get('/notes', notes.index)
  app.get('/notes/:id', notes.show)
  app.post('/notes', notes.create)
  app.put('/notes/:id', notes.update)
  app.delete('/notes/:id', notes.delete)

  # If all else failed, show 404 page
  app.all '/*', (req, res) ->
    console.warn "error 404: ", req.url
    res.statusCode = 404
    res.render '404', 404
