Note = require '../models/note'

module.exports =
  index: (req, res) ->
    Note.find {}, (err, notes) ->
      res.send notes

  create: (req, res) ->
    note = new Note req.body
    note.save (err, note) ->
      if not err
        res.send note
        res.statusCode = 201
      else
        res.send err
        res.statusCode = 500

  get: (req, res) ->
    Note.findById req.params.id, (err, note) ->
      if not err
        res.send note
      else
        res.send err
        res.statusCode = 500

  update: (req, res) ->
    Note.findByIdAndUpdate req.params.id, $set: req.body, (err, note) ->
      if not err
        res.send note
      else
        res.send err
        res.statusCode = 500

  delete: (req, res) ->
    Note.findByIdAndRemove req.params.id, (err) ->
      if not err
        res.send {}
      else
        res.send err
        res.statusCode = 500
