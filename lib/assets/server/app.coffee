express = require 'express'
bodyParser = require 'body-parser'
cors = require 'cors'
module.exports = do ->
  app = express()
  app.use bodyParser.json()
  app.use cors()
  app
