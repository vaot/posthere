mongoose = require 'mongoose'

Note = new mongoose.Schema(
  title:  String
  body:   String
  author: String
  owner:  String
)

module.exports = mongoose.model('Note', Note)
