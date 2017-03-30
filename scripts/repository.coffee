# Description
#   현재 9xd-bot Github 저장소의 주소를 알려준다.
#
# Commands:
#   9xd (which|localhost|remote -v|소스|레포) - 9xd-bot의 Github 저장소 주소를 알려준다.
#
# Author:
#   Leop0ld

module.exports = (robot) ->

  robot.respond /which|localhost|remote -v|소스|레포$/, (msg) ->
    msg.send "https://github.com/qkraudghgh/9xd-bot"
