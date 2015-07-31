express       = require 'express'
assets        = require 'connect-assets'
partials      = require 'express-partials'
session       = require 'express-session'
cookieParser  = require 'cookie-parser'
bodyParser    = require 'body-parser'
path          = require 'path'
morgan        = require 'morgan'
Mincer        = require 'mincer'
LocalStrategy = require('passport-local').Strategy
passport      = require 'passport'
models        = require './models/index'
bcrypt        = require 'bcrypt'
RedisStore    = require('connect-redis')(session)
redis         = require 'redis'
redisClient   = redis.createClient()
userService   = require './services/user'

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

# Add Connect Assets
app.use assets()

environment = new Mincer.Environment()
environment.appendPath 'app/assets/javascripts'
environment.appendPath 'app/assets/stylesheets'
environment.appendPath 'app/assets/images'
app.use '/assets', Mincer.createServer(environment)

app.use cookieParser()
app.use bodyParser()

app.use session(
  store: new RedisStore({ client: redisClient })
  secret: '2345876yt89gubvowtuye8obgsv7uo8fi'
)

app.use passport.initialize()
app.use passport.session()

# Logging
app.use morgan('dev')

# Set View Engine
app.set 'view engine', 'jade'
app.use partials()

# Models
Notes = require('./models/note')(models.sequelize, models.Sequelize)
Users = require('./models/user')(models.sequelize, models.Sequelize, bcrypt)


passport.serializeUser (user, done) ->
  done(null, user.id)

passport.deserializeUser (id, done) ->
  Users.findById(id).then (user) ->
    done({error: "Could not find user #{id}"}) unless user
    done(null, user)

passport.use new LocalStrategy(
  (username, password, done) ->
    Users.findOne(where: { username: username })
      .then (user) ->

        return done(null, false, { message: 'Incorrect username'}) if !user

        user.comparePassword password, (err, isMatch) =>
          return done(err) if err
          return done(null, user) if isMatch
          done(null, false, { message: 'Incorrect password' })

      .catch (error) ->
        return done(err)
)

# Routes
require('./routes/api/v1/notes')(app, Notes, userService)
require('./routes/api/v1/users')(app, Users, passport)

app.all '/*', (request, response) ->
  response.render('layout', layout: false)

# Export application
module.exports = app
