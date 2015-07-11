Note = require '../../../models/note'

module.exports =
  index: (request, response) ->
    Note.find {}, (error, notes) ->
      response.send(notes)

  show: (request, response) ->
    Note.findById request.params.id, (error, note) ->
      if not error
        response.send(note)
      else
        response.send(error)
        response.statusCode = 500

  create: (request, response) ->
    note = new Note request.body
    note.save (error, note) ->
      if not error
        response.send(note)
        response.statusCode = 201
      else
        response.send(error)
        response.statusCode = 500

  update: (request, response) ->
    Note.findByIdAndUpdate request.params.id, $set: request.body, (error, note) ->
      if not error
        response.send(note)
      else
        response.send(error)
        response.statusCode = 500

  delete: (request, response) ->
    Note.findByIdAndRemove request.params.id, (error) ->
      if not error
        response.send({})
      else
        response.send(error)
        response.statusCode = 500
