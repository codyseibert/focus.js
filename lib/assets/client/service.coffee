module.exports = [
  '$http'
  '$q'
  'BASE_URL'
  (
    $http
    $q
    BASE_URL
  ) ->

    @find = (searchParams) ->
      $q (resolve, reject) ->
        $http.get "#{BASE_URL}/{{name}}s", params: searchParams
          .then ({{name}}s) ->
            resolve {{name}}s.data
          .catch (err) ->
            reject (err)

    @get = (id) ->
      $q (resolve, reject) ->
        $http.get "#{BASE_URL}/{{name}}s/#{id}"
          .then ({{name}}) ->
            resolve {{name}}.data
          .catch (err) ->
            reject (err)

    @create = ({{name}}) ->
      $q (resolve, reject) ->
        $http.post "#{BASE_URL}/{{name}}s", {{name}}
          .then ({{name}}) ->
            resolve {{name}}.data
          .catch (err) ->
            reject (err)

    @update = ({{name}}) ->
      $q (resolve, reject) ->
        $http.put "#{BASE_URL}/{{name}}s/" + {{name}}.id, {{name}}
          .then ({{name}}) ->
            resolve {{name}}.data
          .catch (err) ->
            reject (err)

    @delete = ({{name}}) ->
      $q (resolve, reject) ->
        $http.delete "#{BASE_URL}/{{name}}s/" + {{name}}.id
          .then ({{name}}) ->
            resolve {{name}}.data
          .catch (err) ->
            reject (err)

    return this
]
