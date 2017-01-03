# author : jelly, hunJ, myounghoPak
# Dependency:
#    - cron
# Description:
# 한국시간 (KST) 기준 23시가 되면 #_general 에 #darknight 로 이동하러는 메세지를 출력한다.
#                     07시가 되면 #darknight 에 #_general 로 이동하라는 메세지를 출력한다.

cronJob = require('cron').CronJob

module.exports = (robot) ->
  darknightJob = new cronJob('0 0 23 * * *', wakeUpDarknight(robot), null, true, "Asia/Seoul")
#  generalJob = new cronJob('0 0 7 * * *', wakeUpGeneral(robot), null, true, "Asia/Seoul")
  darknightJob.start()
#  generalJob.start()

# 오후 11시에 WakeUpDarkNight 호출
wakeUpDarknight = (robot) ->
  -> robot.messageRoom '#_general', '자 이제 모두 <#C1CJNKQGZ|darknight>로 이동해주세요!'

# 오전 7시에 wakeUpGeneral 호출
# 요즘 닭나들이 별로 없는데 봇만 얘기해서 주석처리함 
#wakeUpGeneral = (robot) ->
#  -> robot.messageRoom '#darknight', '자 이제 모두 <#C0ZAS4N31|_general>로 이동해주세요!'

