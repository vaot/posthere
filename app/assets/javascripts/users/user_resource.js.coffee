app = angular.module 'posthere'

app.service 'UserResource', [
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
      login:
        url: 'api/v1/users/login'
        method: 'POST'
      logout:
        url: 'api/v1/users/logout'
        method: 'GET'
      current:
        url: 'api/v1/users/me'
        method: 'GET'
    )

]
