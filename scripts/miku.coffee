# Description:
#   ミクに関する関数群

module.exports = (robot) ->

    robot.hear /^(miku|ミク|みく|初音|はつね)$/i, (msg) ->
        msg.send "なあに？☺️"
