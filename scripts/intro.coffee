module.exports = (robot) ->

  robot.respond /(who|what) are you/i, (msg) ->
    msg.send "My Name is Viq (VanMoof IQ)"
