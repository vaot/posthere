app = angular.module 'posthere'

app.config [
  '$stateProvider'
  '$locationProvider'
  ($stateProvider, $locationProvider) ->

    $locationProvider.html5Mode(true)

    $stateProvider
      .state 'home',
        url: '/'
        views:
          'content@':
            templateUrl: '/templates/home/index.html'
            controller: 'HomeController'

      .state 'notes',
        url: '/notes'
        views:
          'content@':
            templateUrl: '/templates/notes/index.html'
            controller: 'NotesController'

      .state 'users',
        abstract: true
        template: '<div ui-view></div>'

      .state 'users.signup',
        url: '/signup'
        views:
          'content@':
            templateUrl: '/templates/users/signup.html'
            controller: 'UserController'

      .state 'users.login',
        url: '/login'
        views:
          'content@':
            templateUrl: '/templates/users/login.html'
            controller: 'UserController'

      .state 'users.logout',
        url: '/logout'
        views:
          'content@':
            templateUrl: '/templates/home/index.html'
            controller: [
              'UserService'
              (UserService) ->
                UserService.logout()
            ]
]
