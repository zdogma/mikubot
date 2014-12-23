# Description:
#   コミュニケーションに役立つ吹き出し

eastasianwidth = require 'eastasianwidth'
strpad = (str, count) ->
  new Array(count + 1).join str

module.exports = (robot) ->

    robot.respond /\^ (.*)$/i, (msg) ->
        message = msg.match[1].replace /^\s+|\s+$/g, ''
        return until message.length

        length = Math.floor eastasianwidth.length(message) / 2

        bitan = [
            " * #{strpad '―', length + 2} * "
            " *|　#{message}　 |* "
            " * #{strpad '―', length + 2} * "
        ]
        msg.send bitan.join "\n"

    robot.respond />< (.*)$/i, (msg) ->
        message = msg.match[1].replace /^\s+|\s+$/g, ''
        return until message.length

        length = Math.floor eastasianwidth.length(message) / 2

        suddendeath = [
            " *＿#{strpad '人', length + 2}＿* "
            " *＞　#{message}　＜* "
            " *￣Y#{strpad '^Y', length}￣* "
        ]
        msg.send suddendeath.join "\n"
