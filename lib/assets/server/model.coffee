Sequelize = require 'sequelize'
sequelize = require '../sequelize'

module.exports = do ->
  {{titleCase}} = sequelize.define '{{name}}',
  {{#attributes}}
    {{name}}: Sequelize.{{type}}
  {{/attributes}}

  {{titleCase}}
