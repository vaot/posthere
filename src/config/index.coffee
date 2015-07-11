exports.setEnvironment = (env) ->
  console.log("setting app environment: #{env}")
  switch env
    when 'development'
      exports.DEBUG_LOG = true
      exports.DEBUG_WARN = true
      exports.DEBUG_ERROR = true
      exports.DEBUG_CLIENT = true
      exports.DB_HOST = 'localhost'
      exports.DB_PORT = '3306'
      exports.DB_NAME = 'posthere_development'
      exports.DB_USER = 'root'
      exports.DB_PASS = 'root'
    when 'testing'
      exports.DEBUG_LOG = true
      exports.DEBUG_WARN = true
      exports.DEBUG_ERROR = true
      exports.DEBUG_CLIENT = true
    when 'production'
      exports.DEBUG_LOG = false
      exports.DEBUG_WARN = false
      exports.DEBUG_ERROR = true
      exports.DEBUG_CLIENT = false
    else
      console.log("environment #{env} not found")
