# fs            = require 'fs'
# {print}       = require 'sys'
# {spawn, exec} = require 'child_process'

# build = (watch, callback) ->
#   if typeof watch is 'function'
#     callback = watch
#     watch = false
#   options = ['-c', '-o', 'lib', 'src']
#   options.unshift '-w' if watch

#   coffee = spawn 'coffee', options
#   coffee.stdout.on 'data', (data) -> print data.toString()
#   coffee.stderr.on 'data', (data) -> print data.toString()
#   coffee.on 'exit', (status) -> callback?() if status is 0

# task 'build', 'Compile CoffeeScript source files', ->
#   build()

# task 'watch', 'Recompile CoffeeScript source files when modified', ->
#   build(true)

# task 'test', 'Run the test suite', ->
#   build ->
#     require.paths.unshift __dirname + '/lib'
#     {reporters} = require 'nodeunit'
#     process.chdir __dirname
#     reporters.default.run ['test']

fs            = require 'fs'
wrench        = require 'wrench'
{print}       = require 'util'
which         = require 'which'
{spawn, exec} = require 'child_process'

# ANSI Terminal Colors
bold  = '\x1B[0;1m'
red   = '\x1B[0;31m'
green = '\x1B[0;32m'
reset = '\x1B[0m'

pkg = JSON.parse fs.readFileSync('./package.json')
testCmd = pkg.scripts.test
startCmd = pkg.scripts.start

log = (message, color, explanation) ->
  console.log color + message + reset + ' ' + (explanation or '')

task 'run', 'start dev environment', ->
  # Compiles src directory to the app directory
  options = ['-c', '-b', '-w', '-o', 'app', 'src']
  cmd = which.sync 'coffee'
  coffee = spawn cmd, options
  coffee.stdout.pipe process.stdout
  coffee.stderr.pipe process.stderr
  log 'Watching coffee files', green

  # watch_js
  supervisor = spawn 'node', [
    './node_modules/supervisor/lib/cli-wrapper.js',
    '-w',
    'app, views',
    '-e',
    'server'
  ]
  supervisor.stdout.pipe process.stdout
  supervisor.stderr.pipe process.stderr
  log 'Watching js files and running server', green

