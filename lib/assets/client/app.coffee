angular = require 'angular'
require 'angular-scroll'
require 'angular-filter'
require 'angular-local-storage'
require 'angular-animate'
require 'ng-lodash'
require '../../node_modules/angular-ui-bootstrap/dist/ui-bootstrap-tpls'
require 'angular-scroll'

app = require('angular').module('{{name}}', [
  require 'angular-ui-router'
  require 'angular-resource'
  require 'angular-sanitize'
  require 'angular-moment'
  'ngAnimate'
  'duScroll'
  'angular.filter'
  'LocalStorageModule'
  'ngLodash'
  'ui.bootstrap'
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

require './main'
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
