module.exports = (app, Note) ->
  # Index
  app.get '/api/v1/notes/', (request, response) ->
    Note.find (error, notes) ->
      if error
        response.send(error)
      else
        response.json(notes: notes)

  # Create
  app.post '/api/v1/notes/', (request, response) ->
    note = new Note(request.body)
    # note.state = 'show'

    note.save (error, note) ->
      if error
        console.log('[note:create:error]', error)
        response.send(error)
        response.statusCode = 500
      else
        console.log('[note:create]', note)
        response.json(note)
        response.statusCode = 201

  # Update
  app.put '/api/v1/notes/:id', (request, response) ->
    Note.findByIdAndUpdate request.params.id, $set: request.body, (error, note) ->
      if error
        console.log('[note:update:error]', error)
        response.send(error)
        response.statusCode = 500
      else
        console.log('[note:update]', note)
        response.json(note)

  # Show
  app.get '/api/v1/notes/:id', (request, response) ->
    Note.findById request.params.id, (error, note) ->
      if error
        console.log('[note:show:error]', error)
        response.send(error)
        response.statusCode = 500
      else
        console.log('[note:show]', note)
        response.json(note)

  # Delete
  app.delete '/api/v1/notes/:id', (request, response) ->
    console.log('[delete]', request.params)

    Note.findByIdAndRemove request.params.id, (error) ->
      if error
        console.log('[note:delete:error]', error)
        response.send(error)
        response.statusCode = 500
      else
        console.log('[note:delete]')
        response.send({})
