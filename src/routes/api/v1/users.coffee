module.exports = (app, Users) ->
  app.post '/api/v1/users/', (request, response) ->
    Users.create({
      email: request.body.email,
      password: request.body.password,
      firstName: request.body.firstName,
      lastName: request.body.lastName,
      username: request.body.username
    }, (err, user) ->
      if err
        if err.code is 11000
          response.json(
            errors:
              unique: "Username and email must be unique"
          )
        throw err

      response.json(user)
    )
