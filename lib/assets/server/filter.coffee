module.exports =
  create: (query) ->
    COMMAND_DELIMITOR = '~'
    SPLIT_DELIMITOR = ','
    DEFAULT_LIMIT = 100
    MAX_LIMIT = 2000

    where = {}

    if Object.keys(query).length > 0
      where.$and = {}

    limit = Math.min(MAX_LIMIT, query.limit or DEFAULT_LIMIT)
    delete query.limit

    for key, value of query
      if key.indexOf(COMMAND_DELIMITOR) isnt -1
        split = key.split COMMAND_DELIMITOR
        key = split[0]
        command = split[1]
        if command is 'in'
          values = value.split SPLIT_DELIMITOR
          where.$and[key] =
           '$in': values
      else
        where.$and[key] = value

    where: where
    limit: limit
