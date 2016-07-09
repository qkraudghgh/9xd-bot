FirebaseUtil = require './firebase-util'
module.exports = (robot) ->
  fb = new FirebaseUtil(robot, "schedules")
  robot.respond /일정출력|일정보여줘|일정추가 (.*)/i, (msg) ->
    userName = msg.message.user.name
    if msg.match[1]?
      saveData(userName, msg, fb, msg.match[1])
    else
      getData(userName, msg, fb)

getData = (userName, msg, fb) ->
  fb.child(userName).once "value", (data) ->
    objectKeys = Object.keys(data.val())
    if objectKeys?
      i = 1;
      data.forEach (data) ->
        msg.send "#{i++} - #{data.val()}"  # 리스트에 담아서 해야하나?
    else
      msg.send "일정이 없다!"

saveData = (userName, msg, fb, data) ->
  fb.child(userName).push(data).then ->
    msg.send "#{data} 일정 추가 완료!"
