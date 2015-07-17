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

    createNote = ->
      addNote(
        state: 'edit'
        created: new Date()
      )

    addNote = (note) ->
      $scope.notes.unshift(note)

    initializeShapeshift = ->
      return unless $scope.notes.length > 0
      $timeout -> $element.find('.shapeshift').shapeshift(shapeshiftOptions())

    $rootScope.$on 'note:new', (event) ->
      createNote()
      initializeShapeshift()

    NotesResource.index().$promise.then (data) ->
      note.state ?= 'show' for note in data.notes
      $scope.notes = data.notes
      initializeShapeshift()

    $scope.saveNote = (note) ->
      NotesResource.save(note).$promise.then ->
        note.state = 'show'

    $scope.deleteNote = (note) ->
      NotesResource.delete(id: note._id).$promise.then ->
        $scope.notes = (_note for _note in $scope.notes when _note isnt note)
        initializeShapeshift()

    $scope.humanizeDate = (date) ->
      moment(date).format('dddd, MMMM Do YYYY, h:mm:ss a')

    $scope.templateForState = (note) ->
      "/templates/notes/note_#{note.state}.html"

]
