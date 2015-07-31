module.exports = (app, Users, passport) ->
  app.post '/api/v1/users/', (request, response) ->
    Users.create({
      email: request.body.email,
      password: request.body.password,
      firstName: request.body.firstName,
      lastName: request.body.lastName,
      username: request.body.username
    })
      .then (user) ->
        if user
          response.json(user)
          response.statusCode = 201
        else
          response.send({ error: "Could not create user" })
          response.statusCode = 500

      .catch (error) ->
        throw error
        response.statusCode = 500


  app.post '/api/v1/users/login', passport.authenticate('local'), (req, res) ->
    res.json({ loggedIn: true })

  app.get '/api/v1/users/logout', (req, res) ->
    req.session.destroy (error) ->
      if error
        # TO DO: Display error ?
        res.json({ loggedOut: false })
      else
        res.json({ loggedOut: true })

  app.get '/api/v1/users/me', (req, res) ->
    if req.isAuthenticated()
      res.json({
        id: req.user.id
        username: req.user.username
        firstName: req.user.firstName
        lastName: req.user.lastName
      })
    else
      res.statusCode = 401
      res.send({ error: "Unauthorized" })
