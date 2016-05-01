app = require('angular').module '{{name}}'

{{#components}}
app.directive '{{.}}', require './{{.}}'
{{/components}}
