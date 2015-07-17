app = angular.module 'posthere'

app.config [
  '$locationProvider'
  ($locationProvider) ->
    $locationProvider.html5Mode(true)
]

app.config [
  '$stateProvider'
  ($stateProvider) ->

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
]
