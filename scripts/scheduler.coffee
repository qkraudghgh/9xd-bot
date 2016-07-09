FirebaseUtil = require './firebase-util'

module.exports = (robot) ->
  fb = new FirebaseUtil(robot, "schedules")
  #메모저장
  robot.respond /메모(.*) (.*)/i, (msg) ->
    userName = msg.message.user.name
    memoType = msg.match[1].replace(/\s+/g, '')
    memo = msg.match[2].replace(/\s+/g, '')

    if memoType in ['저장', '기록', '세이브', '넣기' ,'추가']
      saveData(userName, msg,  memo)

  #메모출력
  robot.respond /메모(.*)/i, (msg) ->
    userName = msg.message.user.name
    memoType = msg.match[1].replace(/\s+/g, '')

    if memoType in ['출력', '보여줘', '좀 보자', '보기', '리스트']
      getData(userName, msg)

  #메모전체제거
  robot.respond /메모(.*)/i, (msg) ->
    userName = msg.message.user.name
    memoType = msg.match[1].replace(/\s+/g, '')

    if memoType in ['전체삭제실행']
      removeAllData(userName, msg)

  #메모 하나 제거
  robot.respond /메모(.*) (.*)/i, (msg) ->
    userName = msg.message.user.name
    memoType = msg.match[1].replace(/\s+/g, '')
    memoIndex = msg.match[2].replace(/\s+/g, '')

    if memoType in ['제거', '석제', '지우기', '지워줘']
      removeData(userName, msg,  memoIndex)

  getData = (userName, msg) ->
    fb.child(userName).once "value", (data) ->
      if data.val()?
        i = 1;
        data.forEach (data) ->
          msg.send "#{i++} - #{data.val()}"  # 리스트에 담아서 해야하나?
      else
        msg.send "메모가 없다!"

  saveData = (userName, msg, memo) ->
    fb.child(userName).push(memo).then ->
      msg.send "메모 #{memo} 추가 완료!"


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
