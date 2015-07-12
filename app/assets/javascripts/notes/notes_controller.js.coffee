app = angular.module 'posthere'

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
