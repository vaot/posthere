express        = require 'express'
assets         = require 'connect-assets'
partials       = require 'express-partials'
session        = require 'express-session'
mongoose       = require 'mongoose'
cookieParser   = require 'cookie-parser'
bodyParser     = require 'body-parser'
path           = require 'path'
Mincer         = require 'mincer'
passportLocal  = require 'passport-local-mongoose'

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
  mongoose.connect('mongodb://localhost/example')

# Add Connect Assets
app.use assets()

environment = new Mincer.Environment()
environment.appendPath 'app/assets/javascripts'
environment.appendPath 'app/assets/stylesheets'

app.use('/assets', Mincer.createServer(environment))

# Express Session
console.log('setting session/cookie')

app.use cookieParser()
app.use session(
  secret: '2345876yt89gubvowtuye8obgsv7uo8fi'
  key: 'sid'
  cookie:
    secure: true
)

# Set View Engine
app.set 'view engine', 'jade'
app.use partials()

# Body parser middleware - parses JSON or XML bodies into req.body object
app.use bodyParser()


# Models
Notes = require('./models/note')(mongoose)
Users = require('./models/user')(mongoose, passportLocal)

# Routes
require('./routes/api/v1/notes')(app, Notes)

app.all '/*', (request, response) ->
  response.render('index', layout: false)

# Export application
module.exports = app
