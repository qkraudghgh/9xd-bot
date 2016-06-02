module.exports = (robot) ->
  robot.hear /환영합니다!/i, (msg) ->
    msg.send '#general, #random 채널 이외의 많은 채널들이 있어. 채널 메뉴에서 + 버튼을 통해 많은 채널들의 가입 할 수 있지. 딱히 널 환영해서 말해 주는 건 아니니까 착각하지 마!'
