app = angular.module 'posthere'

app.service 'UsersService', [
  ->
    service = {}

    service.currentUser = (property) ->
      user =
        email:     ''
        firstName: ''
        lastName:  ''
        username:  ''

      if property? then user[property] else user

    service
]
