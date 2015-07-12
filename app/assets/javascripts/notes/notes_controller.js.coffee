app = angular.module 'posthere'

app.service 'NotesResource', [
  '$resource'
  ($resource) ->
    $resource('api/v1/notes/:id', id: '@id',
      index:
        isArray: true
        url: 'api/v1/notes/'
        method: 'GET'
      show:
        url: 'api/v1/notes/:id'
        method: 'GET'
      create:
        url: 'api/v1/notes/'
        method: 'POST'
      update:
        url: 'api/v1/notes/:id'
        method: 'PUT'
      delete:
        url: 'api/v1/notes/:id'
        method: 'DELETE'
    )
]

app.controller 'NotesController', [
  '$scope'
  'NotesResource'
  ($scope, NotesResource) ->
    (new NotesResource).$index().then (data) ->
      $scope.notes =
        for i in [0..10]
          title: 'Hello'
          author: 'L1h3r'
          content: 'blah blah blah blah'

]
