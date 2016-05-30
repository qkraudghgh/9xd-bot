module.exports = (robot) ->
  http = require 'http'

  robot.hear /자살각|한강온도/i, (msg) ->
    fetchRiverTemperature(msg)

  fetchRiverTemperature = (msg) ->
    msg.http("http://hangang.dkserver.wo.tc")
      .get() (err, res, body) ->
        try
          json = JSON.parse(body)
          msg.send "현재 한강물의 온도 #{json.temp}℃ 입니다"
        catch e
          msg.send "현재  Api를 불러올 수 없습니다."
        


