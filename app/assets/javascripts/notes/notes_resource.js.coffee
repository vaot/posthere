app = angular.module 'posthere'

app.service 'NotesResource', [
  '$resource'
  ($resource) ->
    $resource('api/v1/notes/:id', id: '@id',
      index:
        method: 'GET'
        url: 'api/v1/notes/'
        isArray: true
      show:
        method: 'GET'
      create:
        method: 'POST'
        url: 'api/v1/notes/'
      update:
        method: 'PUT'
      delete:
        method: 'DELETE'
    )
]
