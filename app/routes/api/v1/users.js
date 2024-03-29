// Generated by CoffeeScript 1.7.1
module.exports = function(app, Users, passport) {
  app.post('/api/v1/users/', function(request, response) {
    return Users.create({
      email: request.body.email,
      password: request.body.password,
      firstName: request.body.firstName,
      lastName: request.body.lastName,
      username: request.body.username
    }).then(function(user) {
      if (user) {
        response.json(user);
        return response.statusCode = 201;
      } else {
        response.send({
          error: "Could not create user"
        });
        return response.statusCode = 500;
      }
    })["catch"](function(error) {
      throw error;
      return response.statusCode = 500;
    });
  });
  app.post('/api/v1/users/login', passport.authenticate('local'), function(req, res) {
    return res.json({
      loggedIn: true
    });
  });
  app.get('/api/v1/users/logout', function(req, res) {
    return req.session.destroy(function(error) {
      if (error) {
        return res.json({
          loggedOut: false
        });
      } else {
        return res.json({
          loggedOut: true
        });
      }
    });
  });
  return app.get('/api/v1/users/me', function(req, res) {
    if (req.isAuthenticated()) {
      return res.json({
        id: req.user.id,
        username: req.user.username,
        firstName: req.user.firstName,
        lastName: req.user.lastName
      });
    } else {
      res.statusCode = 401;
      return res.send({
        error: "Unauthorized"
      });
    }
  });
};
