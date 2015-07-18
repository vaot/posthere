app = angular.module 'posthere'

app.service 'UsersResource', [
  '$resource'
  ($resource) ->
    $resource('api/v1/users/:id', id: '@id',
      show:
        method: 'GET'
      create:
        url: 'api/v1/users/'
        method: 'POST'
      update:
        method: 'PUT'
      authenticate:
        url: 'api/v1/users/login'
        method: 'POST'
    )

]
