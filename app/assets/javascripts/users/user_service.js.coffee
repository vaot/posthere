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
        if data.loggedIn
          UserResource.current().$promise.then (userProfile) ->
            currentUser = userProfile
            $state.go('notes')
        else
          # TO DO: Notification

    service.logout = ->
      UserResource.logout().$promise.then (data) ->
        currentUser = {}
        $state.go('home')

    service
]
