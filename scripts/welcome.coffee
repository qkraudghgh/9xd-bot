module.exports = (robot) ->
  robot.enter (res) ->
    if res.message.user.room is '_general'
      robot.messageRoom "#_general", "#{res.message.user.name}?? 신입이냐! <#C1FPEBQ1Y|_notice>, <#C0ZAS4N31|_general> 채널 이외에도 많은 채널들이 있어. 너가 원하는 채널로 들어가서 마음껏 떠들도록 해. 딱히 널 환영해서 말해주는 건 아니니까 착각하지 맛! 흥!"

