express        = require 'express'
assets         = require 'connect-assets'
partials       = require 'express-partials'
session        = require 'express-session'
mongoose       = require 'mongoose'
cookieParser   = require 'cookie-parser'
bodyParser     = require 'body-parser'
sassMiddleware = require 'node-sass-middleware'
path           = require 'path'

###
Initialization
###

# Create app instance
app = express()

# Define Port & Environment
app.port = process.env.PORT or process.env.VMC_APP_PORT or 3000
env = process.env.NODE_ENV or 'development'

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

# Set the public folder as static assets
app.use express.static(path.join(__dirname, 'assets/images'))
app.use express.static(path.join(__dirname, 'assets/stylesheets'))
app.use express.static(path.join(__dirname, 'assets/javascripts'))

app.use sassMiddleware(
  src:  'src/assets/stylesheets'
  dest: 'app/assets/stylesheets'
  debug: true
)

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

# Routes
require('./routes/api/v1/notes')(app)

app.all '/*', (request, response) ->
  response.render('index', layout: false)

# Export application
module.exports = app
