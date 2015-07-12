app = angular.module 'posthere'

app.run [
  '$templateCache'
  ($templateCache) ->
    angular.forEach JST,
      (template, template_name) ->
        this.put "/#{template_name}.html", template({})
      , $templateCache
]
