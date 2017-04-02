module.exports = (robot) ->

  robot.respond /keywords/i, (msg) ->

    striptags = require('striptags')
    desk = require('desk.js')
    client = desk.createClient(
      endpoint: env.process.endpoint
      username: env.process.username
      password: env.process.pass
      retry: true)

    client.get '/api/v2/articles/', (err, response) ->
      if err
        e = err
        msg.send "#{e}"
      i = 0
      array = []
      while i < response._embedded.entries.length
        html = response._embedded.entries[i].keywords
        if html
          output = striptags(html)
          output = output.replace(/&nbsp;/g, ' ')
          output = output.replace(/&rsquo;/g,'\'')
          array.push output
        i++
      msg.send "`#{array}`"  
      return
