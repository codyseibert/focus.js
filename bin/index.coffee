#!/usr/bin/env coffee
lib = require '../lib/index'

if process.argv[2] is 'init'
  lib.init()
else
  lib.compile()
