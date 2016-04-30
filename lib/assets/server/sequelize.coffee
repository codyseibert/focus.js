Sequelize = require 'sequelize'
module.exports = do ->
  new Sequelize '{{database.name}}', '{{database.username}}', '{{database.password}}',
    host: '{{database.host}}'
