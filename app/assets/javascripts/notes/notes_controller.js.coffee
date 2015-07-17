app = angular.module 'posthere'

app.controller 'NotesController', [
  '$scope'
  '$element'
  '$timeout'
  '$rootScope'
  'NotesResource'
  ($scope, $element, $timeout, $rootScope, NotesResource) ->
    sentences = [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
      'Ut ut vulputate neque. Vivamus eleifend laoreet magna sit amet interdum.'
      'Nullam in tellus aliquet, interdum diam ut, gravida libero.'
      'Curabitur accumsan mauris elementum libero pretium interdum.'
      'Quisque tempor et purus eu congue.'
      'Curabitur vehicula posuere ipsum a eleifend.'
      'Pellentesque pharetra egestas massa, non vehicula dui aliquam quis.'
      'Mauris sed ex vel turpis tristique fringilla sed ut arcu.'
      'Donec ac mauris sed justo posuere venenatis.'
      'Aenean a imperdiet dui.'
      'Phasellus scelerisque ligula vitae mattis ultrices.'
      'Curabitur accumsan nibh eu vestibulum euismod.'
    ]

    shapeshiftOptions = ->
      gutterX: 16
      gutterY: 16
      paddingX: 16
      paddingY: 16
      dragClone: false
      animateOnInit: true
      align: 'left'
      selector: 'md-card'

    createNote = (options = {}) ->
      count = Math.floor(Math.random() * sentences.length)
      base =
        created: Date.now()
        state: 'show'
        title: 'Hello'
        author: 'L1h3r'
        content: sentences[0..count].join(' ')
      angular.extend(base, options)

    initializeShapeshift = ->
      $timeout -> $element.find('.shapeshift').shapeshift(shapeshiftOptions())

    $rootScope.$on 'note:new', (event) ->
      $scope.notes.unshift(createNote(state: 'edit'))
      initializeShapeshift()

    $scope.notes = (createNote() for i in [0..2])

    initializeShapeshift()

    # (new NotesResource).$index().then (data) ->
    #   console.log('[notes] init', data)

    $scope.templateForState = (note) ->
      "/templates/notes/note_#{note.state}.html"

]
