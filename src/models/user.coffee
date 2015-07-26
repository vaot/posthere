SALT_WORK_FACTOR = 10

module.exports  = (sequelize, DataTypes, bcrypt) ->

  User =
    sequelize.define 'User', {
      email:
        type: DataTypes.STRING
        unique: true
        allowNull: false
      firstName:
        type: DataTypes.STRING
        allowNull: false
      lastName:
        type: DataTypes.STRING
        allowNull: false
      username:
        type: DataTypes.STRING
        unique: true
        allowNull: false
      password:
        type: DataTypes.STRING
        allowNull: false
    }, {
      timestamps: true
      instanceMethods:
        comparePassword: (userTypedPassword, callback) ->
          bcrypt.compare userTypedPassword, @password, (err, isMatch) =>

            if err
              callback(err)
            else
              callback(null, isMatch)
    }

  User.beforeCreate (user, options, done) ->
    bcrypt.genSalt SALT_WORK_FACTOR, (err, salt) ->

      return done(err) if err

      bcrypt.hash user.password, salt, (err, hash) ->
        if err
          return done(err)

        user.password = hash
        done()


  User
