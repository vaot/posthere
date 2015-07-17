app = angular.module 'posthere'

app.config [
  '$locationProvider'
  ($locationProvider) ->
    $locationProvider.html5Mode(true)
]

app.config [
  '$stateProvider'
  '$locationProvider'
  ($stateProvider, $locationProvider) ->

    $locationProvider.html5Mode(true)

    $stateProvider
      .state 'home',
        url: '/'
        views:
          '':
            templateUrl: '/templates/home/index.html'
            controller: 'HomeController'
          'toolbar':
            templateUrl: '/templates/toolbar/index.html'
            controller: 'ToolbarController'
          'sidenav':
            templateUrl: '/templates/sidenav/index.html'
            controller: 'SidenavController'

      .state 'notes',
        url: '/notes'
        views:
          '':
            templateUrl: '/templates/notes/index.html'
            controller: 'NotesController'
          'toolbar':
            templateUrl: '/templates/toolbar/index.html'
            controller: 'ToolbarController'
          'sidenav':
            templateUrl: '/templates/sidenav/index.html'
            controller: 'SidenavController'

      .state 'users',
        url: '/users'
        abstract: true
        controller: ->
          console.log "parent"
        template: '<div ui-view></div>'

      .state 'users.new',
        url: '/new'
        templateUrl: '/templates/users/new.html'
        controller: 'UsersController'

      .state 'users.edit',
        url: '/new'
        templateUrl: '/templates/users/new.html'
        controller: 'UsersController'
]
