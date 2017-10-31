# Description
#   Google 검색을 한다
#
# Dependencies:
#   "jsdom"
#   "request"
#
# Commands:
#   !google <query>
#
# Author:
#   Kjwon15

request = require('request')
jsdom = require('jsdom')


getUrl = (node) ->
  url = node.href
  pattern = /\?q=(.+?)(?=&)/

  # This is advertisement
  if url.startsWith '/search'
    return null

  # Extract redirecting url
  if url.startsWith '/url'
    return pattern.exec(url)[1]

  return url


parseResults = (dom) ->
  links = Array.from(
    dom.window.document.querySelectorAll('a.l, .r a')
  ).map(getUrl).filter (elem) -> elem != null
  return links


module.exports = (robot) ->

  robot.hear /^!google (.*)/i, (msg) ->
    query = msg.match[1]
    url = "https://www.google.com/search?q=" + encodeURIComponent query
    request url, (err, res, body) ->
      dom = new jsdom.JSDOM(body)
      links = parseResults dom

      msg.send links[0]
