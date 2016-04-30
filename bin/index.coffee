#!/usr/bin/env coffee
watch = require 'watch'
path = require 'path'

lib = require '../lib/index'

if process.argv[2] is 'init'
  lib.init()
else
  watch.watchTree path.join(process.cwd(), 'src'), ->
    console.log 'something changed'
    lib.compile()
