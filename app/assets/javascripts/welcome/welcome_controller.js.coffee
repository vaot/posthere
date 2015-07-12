app = angular.module 'posthere'

app.controller 'WelcomeController', [
  '$scope'
  '$mdSidenav'
  ($scope, $mdSidenav) ->
    $scope.toggleSidenav = (id) ->
      $mdSidenav(id).toggle()

]
