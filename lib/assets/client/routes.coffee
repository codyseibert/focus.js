module.exports = (
  $stateProvider,
  $urlRouterProvider
) ->
  $urlRouterProvider.otherwise '/'

  $stateProvider
    {{#states}}
    .state '{{name}}',
      url: '{{{url}}}'
      views:
        'main':
          controller: '{{name}}Controller'
          templateUrl: '{{name}}/{{name}}.html'
    {{/states}}

  return this
