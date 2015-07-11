mongoose = require 'mongoose'

Tag = new mongoose.Schema(
  title:  String
  notes:  Array
)

module.exports = mongoose.model('Tag', Tag)
