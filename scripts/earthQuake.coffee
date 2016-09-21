request = require('request');
module.exports = (robot) ->
  url = 'https://twitter.com/search?f=tweets&vertical=default&q=%EC%A7%80%EC%A7%84'
  setInterval (->
    request url, (error, response, html) ->
      if !error
        regex = /(data-aria-label-part="last">([1]|)[0-9]초 전)/g
        count = 0
        loop
          arr = regex.exec(html)
          if arr != null
            count++
          else
            break
        if count >= 20
          robot.messageRoom '#_general', '지진!!!!!!!!!!'
      return
    return
  ), 60000
