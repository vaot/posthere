app = angular.module 'posthere'

app.service 'NotesResource', [
  '$resource'
  (
    $resource
  ) ->

    $resource('api/v1/notes/:id', id: '@id',
      index:
        method: 'GET'
      show:
        method: 'GET'
      create:
        method: 'POST'
      update:
        method: 'PUT'
      delete:
        method: 'DELETE'
    )
]
