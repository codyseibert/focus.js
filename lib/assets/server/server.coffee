require './routes'
{{#models}}
require './models/{{.}}'
{{/models}}
require('./sequelize').sync().then ->
  require('./app').listen 8081
