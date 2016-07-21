# Description
#   Firebase를 이용해 메뉴를 추가하고 메뉴를 추천받을 수 있다.
#
# Dependencies:
#  "./firebase-util"
#
# Commands:
#   메뉴추가! <메뉴이름> - 메뉴를 추가할 수 있으며, 메뉴이름을 '김치볶음밥 먹어봐' 형식으로 작성하면 더욱 좋다.
#   메뉴추천! - 데이터베이스에서 무작위로 하나를 뽑아 메뉴를 추천해준다.
#
# Author:
#   river-mountain

FirebaseUtil = require './firebase-util'
module.exports = (robot) ->
  fb = new FirebaseUtil(robot, "brain")
  robot.hear /메뉴추천!/i, (msg) ->
    getData(msg)

  robot.hear /메뉴추가! (.*)/i, (msg) ->
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
      msg.send "메뉴 #{data} 추가 완료!"
