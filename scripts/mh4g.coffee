# Description:
#   モンハンを円滑にプレイするための関数群

module.exports = (robot) ->

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

    robot.hear /^料理$/i, (msg) ->
        msg.send "こんがりお肉食べたいな🎵🍖"
        msg.send "【料理クエスト一覧】http://mh4g.com/capture/c-kitchen.php"
