app = angular.module 'posthere'

app.controller 'HomeController', [
  '$scope'
  '$rootScope'
  'UserService'
  (
    $scope
    $rootScope
    UserService
  ) ->
    $scope.loggedIn = ->
      return true for own k, v of UserService.currentUser()
      false

    $scope.createNote = ->
      $rootScope.$broadcast('note:new')

]
