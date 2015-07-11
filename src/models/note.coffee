mongoose = require 'mongoose'

Note = new mongoose.Schema(
  title:   String
  content: String
  author:  String
  created:
    type: Date
    default: Date.now
)

module.exports = mongoose.model('Note', Note)
