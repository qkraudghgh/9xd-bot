# Description
#    한국시간(KST) 기준 오전 8시 30분이 되면 Packtpub의 오늘의 무료책을 알려준다.
#    (https://www.packtpub.com/packt/offers/free-learning)
#
# Dependencies:
#    "cheerio"
#    "http"
#    "cron"
#
# Author:
#    AWEEKJ(a.k.a. MODO)

cheerio = require 'cheerio'
http = require 'http'
cronJob = require('cron').CronJob

targetUrl = "https://www.packtpub.com/packt/offers/free-learning"
timeZone = "Asia/Seoul"

module.exports = (robot) ->
    new cronJob('0 30 8 * * *', sendMessageMethod(robot), null, true, timeZone)

# 쓸모 없어 보이지만 안정화에 도움이 된다. 이유는 모름..
sendMessageMethod = (robot) ->
    -> sendMessage(robot)

sendMessage = (robot) ->
    robot.http(targetUrl).get() (err, res, body) ->
        $ = cheerio.load(body)
        title = $('.dotd-title').text()
        title = title.replace /\n|\t/g, ""
        robot.messageRoom '#_general', "아침을 여는 무료책! <#{title}> https://www.packtpub.com/packt/offers/free-learning"
