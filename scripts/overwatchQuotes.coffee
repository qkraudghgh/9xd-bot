# author: hunj
# Description:
#   #overwatch 채널 내에서 캐릭터의 이름이 거론되면, 그 캐릭터의 대사를 말한다.

module.exports = (robot) ->
  robot.hear /(류승룡|겐지)/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "류승룡기모찌!"

  robot.hear /(리퍼)/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "죽어라, 죽어라, 죽어라...!!"

  robot.hear /(맥|멕|메|매)크리/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "석양이 진다.."

  robot.hear /(솔(저|져)|김병장)/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "목표를 포착했다!"

  robot.hear /트레이서/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "새로운 영웅은 언제나 환영이야! (너만 빼고.)"

  robot.hear /파라/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "하늘에서 정의가--으어엌!"

  robot.hear /메이(?!커)/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "개인적인 악감정은 없어요!"

  robot.hear /(바스|바스티온)/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "`쀼쀼삐 쀼삐!`"

  robot.hear /(위도|위메)/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "아무도 내게서 숨지 못해.."

  robot.hear /정크(랫|렛)/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "폭탄 받아라! 이히힣히힣히힣"

  robot.hear /토르비욘/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "*용 광 로 ! ! !*"

  robot.hear /한조/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "류가 와가떼끼오 꾸레!"

  robot.hear /(디바|DVa|D.Va|송하나)/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "게임을 하면 이겨야지!"

  robot.hear /(라인|라인하르트)/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "*망치 나가신다!*"

  robot.hear /로드호그/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "*돼재앙*이 준비됐다!"

  robot.hear /(윈스턴|고릴라)/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "아뇨, 바나나는 필요 없습니다."

  robot.hear /자리야/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "함께일 때, 우린 강합니다!"

  robot.hear /루시우/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "씐나게 놀아보자!"

  robot.hear /(메르시|메르띠)/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "영웅은 죽지 않아요!"

  robot.hear /(시메트라|아름이)/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "인류의 진정한 적은 무질서예요."

  robot.hear /젠야(타|따)/i, (res) ->
    if res.message.user.room is 'overwatch'
      robot.messageRoom "#overwatch", "진정한 자아엔 형체가 없는 법."