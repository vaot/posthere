app = angular.module 'posthere'

app.controller 'NotesController', [
  '$scope'
  '$element'
  '$q'
  '$timeout'
  '$rootScope'
  'NotesResource'
  'UsersService'
  (
    $scope
    $element
    $q
    $timeout
    $rootScope
    NotesResource
    UsersService
  ) ->

    $scope.notes = []

    originalNotes = {}

    shapeshiftOptions = ->
      gutterX: 16
      gutterY: 16
      paddingX: 16
      paddingY: 16
      colWidth: 200
      dragClone: false
      enableResize: true
      align: 'left'
      selector: 'md-card'

    removeNote = (note) ->
      $scope.notes = (_note for _note in $scope.notes when _note isnt note)

    createNote = (note) ->
      $scope.notes.unshift(note)

    saveNote = (note, newNote) ->
      if newNote
        NotesResource.save(note).$promise
      else
        NotesResource.update(id: note.id, note).$promise

    cancelNote = (note, newNote) ->
      if newNote
        removeNote(note)
      else
        $scope.notes[$scope.notes.indexOf(note)] = originalNotes[note.id]
        delete originalNotes[note.id]

    initializeShapeshift = ->
      return unless $scope.notes.length > 0
      $timeout -> $element.find('.shapeshift').shapeshift(shapeshiftOptions())

    $scope.createNote = ->
      createNote(
        state: 'new'
        author: UsersService.currentUser('username')
        created: new Date()
      )
      initializeShapeshift()

    $scope.saveNote = (note, newNote = false) ->
      saveNote(note, newNote).then ->
        note.state = 'show'
        initializeShapeshift()

    $scope.cancelNote = (note, newNote = false) ->
      cancelNote(note, newNote)
      note.state = 'show' unless newNote
      initializeShapeshift()

    $scope.editNote = (note) ->
      originalNotes[note.id] = angular.copy(note)
      note.state = 'edit'
      initializeShapeshift()

    $scope.deleteNote = (note) ->
      NotesResource.delete(id: note.id).$promise.then ->
        removeNote(note)
        initializeShapeshift()

    $scope.humanizeDate = (date) ->
      moment(date).format('dddd, MMMM Do')

    $scope.templateForState = (note) ->
      "/templates/notes/note_#{note.state}.html"

    $rootScope.$on('note:new', $scope.createNote)

    NotesResource.index().$promise.then (data) ->
      note.state   = 'show' for note in data.notes
      $scope.notes = data.notes
      initializeShapeshift()

]
