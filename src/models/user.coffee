Hash = require('password-hash')

module.exports = (mongoose, passportLocal) ->

  User = new mongoose.Schema(
    email:
      unique: true
      required: 'Email is required'
      type: String
    firstName: String
    lastName:  String
    username:
      unique: true
      type: String
      required: 'Username is required'
    password:
      type: String
      set: (newValue) ->
        if Hash.isHashed(newValue) then newValue else Hash.generate(newValue)
  )

  # User.plugin(passportLocal)

  mongoose.model('User', User)
