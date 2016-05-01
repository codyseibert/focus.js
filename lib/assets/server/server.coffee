require './routes'
{{#models}}
require './models/{{.}}'
{{/models}}
require('./sequelize').sync({force: true}).then ->
  require('./app').listen 8081
