mongoose = require 'mongoose'

User = new mongoose.Schema(
  firstName: String
  lastName:  String
  username:  String
  password:  String
)

User.plugin(require 'passport-local-mongoose')

module.exports = mongoose.model('User', User)
