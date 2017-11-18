# Description
#   현재 기상 레이더 사진을 10분단위로 가져와서 비가올지 직접 판단할 수 있도록 하자.
#   구름이나 미세한 물방울에 반사 및 산란해서 돌아온 전파를 수신하여 구름의 상태를 관측하는 레이다 장비이다.
#   전파의 산란은 물방울이나 얼음 입자의 크기와 양, 형태에 따라 좌우되며,
#   산란의 강도는 단위 부피속에 포함된 수적 입자의 양과 크기에 대해 정비례의 관계가 있으므로
#   수신된 신호 강도로 강우의 강도를 추정할 수가 있다.
#
# Commands:
#   일기에보를 믿을 수 없다면, 실시간으로 직접 보자.
#
# Author :
#   dot2line

module.exports = (robot) ->
  robot.hear /구름아어딨니$/i, (msg) ->
    today = new Date
    today.setMinutes(today.getMinutes() - 20)

    if today.getMinutes() % 10 != 0
      minute = "#{today.getMinutes() - today.getMinutes() % 10}"
    else
      minute = "0#{today.getMinutes()}"

    timeStr = "#{today.getFullYear()}#{today.getMonth() + 1}#{today.getDate()}#{today.getHours()}#{minute}"

    msg.send "비구름은 여깄당! http://m.kma.go.kr/repositary/image/rdr/img/RDR_TOQCZ_CP15M1_" + "#{timeStr}.png"
