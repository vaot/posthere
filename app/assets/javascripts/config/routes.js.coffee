app = angular.module 'posthere'

app.config [
  '$stateProvider'
  ($stateProvider) ->

    $stateProvider
      .state 'welcome',
        url: ''
        templateUrl: '/templates/welcome/index.html'
]
