express      = require 'express'
assets       = require 'connect-assets'
partials     = require 'express-partials'
session      = require 'express-session'
mongoose     = require 'mongoose'
cookieParser = require 'cookie-parser'
bodyParser   = require 'body-parser'
hamlc        = require 'haml-coffee'

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

# db_config = "mongodb://#{config.DB_USER}:#{config.DB_PASS}@#{config.DB_HOST}:#{config.DB_PORT}/#{config.DB_NAME}"
# mongoose.connect db_config
if env isnt 'production'
  mongoose.connect 'mongodb://localhost/example'
else
  console.log('If you are running in production, you may want to modify the mongoose connect path')



###
View initialization
###

# Add Connect Assets
app.use assets()

# Set the public folder as static assets
app.use express.static(process.cwd() + '/public')

# Express Session
console.log('setting session/cookie')
app.use cookieParser()
app.use session(
  secret: 'keyboard cat'
  key: 'sid'
  cookie:
    secure: true
)

# Set View Engine
app.set 'view engine', 'hamlc'
app.use partials()

# Body parser middleware - parses JSON or XML bodies into req.body object
app.use bodyParser()



###
Finalization
###

# Initialize routes
routes = require './routes'
routes(app)

# Export application
module.exports = app
