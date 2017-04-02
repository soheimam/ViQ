module.exports = (robot) ->

  robot.respond /(can you help me\?|Please help me)/i, (msg) ->
    msg.send "What do you need help with human?"
