module.exports = (app, Note) ->
  # Index
  app.get '/api/v1/notes/', (request, response) ->
    Note.find (error, notes) ->
      if error
        response.send(error)
      else
        response.json(notes)

  # Create
  app.post '/api/v1/notes/', (request, response) ->
    note = new Note(request.body)

    note.save (error, note) ->
      if error
        response.send(error)
        response.statusCode = 500
      else
        response.json(note)
        response.statusCode = 201

  # Update
  app.put '/api/v1/notes/:id', (request, response) ->
    Note.findByIdAndUpdate request.params.id, $set: request.body, (error, note) ->
      if error
        response.send(error)
        response.statusCode = 500
      else
        response.json(note)

  # Show
  app.get '/api/v1/notes/:id', (request, response) ->
    Note.findById request.params.id, (error, note) ->
      if error
        response.send(error)
        response.statusCode = 500
      else
        response.json(note)

  # Delete
  app.delete '/api/v1/notes/:id', (request, response) ->
    Note.findByIdAndRemove request.params.id, (error) ->
      if error
        response.send(error)
        response.statusCode = 500
      else
        response.send({})
