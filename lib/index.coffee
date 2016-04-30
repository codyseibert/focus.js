
path = require 'path'
filewalker = require 'filewalker'
copy = require 'copy'
fs = require 'fs'
Mustache = require 'mustache'
mkdirp = require 'mkdirp'
_ = require 'lodash'

config = require path.resolve(process.cwd(), 'focus.json')

# TODO
# build
# 1. generate the app.coffee file into build          build/client/src/app.coffee
# 2. generate the default index.jade into build       build/client/src/index.jade
# 4. generate routes.coffee using states into         build/client/src/routes.coffee
# 6. generate all directives using components into    build/client/src/components
# 8. generate all services using models into          build/client/src/services
# 9. generate sequelize models into                   build/server/src/models
# 10. generate express controllers into               build/server/src/controllers
# 11. generate routes into                            build/server/src/routes.coffee
# 12. generate the express app into                   build/server/src/app.coffee
# 12. generate the sequelize hook into                build/server/src/sequelize.coffee
#
# # dist
# 14. compile all sass                                dist/client/app.css
# 14. compile all bower dependencie                   dist/client/bower.js
# 14. compile all coffee                              dist/client/app.js
# 14. compile all templates                           dist/client/templates.js
#
# # refresh
# 13. restart the express services                    dist/server/app.
# 14. refresh the browser

convertAsset = (src, dest, model) ->
  split = dest.split(path.sep)
  split.pop()
  folder = split.join path.sep
  mkdirp path.resolve(process.cwd(), folder), (err) ->
    if not err?
      file = fs.readFileSync path.resolve(__dirname, 'assets', src), 'utf8'
      output = Mustache.render file, model
      fs.writeFileSync path.resolve(process.cwd(), dest), output

module.exports.init = ->
  convertAsset 'client/gulpfile.coffee', 'build/client/gulpfile.coffee', config
  convertAsset 'client/gulpfile.js', 'build/client/gulpfile.js', config

module.exports.compile = ->
  convertAsset 'client/app.coffee', 'build/client/src/app.coffee', config
  convertAsset 'client/index.jade', 'build/client/src/index.jade', config

  new Promise (resolve, reject) ->
    states = {}
    filewalker 'src/states'
      .on('dir', (p) ->
      )
      .on('file', (p, s, n) ->
        split = n.split path.sep
        file = split[split.length - 1]
        state = split[split.length - 2]
        states[state] ?= {}
        states[state][file] = n
      )
      .on('done', ->
        console.log states
        resolve states
      )
      .walk()
  .then (states) ->
    model =
      states: []
    for key, state of states
      model.states.push
        name: key
    console.log model
    convertAsset 'client/routes.coffee', 'build/client/src/routes.coffee', model

  new Promise (resolve, reject) ->
    models = {}
    filewalker 'src/models'
      .on('dir', (p) ->
      )
      .on('file', (p, s, n) ->
        split = n.split path.sep
        file = split[split.length - 1]
        file = file.split '.'
        models[file[0]] = n
      )
      .on('done', ->
        resolve models
      )
      .walk()
  .then (models) ->
    for key, file of models
      convertAsset 'client/service.coffee', "build/client/src/services/#{key}Service.coffee", name: key

    convertAsset 'client/services.index.coffee', "build/client/src/services/index.coffee",
      name: config.name
      services: Object.keys models

  #
  # new Promise (resolve, reject) ->
  #   filewalker 'src/components'
  #     .on('dir', (p) ->
  #     )
  #     .on('file', (p, s, n) ->
  #       console.log n
  #     )
  #     .on('done', ->
  #       resolve()
  #     )
  #     .walk()
