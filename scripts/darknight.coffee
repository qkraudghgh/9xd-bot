# author : jelly
# Dependency:
#    - cron

cronJob = require('cron').CronJob

module.exports = (robot) ->
  cronJob = require('cron').CronJob
    new cronJob('0 */1 * * * *', wakeUpDarkNight(robot), null, true)

wakeUpDarknight = (robot) ->
    robot.messageRoom '#darknight' '아침이 밝아옵니다'