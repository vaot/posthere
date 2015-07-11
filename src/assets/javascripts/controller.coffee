app = angular.module 'posthere'

app.controller 'AppController', [
  '$scope'
  '$mdSidenav'
  ($scope, $mdSidenav) ->
    $scope.toggleSidenav = (id) ->
      $mdSidenav(id).toggle()

]
