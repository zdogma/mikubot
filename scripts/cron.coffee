# Description:
##  cron jobs

cron = require('cron').CronJob

module.exports = (robot) ->
  new cron '0 30 11 * * 1-5', () =>
    robot.send {room: "#only_me"}, "@channel: めっしー"
  , null, true, "Asia/Tokyo"
