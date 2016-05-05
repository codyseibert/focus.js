#!/usr/bin/env coffee
watch = require 'watch'
path = require 'path'

lib = require '../lib/index'

focus = ->
  lib.init()
  lib.compile()

watch.watchTree path.join(process.cwd(), 'focus'), ->
  console.log 'Let\s Focus!'
  focus()
