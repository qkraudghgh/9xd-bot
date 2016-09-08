module.exports = (robot) ->
  robot.hear /갈바 (가위|바위|보|묵|찌|빠|)$/i, (msg) ->
    choices = ['가위', '바위', '보']
    rocks = ['바위', '묵']
    scissors = ['가위', '찌']
    papers = ['보', '빠']

    username = getUserName(msg)
    user_choice = msg.match[1]
    bot_choice = choices[Math.floor(Math.random() * choices.length)]

    bot_match_status = 0 # 승: 1, 무: 0, 패: -1
    response = ''

    if (bot_choice in rocks and user_choice in rocks) or
      (bot_choice in scissors and user_choice in scissors) or
      (bot_choice in papers and user_choice in papers)
        bot_match_status = 0
    else
        if bot_choice is '가위'
          if user_choice in rocks
            bot_match_status = -1
          else
            bot_match_status = 1
        else if bot_choice is '바위'
          if user_choice in papers
            bot_match_status = -1
          else
            bot_match_status = 1
        else
          if user_choice in scissors
            bot_match_status = -1
          else
            bot_match_status = 1

    if bot_match_status == 1
      response = "[9xd 승리] : (#{username}, #{user_choice}) vs (9xd, #{bot_choice})"
    else if bot_match_status == 0
      response = "[무승부] : (#{username}, #{user_choice}) vs (9xd, #{bot_choice})"
    else
      response = "[#{username} 승리] : (#{username}, #{user_choice}) vs (9xd, #{bot_choice})"

    msg.send response

  getUserName = (msg) ->
    msg.message.user.name.replace /\./g, "_"
