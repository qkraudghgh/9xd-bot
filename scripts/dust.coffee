# require
http = require 'http'
moment = require 'moment'
q = require 'q'
config = require '../config.json'

# define constant
dust_api_key = config.dust.key
dust_version = config.dust.version

module.exports = (robot) ->
  robot.respond /미세먼지 (.*)$/i, (msg) ->
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
      if response.status is "OK"
        geoCode = {
          lat : response.results[0].geometry.location.lat
          lng : response.results[0].geometry.location.lng
        }
        deferred.resolve(geoCode)
      else
        deferred.reject(err)
  return deferred.promise

getDust = (msg, geoCode, location) ->
  msg.http("http://apis.skplanetx.com/weather/dust?version=#{dust_version}&lat=#{geoCode.lat}&lon=#{geoCode.lng}&appKey=#{dust_api_key}")
    .get() (err, res, body) ->
      response = JSON.parse(body)
      pm = response.weather.dust[0].pm10.value
      grade = response.weather.dust[0].pm10.grade
      time = moment().add(9, 'h').format('MM월 DD일 HH시')
      msg.send "현재시각 #{time} #{location}의 미세먼지 농도(pm10)은 `#{pm}`이며 현재 대기상황 `#{grade}`입니다."
