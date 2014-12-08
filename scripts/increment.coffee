# Description:
#  increment or decrement

module.exports = (robot) ->
  KEY_SCORE = 'key_score'

  getScores = () ->
    return robot.brain.get(KEY_SCORE) or {}

  # ++ or --された時にscoreを更新する
  changeScore = (name, diff) ->
    source = getScores()
    score = source[name] or
      plus  : 0
      minus : 0
    if diff >= 0
      score.plus++
    else
      score.minus++
    source[name] = score
    robot.brain.set KEY_SCORE, source
    robot.brain.save()
    return score

  # ++ or --された時に先頭の'@'削除, 後ろの': ', ++ or --の前に空白スペースあれば削除しつつ, 名前を返す
  getNameFromMessage = (msg) ->
    return msg.match[1].replace(/^@/, "").replace(/: $/, "").replace(/\s+$/,"")

  # ++ or --された人の名前とした人の名前が一致しているかどうかチェック
  validateName = (target_name, speaker_name) ->
    return target_name == speaker_name

  # 一覧表示
  robot.respond /lv/i, (msg) ->
    source = getScores()
    for name, score of source
      msg.send "#{name}さんはLv.#{score.plus - score.minus}だよ♪ (++:#{score.plus}, --:#{score.minus})"

  # increment
  robot.hear /^(.+)\+\+$/i, (msg) ->
    speaker_name = msg.message.user.name
    name = getNameFromMessage(msg)

    if validateName(name, speaker_name)
      msg.send "自分のLv.上げちゃだめだよ！😓"
    else
      new_score = changeScore(name, 1)
      msg.send "#{name}はLv.#{new_score.plus - new_score.minus}になったよ✨(++:#{new_score.plus}, --:#{new_score.minus})"

  # decrement
  robot.hear /^(.+)--$/i, (msg) ->
    speaker_name = msg.message.user.name
    name = getNameFromMessage(msg)
    if validateName(name, speaker_name)
      msg.send "自分のLv.を、下げるなんてダメだよ..."
    else
      new_score = changeScore(name, -1)
      msg.send "#{name}はLv.#{new_score.plus - new_score.minus}になったよ😌 (++:#{new_score.plus}, --:#{new_score.minus})"
