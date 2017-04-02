module.exports = (robot) ->

  robot.respond /(hello|yo|Hallo|Goedemorgen|hoi)/i, (msg) ->
    msg.send "hi #{msg.message.user.name}"
