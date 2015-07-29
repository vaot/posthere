app = angular.module 'posthere'

app.controller 'UserController', [
  '$scope'
  'UserService'
  (
    $scope
    UserService
  ) ->

    $scope.signup = ->
      return if $scope.user.$invalid # TODO: Toast message errors
      UserService.signup($scope.user)

    $scope.login = ->
      return if $scope.user.$invalid # TODO: Toast message errors
      UserService.login($scope.user)

]
