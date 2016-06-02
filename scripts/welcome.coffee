module.exports = (robot) ->
  robot.hear /환영합니다!, (msg) ->
    msg.send "general 채널 random 채널 이외의 많은 채널들이 있다. PC는 왼쪽 채널의 + 버튼을 통해 모바일은 상단의 채널 명을 클릭해서 많은 채널들의 가입 할 수 있다. 본 글은 채널 활성화를 위한 것이지 딱히 당신을 위해서 쓴것은 아니니까 착각하지마!"
