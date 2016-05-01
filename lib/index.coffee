
path = require 'path'
filewalker = require 'filewalker'
copy = require 'copy'
fs = require 'fs'
Mustache = require 'mustache'
mkdirp = require 'mkdirp'
_ = require 'lodash'

toTitleCase = (str) ->
  return str.replace(/\w\S*/g, (txt) ->
    return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
  )

config = require path.resolve(process.cwd(), 'focus.json')

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
  convertAsset 'client/package.json', 'build/client/package.json', config

  convertAsset 'box.json', 'build/box.json', config
  convertAsset 'Vagrantfile', 'build/Vagrantfile', config
  convertAsset 'puppet.sh', 'build/puppet.sh', config
  convertAsset 'provision.sh', 'build/provision.sh', config
  convertAsset 'Vagrantfile', 'build/Vagrantfile', config
  convertAsset 'Puppetfile', 'build/Puppetfile', config
  convertAsset 'manifests/init.pp', 'build/manifests/init.pp', config
  convertAsset 'manifests/role/prod.pp', 'build/manifests/role/prod.pp', config
  convertAsset 'manifests/profile/db.pp', 'build/manifests/profile/db.pp', config
  convertAsset 'manifests/profile/httpd.pp', 'build/manifests/profile/httpd.pp', config

  convertAsset 'server/package.json', 'build/server/package.json', config
  convertAsset 'server/app.coffee', 'build/server/src/app.coffee', config
  convertAsset 'server/sequelize.coffee', 'build/server/src/sequelize.coffee', config

module.exports.compile = ->
  convertAsset 'client/app.coffee', 'build/client/src/app.coffee', config
  convertAsset 'client/index.jade', 'build/client/src/index.jade', config

  new Promise (resolve, reject) ->
    states = {}
    filewalker 'focus/states'
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
        resolve states
      )
      .walk()
  .then (states) ->
    model =
      states: []
    for key, state of states
      index = require(state['index.coffee'])
      obj =
        module: config.name
        name: key
        url: index.url or "/#{key}"
        controller:
          name: key
      model.states.push obj
      convertAsset 'client/controller.coffee', "build/client/src/#{key}/#{key}Controller.coffee", obj
      convertAsset 'client/controller.index.coffee', "build/client/src/#{key}/index.coffee", obj

      convertAsset "client/layouts/#{index.layout}.jade", "build/client/src/#{key}/#{key}.jade", index.components

    convertAsset 'client/routes.coffee', 'build/client/src/routes.coffee', model

  new Promise (resolve, reject) ->
    models = {}
    filewalker 'focus/models'
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
      convertAsset 'server/controller.coffee', "build/server/src/controllers/#{key}Controller.coffee",
        name: key
        titleCase: toTitleCase key

      m = require file
      attributes = []
      for name, value of m.attributes
        attributes.push
          name: name
          type: value.type
      convertAsset 'server/model.coffee', "build/server/src/models/#{key}.coffee",
        name: key
        titleCase: toTitleCase key
        attributes: attributes

    convertAsset 'server/routes.coffee', "build/server/src/routes.coffee",
      models: Object.keys models

    convertAsset 'client/services.index.coffee', "build/client/src/services/index.coffee",
      name: config.name
      services: Object.keys models

    convertAsset 'server/server.coffee', "build/server/src/server.coffee",
      models: Object.keys models



  new Promise (resolve, reject) ->
    components = {}
    filewalker 'focus/components'
      .on('dir', (p) ->
      )
      .on('file', (p, s, n) ->
        split = n.split path.sep
        file = split[split.length - 1]
        component = split[split.length - 2]
        components[component] ?= {}
        components[component][file] = n
      )
      .on('done', ->
        resolve components
      )
      .walk()
  .then (components) ->
    convertAsset 'client/components.index.coffee', "build/client/src/components/index.coffee",
      name: config.name
      components: Object.keys components

    convertAsset 'client/app.sass', 'build/client/src/app.sass', components: Object.keys components

    for key, component of components
      for name, file of component
        mkdirp "build/client/src/components/#{key}"
        fs.createReadStream file
          .pipe fs.createWriteStream "build/client/src/components/#{key}/#{name}"
