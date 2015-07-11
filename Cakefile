fs            = require 'fs'
wrench        = require 'wrench'
{print}       = require 'util'
which         = require 'which'
{spawn, exec} = require 'child_process'

# Colors
bold  = '\x1B[0;1m'
red   = '\x1B[0;31m'
green = '\x1B[0;32m'
reset = '\x1B[0m'

pkg = JSON.parse fs.readFileSync('./package.json')
testCmd = pkg.scripts.test
startCmd = pkg.scripts.start

log = (message, color, explanation) ->
  console.log("#{color} #{message} #{reset} #{explanation}")

task 'watch', 'start dev environment', ->
  # Compiles src directory to the app directory
  options = ['-c', '-b', '-w', '-o', 'app', 'src']
  coffee  = spawn 'coffee', options

  # coffee.stdout.pipe process.stdout
  # coffee.stderr.pipe process.stderr

  log 'Watching coffee files', green

  # Watch JS
  supervisor = spawn 'node', [
    './node_modules/supervisor/lib/cli-wrapper.js',
    '-w',
    'app, views',
    '-e',
    'js|jade',
    'server'
  ]

  supervisor.stdout.pipe process.stdout
  supervisor.stderr.pipe process.stderr

  log 'Watching js files and running server', green
