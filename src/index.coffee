express       = require 'express'
assets        = require 'connect-assets'
partials      = require 'express-partials'
session       = require 'express-session'
mongoose      = require 'mongoose'
cookieParser  = require 'cookie-parser'
bodyParser    = require 'body-parser'
path          = require 'path'
morgan        = require 'morgan'
Mincer        = require 'mincer'
passportLocal = require 'passport-local-mongoose'
LocalStrategy = require('passport-local').Strategy
passport      = require 'passport'

###
Initialization
###

# Create app instance
app = express()

# Define Port & Environment
app.port = process.env.PORT || process.env.VMC_APP_PORT || 3000
env = process.env.NODE_ENV || 'development'

# Config module exports has `setEnvironment` function that sets app settings depending on environment
config = require './config'
config.setEnvironment(env)

dbConfig = '' # "mongodb://#{config.DB_USER}:#{config.DB_PASS}@#{config.DB_HOST}:#{config.DB_PORT}/#{config.DB_NAME}"
if env is 'production'
  mongoose.connect(dbConfig)
else
  mongoose.connect('mongodb://localhost/posthere')

# Add Connect Assets
app.use assets()

environment = new Mincer.Environment()
environment.appendPath 'app/assets/javascripts'
environment.appendPath 'app/assets/stylesheets'
app.use('/assets', Mincer.createServer(environment))

app.use cookieParser()
# Body parser middleware - parses JSON or XML bodies into req.body object
app.use bodyParser()
app.use session(
  secret: '2345876yt89gubvowtuye8obgsv7uo8fi'
  key: 'sid'
  cookie:
    secure: true
)
app.use passport.initialize()
app.use passport.session()

# Logging
app.use morgan('dev')

# Set View Engine
app.set 'view engine', 'jade'
app.use partials()

passport.serializeUser (user, done) ->
  done(null, user.id)

passport.deserializeUser (id, done) ->
  Users.findById id, (err,user) ->
      done(err) if err
      done(null, user)

# Models
Notes = require('./models/note')(mongoose)
Users = require('./models/user')(mongoose, passportLocal)

passport.use new LocalStrategy(
  (username, password, done) ->
    Users.findOne username: username, (err, user) ->
      return done(err) if err
      return done(null, false, { message: 'Incorrect username'}) if !user

      user.comparePassword password, (err, isMatch) =>
        return done(err) if err
        return done(null, user) if isMatch
        done(null, false, { message: 'Incorrect password' })
)

# Routes
require('./routes/api/v1/notes')(app, Notes)
require('./routes/api/v1/users')(app, Users, passport)

app.all '/*', (request, response) ->
  response.render('layout', layout: false)

# Export application
module.exports = app
