app = angular.module 'posthere'

app.service 'UserService', [
  '$state'
  'UserResource'
  (
    $state
    UserResource
  ) ->

    currentUser = {}

    service = {}

    service.currentUser = (property) ->
      if property?
        currentUser[property]
      else
        currentUser

    # TODO: Toast message errors
    service.signup = (user) ->
      UserResource.create(user).$promise.then(@login) # TODO

    # TODO: Toast message errors
    service.login = (user) ->
      UserResource.login(user).$promise.then (data)->
        debugger
        currentUser = data.user
        $state.go('notes')

    service.logout = ->
      currentUser = {}
      $state.go('home')

    service
]
