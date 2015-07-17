// Generated by CoffeeScript 1.7.1
module.exports = function(app, Note) {
  app.get('/api/v1/notes/', function(request, response) {
    return Note.find(function(error, notes) {
      if (error) {
        return response.send(error);
      } else {
        return response.json({
          notes: notes
        });
      }
    });
  });
  app.post('/api/v1/notes/', function(request, response) {
    var note;
    note = new Note(request.body);
    return note.save(function(error, note) {
      if (error) {
        console.log('[note:create:error]', error);
        response.send(error);
        return response.statusCode = 500;
      } else {
        console.log('[note:create]', note);
        response.json(note);
        return response.statusCode = 201;
      }
    });
  });
  app.put('/api/v1/notes/:id', function(request, response) {
    return Note.findByIdAndUpdate(request.params.id, {
      $set: request.body
    }, function(error, note) {
      if (error) {
        console.log('[note:update:error]', error);
        response.send(error);
        return response.statusCode = 500;
      } else {
        console.log('[note:update]', note);
        return response.json(note);
      }
    });
  });
  app.get('/api/v1/notes/:id', function(request, response) {
    return Note.findById(request.params.id, function(error, note) {
      if (error) {
        console.log('[note:show:error]', error);
        response.send(error);
        return response.statusCode = 500;
      } else {
        console.log('[note:show]', note);
        return response.json(note);
      }
    });
  });
  return app["delete"]('/api/v1/notes/:id', function(request, response) {
    console.log('[delete]', request.params);
    return Note.findByIdAndRemove(request.params.id, function(error) {
      if (error) {
        console.log('[note:delete:error]', error);
        response.send(error);
        return response.statusCode = 500;
      } else {
        console.log('[note:delete]');
        return response.send({});
      }
    });
  });
};
