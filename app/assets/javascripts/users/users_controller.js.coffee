app = angular.module 'posthere'


app.controller 'UsersController', [
  '$scope'
  'UsersResource'
  ($scope, UsersResource) ->
    console.log "child"
    $scope.signUp = ->
      UsersResource.create($scope.user).$promise.then ->
        console.log "oiiiii"
]
