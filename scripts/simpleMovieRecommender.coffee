# Description:
# Recommend Movie

cheerio = require 'cheerio'
request = require 'request'
q = require 'q'
client_id = 'oJAWvjM0ofFX0KfipC5o'
client_secret = '_3cscXutJ5'

module.exports = (robot) ->
  robot.respond /(.*)(랑 비슷한 영화!|같은거 추천해줘|비슷한 영화!)/i, (msg) ->
    movieName = decodeURIComponent(unescape(msg.match[1]))
    getMovieLink(msg, movieName)
      .then (link) ->
        getRecommendMovie(msg, link)
      .catch ->
        msg.send '영화 검색에 실패했어요!'

getMovieLink = (msg, movieName) ->
  deferred= q.defer()
  api_url = 'https://openapi.naver.com/v1/search/movie?query=' + encodeURI(movieName)
  options = {
    url: api_url,
    headers: {'X-Naver-Client-Id':client_id, 'X-Naver-Client-Secret': client_secret}
  }
  request.get options, (err, res, body) ->
    response = JSON.parse(body)
    if response.items.length > 0
      link = response.items[0].link
      deferred.resolve(link)
    else
      deferred.reject(err)
  return deferred.promise

getRecommendMovie = (msg, link) ->
  request link, (_, res) ->
    $ = cheerio.load res.body
    i = 0
    $('.thumb_link_mv > li > a.thumb').each ->
      a = $(this)
      url = "http://movie.naver.com" + a.attr('href')
      msg.send url
      i++
      if i >= 5
        return false
