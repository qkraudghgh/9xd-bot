# Description
#   확률을 계산해준다.
#
# Commands:
#   <message> 확률! - ~할 ~일 확률!의 형태로 작성하며 느낌표는 필수로 입력해준다.
#
# Author:
#   river-mountain

module.exports = (robot) ->
  robot.hear /(.*) 확률!/i, (msg) ->
    target = msg.match[1]
    msg.send "#{target} 확률은 약 #{(Math.random() *100).toPrecision(2)}%!"
