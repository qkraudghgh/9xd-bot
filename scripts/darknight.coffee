# author : jelly
# Dependency:
#    - cron

cronJob = require('cron').CronJob

module.exports = (robot) ->
  new cronJob('0 0 14 * * *', wakeUpDarknight(robot), null, true)

wakeUpDarknight = (robot) ->
  -> robot.messageRoom '#_general', '자 이제 모두 <#C1CJNKQGZ|darknight>로 이동해주세요!'
