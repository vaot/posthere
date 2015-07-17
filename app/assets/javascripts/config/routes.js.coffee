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
        template: '<div ui-view></div>'

      .state 'users.signup',
        url: '/signup'
        views:
          '':
            templateUrl: '/templates/users/new.html'
            controller: 'UsersController'
          'toolbar@':
            templateUrl: '/templates/toolbar/index.html'
            controller: 'ToolbarController'
          'sidenav@':
            templateUrl: '/templates/sidenav/index.html'
            controller: 'SidenavController'

      .state 'users.login',
        url: '/login'
        views:
          '':
            templateUrl: '/templates/users/login.html'
            controller: 'UsersController'
          'toolbar@':
            templateUrl: '/templates/toolbar/index.html'
            controller: 'ToolbarController'
          'sidenav@':
            templateUrl: '/templates/sidenav/index.html'
            controller: 'SidenavController'

      .state 'users.edit',
        url: '/edit/:id'
        templateUrl: '/templates/users/edit.html'
        controller: 'UsersController'
]
