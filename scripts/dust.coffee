# Description
#   API를 통해 대기오염도를 알려준다.
#
# Dependencies:
#   "http"
#   "moment"
#   "q"
#
# Commands:
#   9xd <지역> 대기오염도! - 원하는 지역의 대기오염도를 알려줍니다.
#
# Author:
#   myoungho.pak and jelly

# require
http = require 'http'
moment = require 'moment'
q = require 'q'
config = require '../config.json'

# define constant
dust_api_key = config.dust.key

module.exports = (robot) ->
  robot.respond /(.*) 대기오염도!/i, (msg) ->
    location = decodeURIComponent(unescape(msg.match[1]))
    getGeocode(msg, location)
    .then (geoCode) ->
        getDust(msg, geoCode, location)
    .catch ->
        msg.send '지역 불러오기를 실패하였습니다.'


getGeocode = (msg, location) ->
  deferred= q.defer()
  msg.http("https://maps.googleapis.com/maps/api/geocode/json")
    .query({
      address: location
    })
    .get() (err, res, body) ->
      response = JSON.parse(body)
      geo = response.results[0].geometry.location
      if response.status is "OK"
        geoCode = {
          lat : geo.lat
          lng : geo.lng
        }
        deferred.resolve(geoCode)
      else
        deferred.reject(err)
  return deferred.promise

getDust = (msg, geoCode, location) ->
  msg.http("https://api.waqi.info/feed/geo:#{geoCode.lat};#{geoCode.lng}/?token=#{dust_api_key}")
    .get() (err, res, body) ->
      data = JSON.parse(body).data
      aqi = data.aqi
      if aqi < 50
        grade = "좋음(대기오염 관련 질환자군에서도 영향이 유발되지 않을 수준)"
      else if 50 < aqi and aqi < 100
        grade = "보통(환자군에게 만성 노출시 경미한 영향이 유발될 수 있는 수준)"
      else if 100 < aqi and aqi < 150
        grade = "민감군 영향(환자군 및 민감군에게 유해한 영향이 유발될 수 있는 수준)"
      else if 150 < aqi and aqi < 200
        grade = "나쁨(환자군 및 민감군[어린이, 노약자 등]에게 유해한 영향 유발, 일반인도 건강상 불쾌감을 경험할 수 있는 수준)"
      else if 200 < aqi and aqi < 300
        grade = "매우 나쁨(환자군 및 민감군에게 급성 노출시 심각한 영향 유발, 일반인도 약한 영향이 유발될 수 있는 수준)"
      else if aqi >= 300
        grade = "위험(환자군 및 민감군에게 응급 조치가 발생되거나, 일반인에게 유해한 영향이 유발될 수 있는 수준)"
      time = moment().add(9, 'h').format('MM월 DD일 HH시')
      msg.send "현재시각 #{time} #{location}의 대기 품질 지수(AQI)는 `#{aqi}`이며 현재 대기상황 `#{grade}`입니다."
