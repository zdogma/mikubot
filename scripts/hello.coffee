# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

# 設定
tumblr = require "tumblrbot"
SOURCES = {
    "mikugifanime.tumblr.com",
    "astrogaze.tumblr.com"
}

getGif = (blog, msg) ->
    tumblr.photos(blog).random (post) ->
        msg.send post.photos[0].original_size.url

KEY_SCORE = 'key_score'
  
getScores = () ->
    return robot.brain.get(KEY_SCORE) or {}
  
changeScore = (name, diff) ->
    source = getScores()
    score = source[name] or 0
    new_score = score + diff
    source[name] = new_score
    robot.brain.set KEY_SCORE, source
    return new_score
  
eastasianwidth = require 'eastasianwidth'
strpad = (str, count) ->
  new Array(count + 1).join str

# 関数群
module.exports = (robot) ->

    robot.hear /@miku|@ミク|@みく/i, (msg) ->
        blog = msg.random Object.keys(SOURCES)
        getGif blog, msg
  
    robot.hear /^キークエ$/i, (msg) ->
        msg.send "狩りに行くの？気をつけてね❤️"
        msg.send "【キークエ一覧】http://wiki.mh4g.org/data/1438.html"

    robot.hear /^ボス$/i, (msg) ->
        msg.send "これがボスの弱点よ‼️"
        msg.send "【ボス一覧】http://wiki.mh4g.org/data/1466.html"

    robot.hear /^防具$/i, (msg) ->
        msg.send "いろんな種類があるのね😊"
        msg.send "【防具一覧】http://wiki.mh4g.org/data/1445.html"

    robot.hear /^武器$/i, (msg) ->
        msg.send "男はみんな武器に夢中なんだから😖"
        msg.send "【武器一覧】http://wiki.mh4g.org/data/1172.html"

    robot.hear /^スキル$/i, (msg) ->
        msg.send "かっこいいスキルを身につけてね😍"
        msg.send "【スキル一覧】http://wiki.mh4g.org/data/1446.html"

    robot.respond /\<\> (.*)$/i, (msg) ->
        message = msg.match[1].replace /^\s+|\s+$/g, ''
        return until message.length

        length = Math.floor eastasianwidth.length(message) / 2

        bitan = [
            " */#{strpad '__', length + 2}\\* "
            " *|　#{message}　|* "
            " *\\#{strpad '__', length}/* "
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

# Description:
# Utility commands for voting someone.
#
# Commands:
# <name>++, <name>--, !vote-list, !vote-clear
  
    robot.hear /!vote-list/i, (msg) ->
        source = getScores()
        console.log source
        for name, score of source
            msg.send "#{name}: #{score}"
    
    robot.hear /!vote-clear/i, (msg) ->
        robot.brain.set KEY_SCORE, null
    
    robot.hear /([A-z]+)\+\+$/i, (msg) ->
        name = msg.match[1]
        new_score = changeScore(name, 1)
        msg.send "#{name}: #{new_score}"
    
    robot.hear /([A-z]+)--$/i, (msg) ->
        name = msg.match[1]
        new_score = changeScore(name, -1)
        msg.send "#{name}: #{new_score}"


# robot.respond /open the (.*) doors/i, (msg) ->
  #   doorType = msg.match[1]
  #   if doorType is "pod bay"
  #     msg.reply "I'm afraid I can't let you do that."
  #   else
  #     msg.reply "Opening #{doorType} doors"
  #
  # robot.hear /I like pie/i, (msg) ->
  #   msg.emote "makes a freshly baked pie"
  #
  # lulz = ['lol', 'rofl', 'lmao']
  #
  # robot.respond /lulz/i, (msg) ->
  #   msg.send msg.random lulz
  #
  # robot.topic (msg) ->
  #   msg.send "#{msg.message.text}? That's a Paddlin'"
  #
  #
  # enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
  # leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  #
  # robot.enter (msg) ->
  #   msg.send msg.random enterReplies
  # robot.leave (msg) ->
  #   msg.send msg.random leaveReplies
  #
  # answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING
  #
  # robot.respond /what is the answer to the ultimate question of life/, (msg)
  #   unless answer?
  #     msg.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
  #     return
  #   msg.send "#{answer}, but what is the question?"
  #
  # robot.respond /you are a little slow/, (msg)
  #   setTimeout () ->
  #     msg.send "Who you calling 'slow'?"
  #   , 60 * 1000
  #
  # annoyIntervalId = null
  #
  # robot.respond /annoy me/, (msg)
  #   if annoyIntervalId
  #     msg.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #     return
  #
  #   msg.send "Hey, want to hear the most annoying sound in the world?"
  #   annoyIntervalId = setInterval () ->
  #     msg.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #   , 1000
  #
  # robot.respond /unannoy me/, (msg)
  #   if annoyIntervalId
  #     msg.send "GUYS, GUYS, GUYS!"
  #     clearInterval(annoyIntervalId)
  #     annoyIntervalId = null
  #   else
  #     msg.send "Not annoying you right now, am I?"
  #
  #
  # robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
  #   room   = req.params.room
  #   data   = JSON.parse req.body.payload
  #   secret = data.secret
  #
  #   robot.messageRoom room, "I have a secret: #{secret}"
  #
  #   res.send 'OK'
  #
  # robot.error (err, msg) ->
  #   robot.logger.error "DOES NOT COMPUTE"
  #
  #   if msg?
  #     msg.reply "DOES NOT COMPUTE"
  #
  # robot.respond /have a soda/i, (msg) ->
  #   # Get number of sodas had (coerced to a number).
  #   sodasHad = robot.brain.get('totalSodas') * 1 or 0
  #
  #   if sodasHad > 4
  #     msg.reply "I'm too fizzy.."
  #
  #   else
  #     msg.reply 'Sure!'
  #
  #     robot.brain.set 'totalSodas', sodasHad+1
  #
  # robot.respond /sleep it off/i, (msg) ->
  #   robot.brain.set 'totalSodas', 0
  #   robot.respond 'zzzzz'
