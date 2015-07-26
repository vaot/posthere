'use strict'

fs        = require 'fs'
path      = require 'path'
Sequelize = require 'sequelize'
basename  = path.basename(module.filename)
env       = process.env.NODE_ENV || 'development'
config    = require("../config/config.json")[env]
sequelize = new Sequelize(config.database, config.username, config.password, config)
db        = {}

fs
  .readdirSync(__dirname)
  .filter((file) ->
    (file.indexOf('.') isnt 0) && (file isnt basename)
  )
  .forEach((file) ->
    return if (file.slice(-3) isnt '.js')
    model = sequelize['import'](path.join(__dirname, file))
    db[model.name] = model
  )

Object.keys(db).forEach((modelName) ->
  if ('associate' in db[modelName])
    db[modelName].associate(db)
)

db.sequelize = sequelize
db.Sequelize = Sequelize

module.exports = db
