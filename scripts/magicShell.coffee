module.exports = (robot) ->
  robot.hear /구엑스디|구엑스/i, (msg) ->
    responses = ['그래', '안돼', '기다려', '맘대로 해', '몰라', '안들려', '같이가', '뭐', '아닌데', '^^...', 'ㅇㅇ', '어쩌라고', '후...', '빠잉', '반가워', '하이', '공부하자', '웅?']
    msg.send responses[Math.floor(Math.random() * responses.length)]
