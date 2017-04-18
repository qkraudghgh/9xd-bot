# Description:
#   Get GitHub trending repositories
#
# Commands:
#   hubot github trending - Get top 5 GitHub trending repositories
#   hubot github trending :lang - Get top 5 GitHub trending repositories with lang
cheerio = require 'cheerio'
request = require 'request'

module.exports = (robot) ->

  robot.respond /github trending$/i, (msg) ->
    baseUrl = 'https://github.com'
    request baseUrl + '/trending', (_, res) ->
      $ = cheerio.load res.body

      i = 0
      $('.d-inline-block > h3 > a').each ->
        a = $(this)
        url = baseUrl + a.attr('href')
        msg.send url
        i++
        if i >= 5
          return false

  robot.respond /github trending (.+)$/i, (msg) ->
    lang = msg.match[1]
    baseUrl = 'https://github.com'
    request baseUrl + '/trending/' + lang, (_, res) ->
      $ = cheerio.load res.body

      i = 0
      $('.d-inline-block > h3 > a').each ->
        a = $(this)
        url = baseUrl + a.attr('href')
        msg.send url
        i++
        if i >= 5
          return false