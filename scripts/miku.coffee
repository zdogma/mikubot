# Description:
#   ミクに関する関数群

module.exports = (robot) ->

    robot.hear /^[miku|ミク|みく]$/i, (msg) ->
        msg.send "なあに？☺️"
