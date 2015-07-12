app = angular.module 'posthere'

app.controller 'ToolbarController', [
  '$scope'
  '$mdSidenav'
  ($scope, $mdSidenav) ->
    $scope.toggleSidenav = (id) ->
      $mdSidenav(id).toggle()

]
