module.exports = (mongoose, passportLocal) ->

  User = new mongoose.Schema(
    firstName: String
    lastName:  String
    username:  String
    password:  String
  )

  User.plugin(passportLocal)

  mongoose.model('User', User)
