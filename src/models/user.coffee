mongoose              = require 'mongoose'
passportLocalMongoose = require 'passport-local-mongoose'

User = new mongoose.Schema(
  first_name:  String
  last_name:  String
  username: String
  password: String
)

User.plugin(passportLocalMongoose)
module.exports = mongoose.model('User', User)
