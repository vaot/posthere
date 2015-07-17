app = angular.module 'posthere'

app.service 'UsersResource', [
  '$resource'
  ($resource) ->
    $resource('api/v1/users/:id', id: '@id',
      show:
        url: 'api/v1/users/:id'
        method: 'GET'
      create:
        url: 'api/v1/users/'
        method: 'POST'
      update:
        url: 'api/v1/users/:id'
        method: 'PUT'
      authenticate:
        url: 'api/v1/users/login'
        method: 'POST'
    )

]
