Promise = require 'bluebird'
_ = require 'underscore'
{{titleCase}} = require '../models/{{name}}'

module.exports = do ->

  find = (req, res) ->
    {{titleCase}}.findAll where: req.query
      .then ({{name}}s) ->
        res.status 200
        res.send {{name}}s

  get = (req, res) ->
    {{titleCase}}.findById req.params.id
      .then ({{name}}s) ->
        res.status 200
        res.send {{name}}s

  create = (req, res) ->
    {{titleCase}}.create req.body
      .then ({{name}}) ->
        res.status 200
        res.send {{name}}

  update = (req, res) ->
    {{titleCase}}.findById req.params.id
      .then ({{name}}) ->
        if not {{name}}?
          res.status 400
          res.send '{{name}} not found'
        else
          {{name}}.destroy()
            .then ({{name}}) ->
              res.status 200
              res.send {{name}}

  destroy = (req, res) ->
    {{titleCase}}.findById req.params.id
      .then ({{name}}) ->
        if not {{name}}?
          res.status 400
          res.send '{{name}} not found'
        else
          {{name}}.destroy()
            .then ({{name}}) ->
              res.status 200
              res.send {{name}}


  find: find
  get: get
  create: create
  update: update
  destroy: destroy
