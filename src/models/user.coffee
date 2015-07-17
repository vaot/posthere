bcrypt = require 'bcrypt'
SALT_WORK_FACTOR = 10

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
  )

  User.methods.comparePassword = (userTypedPassword, callback) ->

    bcrypt.compare userTypedPassword, @password, (err, isMatch) =>
      if err
        callback(err)

      callback(null, isMatch)

  User.pre 'save', (next) ->
    if !@isModified('password')
      return next

    bcrypt.genSalt SALT_WORK_FACTOR, (err, salt) =>
      if err
        return next(err)

      bcrypt.hash @password, salt, (err, hash) =>
        if err
          return next(err)

        @password = hash
        next()


  mongoose.model('User', User)
