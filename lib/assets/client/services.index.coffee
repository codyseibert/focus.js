app = require('angular').module '{{name}}'

{{#services}}
app.service '{{.}}Service', require './{{.}}Service'
{{/services}}
