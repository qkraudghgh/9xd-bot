# created by myoungho.pak and jelly
moment = require 'moment'

# 날짜 init
day = 1000 * 3600 * 24 # 하루를 ms로 표현
week = day * 7
onWeek = day * 5

module.exports = (robot) ->
  robot.respond /주말[\s]{0,}로딩|월요일[\s]{0,}로딩/i, (msg) ->
    messageSend(msg)

# 주말까지 or 주말이 몇 %가 남았는지 계산
calculatePercent = (remainTime, isWeekendDay) ->
  if isWeekendDay
    (remainTime - onWeek) / (day * 2) * 100
  else
    remainTime / onWeek * 100

makeBlock = (percent, isWeekendDay) ->
  blockCount = parseInt(parseFloat(percent) / 5)
  blackBlock = '■'
  whiteBlock = '□'
  totalBlock = blackBlock.repeat(blockCount) + whiteBlock.repeat(20-blockCount)
  if isWeekendDay
    '월요일 로딩중...' + ' ' +'[' + totalBlock + ']'
  else
    '주말 로딩중...' + ' ' + '[' + totalBlock + ']'

messageSend = (msg) ->
  nowTime = moment().add(3, 'd').add(9, 'h') #1970년 1월 1일은 목요일이었음...
  remainTime = nowTime % week
  isWeekendDay = if remainTime > onWeek then true else false # 엄청난 커피다
  msg.send makeBlock(calculatePercent(remainTime, isWeekendDay).toFixed(2), isWeekendDay) + ' ' +calculatePercent(remainTime, isWeekendDay).toFixed(2) + '%'

