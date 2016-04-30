module.exports = (
  $stateProvider,
  $urlRouterProvider
) ->
  $urlRouterProvider.otherwise '/'

  $stateProvider
    {{#states}}
    .state '{{name}}',
      url: '/{{name}}'
      views:
        'main':
          controller: '{{name}}Ctrl'
          templateUrl: '{{name}}/{{name}}.html'
    {{/states}}

  return this
