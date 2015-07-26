module.exports  = (sequelize, DataTypes) ->

  Note =
    sequelize.define 'Note', {
      order:   DataTypes.INTEGER
      title:   DataTypes.STRING
      content: DataTypes.STRING
      author:  DataTypes.STRING
    }, {
      timestamps: true
    }

  Note
