app = angular.module 'posthere'


app.controller 'UsersController', [
  '$scope'
  'UsersResource'
  ($scope, UsersResource) ->

    $scope.signUp = ->
      UsersResource.create($scope.user).$promise.then ->
        console.log "oiiiii"

    $scope.logIn = ->
      console.log "oiii"
      UsersResource.authenticate($scope.user).$promise.then (data)->
        console.log data
]
