FirebaseUtil = require './firebase-util'

module.exports = (robot) ->
  fb = new FirebaseUtil(robot, "schedules")
  #메모저장
  robot.respond /메모\s*(저장|기록|세이브|넣기|추가) (.*)$/i, (msg) ->
    userName = msg.message.user.name.replace /\./g, "_"
    memo= msg.match[2]
    if msg.match[0].search('in') == -1
      saveData(userName, msg,  memo)

  #메모 공용메모 저장
  robot.respond /메모\s*(저장|기록|세이브|넣기|추가) in(.+) (.+)/i, (msg) ->
    dir = msg.match[2].replace(/\s/gi, '');
    memo = msg.match[3]
    saveCommonData(dir, msg,  memo)

  #메모출력
  robot.respond /메모\s*(출력|보여줘|좀\s*보자|보기|리스트)$/i, (msg) ->
    userName = msg.message.user.name.replace /\./g, "_"
    getData(userName, msg)

  #메모 공용메모 출력
  robot.respond /메모\s*(출력|보여줘|좀\s*보자|보기|리스트) (.*)/i, (msg) ->
    dir = msg.match[2]
    getCommonData(dir, msg)

  #메모전체제거
  robot.respond /메모 전체삭제실행/i, (msg) ->
    userName = msg.message.user.name
    removeAllData(userName, msg)

  #메모 하나 제거
  robot.respond /메모\s*(제거|삭제|지우기|지워줘) (\d+)/i, (msg) ->
    userName = msg.message.user.name
    memoIndex = msg.match[2]
    removeData(userName, msg,  memoIndex)

  getData = (userName, msg) ->
    msg.send userName + "출력"
    fb.child(userName).once "value", (data) ->
      if data.val()?
        i = 1;
        data.forEach (data) ->
          msg.send "#{i++} - #{data.val()}"  # 리스트에 담아서 해야하나?
      else
        msg.send "메모가 없다!"

  getCommonData = (dir, msg) ->
    msg.send dir + "출력"
    fb.child('cm_' + dir).once "value", (data) ->
      if data.val()?
        i = 1;
        data.forEach (data) ->
          msg.send "#{i++} - #{data.val()}"  # 리스트에 담아서 해야하나?
      else
        msg.send "메모가 없다!"

  saveData = (userName, msg, memo) ->
    fb.child(userName).push(memo).then ->
      msg.send "메모 #{memo} 추가 완료!"

  saveCommonData = (dir, msg, memo) ->
    fb.child('cm_' + dir).push(memo).then ->
      msg.send "공용메모 #{memo} in #{dir} 추가 완료!"


  removeData = (userName, msg, memoIndex) ->
    fb.child(userName).once "value", (data) ->
      if data.val()?
        objectKeys = Object.keys(data.val())
        fb.child(userName + '/' + objectKeys[memoIndex-1]).set null
        msg.send "#{memoIndex}번 메모 삭제 완료!"

  removeAllData = (userName, msg) ->
    fb.child(userName).once "value", (data) ->
      if data.val()?
        fb.child(userName).set null
        msg.send "모든 메모 삭제 완료! (복구안됨!)"
