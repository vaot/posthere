app = angular.module 'posthere'

app.controller 'NotesController', [
  '$scope'
  '$element'
  '$q'
  '$timeout'
  '$rootScope'
  'NotesResource'
  'UserService'
  (
    $scope
    $element
    $q
    $timeout
    $rootScope
    NotesResource
    UserService
  ) ->

    $scope.notes = []

    shapeshiftOptions = ->
      gutterX: 16
      gutterY: 16
      paddingX: 16
      paddingY: 16
      colWidth: 200
      dragClone: false
      enableResize: true
      align: 'left'
      selector: '.card'

    enableShapeshift = ->
      return unless $scope.notes.length > 0
      $timeout ->
        $element.find('.shapeshift').shapeshift(shapeshiftOptions())

    createNote = (note) ->
      cancelActiveNotes()
      note =
        state: 'new'
        author: UserService.currentUser('username')
        created: new Date
      $scope.notes.unshift(note)

    # TODO
    cancelActiveNotes = ->
      for note in $scope.notes when note.state isnt 'show'
        switch note.state
          when 'new' then $scope.removeNote(note)
          when 'edit' then $scope.cancelNote(note)

    initializeNotes = ->
      NotesResource.index().$promise.then (data) ->
        note.state   = 'show' for note in data.notes
        $scope.notes = data.notes

    ###
    ###

    # TODO: Toast message errors
    $scope.saveNote = (note) ->
      NotesResource.save(note).$promise.then ->
        note.state = 'show'

    # TODO: Toast message errors
    $scope.updateNote = (note) ->
      NotesResource.update(id: note.id, note).$promise.then ->
        note.state = 'show'

    $scope.editNote = (note) ->
      cancelActiveNotes()
      note.original = angular.copy(note)
      note.state = 'edit'

    $scope.cancelNote = (note) ->
      index = $scope.notes.indexOf(note)
      $scope.notes[index] = angular.copy(note.original)

    $scope.removeNote = (note) ->
      $scope.notes = (_note for _note in $scope.notes when _note isnt note)

    # TODO: Toast message errors
    $scope.deleteNote = (note) ->
      NotesResource.delete(id: note.id).$promise.then ->
        $scope.removeNote(note)

    $scope.templateForState = (note) ->
      "/templates/notes/note_#{note.state}.html"

    $scope.humanizeDate = (date) ->
      moment(date).format('dddd, MMMM Do')

    $scope.$watch('notes', enableShapeshift, true)

    $rootScope.$on('note:new', createNote)

    initializeNotes()

]
