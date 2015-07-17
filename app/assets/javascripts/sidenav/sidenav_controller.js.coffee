app = angular.module 'posthere'

app.controller 'SidenavController', [
  '$scope'
  '$rootScope'
  ($scope, $rootScope) ->

    $scope.createNote = ->
      $rootScope.$broadcast('note:new')

]
