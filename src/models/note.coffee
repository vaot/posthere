module.exports  = (mongoose) ->

  Note = new mongoose.Schema(
    order:   Number
    title:   String
    content: String
    author:  String
    created:
      type: Date
      default: Date.now
  )

  mongoose.model('Note', Note)
