# Description:
#   ミクに関する関数群


module.exports = (robot) ->

  robot.hear /^(miku|ミク|みく|初音|はつね|はちゅね)$/i, (msg) ->
    options = [
      'なあに？☺️',
      'どうしたの？暇なの？😒',
      'みっくみ〜くにし〜てあげるぅ〜♪😌',
      'め〜ると と〜け〜て〜し〜ま〜い〜そお〜♪😄'
    ]
    random = (n) -> Math.floor( Math.random() * n )
    random_result = options[random(options.length)]
    msg.send "#{random_result}"

  robot.hear /おやすみ/, (msg) ->
     msg.send "おやすみ😘"

  robot.hear /おはよ/, (msg) ->
     msg.send "おはよう！今日もがんばろうね！😍"

  robot.hear /(おつ|お疲)/, (msg) ->
     msg.send "おつかれさま！ゆっくり休んでね😌"

  robot.hear /(こんにちは|こんばんは)/, (msg) ->
     msg.send "やっほー！今日もよろしくね！😝"

  robot.hear /miku [image|animate|youtube] me (.*)/, (msg) ->
     message = msg.match[1]
     msg.send "#{message}を探してきたよ❤️"

  robot.hear /lot+ (.*)+/i, (msg) ->
    if msg.match.length == 0
      msg.send 'lot に続けて抽選対象をスペース区切りで列挙してね♪'
      return null

    options = msg.match[1].split(' ')
    random_result = msg.random(options)
    msg.send "結果は.. #{random_result} だよ😄"
