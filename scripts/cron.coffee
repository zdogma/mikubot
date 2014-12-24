# Description:
##  cron jobs

cron = require('cron').CronJob

module.exports = (robot) ->
  new cron '0 0 11 * * 1-5', () =>
    robot.send {room: "#only_me"}, "@channel: 本日のめっしーについて"
  , null, true, "Asia/Tokyo"
