module.exports = (robot) ->
  robot.hear /환영합니다!/i, (msg) ->
    msg.send '<https://9xd.slack.com/archives/_general | #_general>, <https://9xd.slack.com/archives/_random | #_random> 채널 이외의 많은 채널들이 있어. 너가 원하는 채널로 들어가서 마음껏 떠들도록 해. 딱히 널 환영해서 말해 주는 건 아니니까 착각하지 마!'
