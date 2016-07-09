FirebaseUtil = require './firebase-util'
module.exports = (robot) ->
  fb = new FirebaseUtil(robot, "brain")
  robot.respond /메뉴추천|메뉴추가 (.*)/i, (msg) ->
    if msg.match[1]?
      saveData(msg, fb, msg.match[1])
    else
      getData(msg, fb)


getData = (msg, fb) ->
  fb.once "value", (data) ->
    objectKeys = Object.keys(data.val())
    index = Math.floor(Math.random() * objectKeys.length)
    data.forEach (data) ->
      if(data.key() == objectKeys[index])
        msg.send "#{data.val()}"  #덧붙이는 말은 일단 제외..

saveData = (msg, fb, data) ->
  fb.push(data).then ->
    msg.send "메뉴 #{data} 추가 완료!"
