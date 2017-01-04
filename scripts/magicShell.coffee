FirebaseUtil = require './firebase-util'

module.exports = (robot) ->
  fb = new FirebaseUtil(robot, "bot-brain-lang")

  robot.hear /구엑스디|구엑스$/i, (msg) ->
    getData(msg)

  robot.hear /말가르치기! (.*)/i, (msg) ->
    saveData(msg, msg.match[1])

  getData = (msg) ->
    fb.once "value", (data) ->
      objectKeys = Object.keys(data.val())
      index = Math.floor(Math.random() * objectKeys.length)
      data.forEach (data) ->
        if(data.key() == objectKeys[index])
          msg.send "#{data.val()}" #덧붙이는 말은 일단 제외..

  saveData = (msg, data) ->
    fb.push(data).then ->
      msg.send "구엑스디가 #{data}을(를) 배웠습니다."
