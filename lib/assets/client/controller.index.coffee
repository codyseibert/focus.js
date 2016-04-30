app = require('angular').module '{{module}}'

{{#controller}}
app.controller '{{name}}Controller', require './{{name}}Controller'
{{/controller}}
