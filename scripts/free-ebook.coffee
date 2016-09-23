# Description
#    "무료책!"을 입력하면 Packtpub의 오늘의 무료책을 확인한다.
#    (https://www.packtpub.com/packt/offers/free-learning)
#
# Dependencies:
#    "cheerio"
#    "http"
#
# Author:
#    AWEEKJ(a.k.a. MODO)

cheerio = require 'cheerio'
http = require 'http'

targetUrl = "https://www.packtpub.com/packt/offers/free-learning"

module.exports = (robot) ->
    robot.hear /무료책!$/i, (robot) ->
        sendMessage(robot)

sendMessage = (robot) ->
    robot.http(targetUrl).get() (err, res, body) ->
        $ = cheerio.load(body)
        title = $('.dotd-title').text()
        title = title.replace /\n|\t/g, ""
        robot.send "어서 <#{title}> 을 가져가시오! https://www.packtpub.com/packt/offers/free-learning"
