app = angular.module 'posthere'


app.controller 'UsersController', [
  '$scope'
  '$state'
  'UsersResource'
  ($scope, $state, UsersResource) ->

    $scope.signup = ->
      return if $scope.user.$invalid
      UsersResource.create($scope.user).$promise.then ->
        $scope.login() # TODO

    $scope.login = ->
      return if $scope.user.$invalid
      UsersResource.authenticate($scope.user).$promise.then (data)->
        console.log data
        $state.go('notes')
]
