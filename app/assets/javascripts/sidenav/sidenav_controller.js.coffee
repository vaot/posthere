app = angular.module 'posthere'

app.controller 'SidenavController', [
  '$scope'
  ($scope) ->

    $scope.createNote = ->
      note = new NoteResource
      debugger

]
