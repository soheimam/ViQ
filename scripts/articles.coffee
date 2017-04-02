module.exports = (robot) ->

  robot.respond /find (.*)/i, (msg) ->

    term = msg.match[1]
    normalized = term.charAt(0).toUpperCase() + term.slice(1)
    striptags = require('striptags')
    desk = require('desk.js')
    client = desk.createClient(
      endpoint: env.process.endpoint
      username: env.process.username
      password: env.process.pass
      retry: true)

    client.get '/api/v2/articles/', (err, response) ->
      if err
        throw err
      i = 0
      while i < response._embedded.entries.length
        html = response._embedded.entries[i]
        if html.keywords != null
          if html.keywords.indexOf(term) != -1 or html.keywords.indexOf(normalized) != -1 or html.keywords.indexOf(term.toUpperCase()) != -1 or html.keywords.indexOf(term.toLowerCase()) != -1
            output = striptags(html.body)
            output = output.replace(/&nbsp;/g, ' ')
            output = output.replace(/&rsquo;/g,'\'')
            output = output.replace(/&bull;/g,'\*')
            output = output.replace(/&#39;/g,'\'')
            output = output.replace(/&aacute;nd/g,'&')
            output = output.replace(/&euro;/g,'€')
            msg.send "#{output}"
            msg = 'sent'
        i++
      if msg != 'sent'
        msg.send "Sorry #{msg.message.user.name}, I was not able to find any article that matches that keyword."
      return
