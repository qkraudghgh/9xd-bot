# Description
#   현재 한강물의 온도를 알려준다.
#
# Dependencies:
#   "http"
#
# Commands:
#   자살각 or 한강온도 - 현재 한강물의 온도를 알려줍니다.

module.exports = (robot) ->

  http = require 'http'

  robot.hear /자살각|한강온도$/i, (msg) ->
    fetchRiverTemperature(msg)

  fetchRiverTemperature = (msg) ->
    msg.http("http://hangang.dkserver.wo.tc")
      .get() (err, res, body) ->
        try
          json = JSON.parse(body)
          msg.send "현재 한강물의 온도 #{json.temp}℃ 입니다"
        catch e
          msg.send "현재  Api를 불러올 수 없습니다."
