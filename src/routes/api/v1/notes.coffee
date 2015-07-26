module.exports = (app, Note) ->
  # Index
  app.get '/api/v1/notes/', (request, response) ->
    Note.findAll().then (notes) ->
      notes = notes || []
      response.json(notes: notes)

  # Create
  app.post '/api/v1/notes/', (request, response) ->
    Note.create(request.body)
      .then (note) ->
        response.json(note)
        response.statusCode = 201
      .catch (error) ->
        response.send(error)
        response.statusCode = 500

  # Update
  app.put '/api/v1/notes/:id', (request, response) ->
    Note.findById(request.params.id)
      .then (note) ->
        if note
          note.updateAttributes(request.body)
            .then (note) ->
              response.json(note)
            .catch (error) ->
              response.send(error)
              response.statusCode = 500
        else
          response.statusCode = 500
          response.send({ error: "Resource not found" })

  app.get '/api/v1/notes/:id', (request, response) ->
    Note.findById(request.params.id)
      .then (note) ->
        if note
          response.json(note)
        else
          response.statusCode = 500
          response.send({ error: "Resource not found" })
      .catch (error) ->
        response.statusCode = 500
        response.send(error)

  # Delete
  app.delete '/api/v1/notes/:id', (request, response) ->
    Note.findById(request.params.id)
      .then (note) ->
        if note
          note.destroy()
            .then (note) ->
              response.json({})
            .catch (error) ->
              response.send(error)
              response.statusCode = 500
        else
          response.statusCode = 500
          response.send({ error: "Resource not found" })
