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
        grade = "좋음"
      else if 51 < aqi and aqi < 100
        grade = "보통"
      else if 101 < aqi and aqi < 150
        grade = "민감군영향"
      else if 151 < aqi and aqi < 200
        grade = "나쁨"
      else if 201 < aqi and aqi < 300
        grade = "매우 나쁨"
      else if aqi > 300
        grade = "위험"
      time = moment().add(9, 'h').format('MM월 DD일 HH시')
      msg.send "현재시각 #{time} #{location}의 대기 품질 지수(AQI)는 `#{aqi}`이며 현재 대기상황 `#{grade}`입니다."
