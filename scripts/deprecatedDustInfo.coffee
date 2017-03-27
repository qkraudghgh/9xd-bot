# Description
#   미세먼지 명령어에 대한 Deprecated 안내문구를 출력한다.
#
# Author:
#   Leop0ld

module.exports = (robot) ->
  robot.respond /미세먼지 (.*)/i, (msg) ->
    msg.send "이 명령어는 삭제된 명령어 입니다. `9xd #{msg.match[1]} 대기오염도!` 명령어를 이용해주시면 감사하곘습니다 :)"