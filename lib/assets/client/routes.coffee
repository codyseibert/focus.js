module.exports = (
  $stateProvider,
  $urlRouterProvider
) ->
  $urlRouterProvider.otherwise '/'

  $stateProvider
    {{#states}}
    {{#state}}
    .state '{{.}}',
    {{/state}}
    {{^state}}
    .state '{{name}}',
    {{/state}}
      url: '{{{url}}}'
      {{#abstract}}
      abstract: true
      {{/abstract}}
      views:
        {{#view}}
        '{{.}}':
        {{/view}}
        {{^view}}
        'main':
        {{/view}}
          controller: '{{name}}Controller'
          templateUrl: '{{name}}/{{name}}.html'
    {{/states}}

  return this
