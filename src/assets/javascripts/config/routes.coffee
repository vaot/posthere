app = angular.module 'posthere'

app.config [
  '$stateProvider'
  ($stateProvider) ->
    console.log $stateProvider
]
