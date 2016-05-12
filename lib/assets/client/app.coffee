angular = require 'angular'
require 'angular-scroll'
require 'angular-filter'
require 'angular-local-storage'
require 'angular-animate'
require 'ng-lodash'
require 'angular-toggle-switch'
require '../../node_modules/angular-ui-bootstrap/dist/ui-bootstrap-tpls'
require '../../node_modules/angular-ui-grid/ui-grid'
require 'angular-scroll'

app = require('angular').module('{{name}}', [
  require 'angular-ui-router'
  require 'angular-resource'
  require 'angular-sanitize'
  require 'angular-moment'
  require 'ng-file-upload'
  'ngAnimate'
  'duScroll'
  'angular.filter'
  'LocalStorageModule'
  'ngLodash'
  'ui.grid'
  'ui.grid.selection'
  'ui.bootstrap'
  'toggle-switch'
  'duScroll'
])
app.constant 'BASE_URL', "#{location.protocol}//#{location.host}/api"
app.value('duScrollDuration', 500)
app.value('duScrollOffset', 80)
app.config require './routes'
app.config [
  'localStorageServiceProvider'
  (
    localStorageServiceProvider
  ) ->

    localStorageServiceProvider
      .setPrefix '{{name}}'
]

{{#states}}
require './{{name}}'
{{/states}}

require './models'
require './services'
require './components'

app.run [
  '$rootScope'
  '$http'
  (
    $rootScope
    $http
  ) ->

]
