# Description:
#   Handles GET /

module.exports = (robot) ->
  robot.router.get '/', (req, res) ->
    res.send 200
