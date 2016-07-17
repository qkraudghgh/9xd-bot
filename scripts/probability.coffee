module.exports = (robot) ->
  robot.hear /(.*) 확률!/i, (msg) ->
    target = msg.match[1]
    msg.send "#{target} 확률은 약 #{(Math.random() *100).toPrecision(2)}%!"
