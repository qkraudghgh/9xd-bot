Firebase = require 'firebase'
FirebaseTokenGenerator = require 'firebase-token-generator'

FIREBASE_URL = "https://9xd-bot.firebaseio.com/brain"
FIREBASE_SECRET = "b1z9KEjv9ts33CN29eDJflET97EkV0KTSnmvpjlA"
responses = ['먹어라', '이(나)먹자', '먹어', '<-', '이(가) 최고지']

module.exports = (robot) ->
  if FIREBASE_URL?
    robot.brain.setAutoSave false
    firebaseBrain = new Firebase(FIREBASE_URL)

    if FIREBASE_SECRET?
      tokenGenerator = new FirebaseTokenGenerator FIREBASE_SECRET
      token = tokenGenerator.createToken({ "uid": "hubot", "hubot": true });
      firebaseBrain.authWithCustomToken token, (error, authData) ->
        if error
          robot.logger.warning '인증실패', error
  else
    robot.logger.warning "URL is undefined"

  robot.respond /메뉴추천|메뉴추가 (.*)/i, (msg) ->
    if msg.match[1]?
      saveData(msg, firebaseBrain, msg.match[1])
    else
      getData(msg, firebaseBrain)


getData = (msg, firebaseBrain) ->
  firebaseBrain.once "value", (data) ->
    objectKeys = Object.keys(data.val())
    index = Math.floor(Math.random() * objectKeys.length)
    data.forEach (data) ->
      if(data.key() == objectKeys[index])
        msg.send "#{data.val()} #{responses[Math.floor(Math.random() * responses.length)]}"

saveData = (msg, firebaseBrain, data) ->
  firebaseBrain.push(data).then ->
    msg.send "메뉴 #{data} 추가 완료!"
