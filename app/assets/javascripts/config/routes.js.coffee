app = angular.module 'posthere'

app.config [
  '$stateProvider'
  ($stateProvider) ->

    $stateProvider
      .state 'welcome',
        views:
          'toolbar@welcome':
            templateUrl: '/templates/toolbar/index.html'
            controller: 'ToolbarController'
          'sidenav@welcome':
            templateUrl: '/templates/sidenav/index.html'
            controller: 'SidenavController'

      .state 'notes',
        url: '/notes'
        abstract: true
        template: '<div ui-view></div>'

      .state 'notes.index',
        views:
          '':
            templateUrl: '/templates/notes/index.html'
            controller: 'NotesController'
          'toolbar@welcome':
            templateUrl: '/templates/toolbar/index.html'
            controller: 'ToolbarController'
          'sidenav@welcome':
            templateUrl: '/templates/sidenav/index.html'
            controller: 'SidenavController'
]
