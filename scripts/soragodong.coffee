# Description
#   마법의 소라고동님

module.exports = (robot) ->
  robot.hear /^(마법의소라고동|소라고동|마법의소라고둥|소라고둥|마법의 소라고동|마법의 소라고둥)(\s|님\s)/i, (msg) ->
    answers = ['그래.', '안돼.', '나중에 해', '가만히 있어.', '둘 다 하지마.', '아니.', '하고싶은대로 해.', '아아안 돼애에.', '다시 한번 물어봐.', '포기해.', '당장 시작해.', '응.', '허락 할게.', '돼.', '하지마.', '포기해.', '당장 시작 해']
    msg.send answers[Math.floor(Math.random() * answers.length)]
