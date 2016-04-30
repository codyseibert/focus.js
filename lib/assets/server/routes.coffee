app = require './app'

{{#models}}
{{.}}Controller = require('./controllers/{{.}}Controller')
{{/models}}

module.exports = do ->

  {{#models}}
  app.get '/{{.}}s', {{.}}Controller.find
  app.get '/{{.}}s/:id', {{.}}Controller.get
  app.post '/{{.}}s', {{.}}Controller.create
  app.put '/{{.}}s/:id', {{.}}Controller.update
  app.delete '/{{.}}s/:id', {{.}}Controller.destroy
  {{/models}}
