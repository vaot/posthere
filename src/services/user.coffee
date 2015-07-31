Service = {}

Service.ensureAuthenticated = (req, res, next) ->
  if req.isAuthenticated()
    next()
  else
    res.statusCode = 401
    res.send({ error: "Unauthorized" })


module.exports = Service
