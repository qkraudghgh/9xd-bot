# author : jelly
# Dependency:
#    - cron
# Description:
# 한국시간 (KST) 기준 23시가 되면 #_general 에 #darknight 로 이동하러는 메세지를 출력한다.
#                     07시가 되면 #darknight 에 #_general 로 이동하라는 매새자룰 출력한다.

cronJob = require('cron').CronJob

module.exports = (robot) ->
  new cronJob('0 0 14 * * *', wakeUpDarknight(robot), null, true)

wakeUpDarknight = (robot) ->
  -> robot.messageRoom '#_general', '자 이제 모두 <#C1CJNKQGZ|darknight>로 이동해주세요!'

# 오전 7시에 wakeUpGeneral 호출
module.exports = (robot) ->
  new cronJob('0 0 22 * * *', wakeUpGeneral(robot), null, true)

wakeUpGeneral = (robot) ->
  -> robot.messageRoom '#darknight', '자 이제 모두 <#C0ZAS4N31|_general>로 이동해주세요!'