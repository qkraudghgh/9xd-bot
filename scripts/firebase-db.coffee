Firebase = require 'firebase'
FirebaseTokenGenerator = require 'firebase-token-generator'

FIREBASE_URL = "https://9xd-bot.firebaseio.com/brain"
FIREBASE_SECRET = "b1z9KEjv9ts33CN29eDJflET97EkV0KTSnmvpjlA"

module.exports = (robot) ->
  robot.respond /메뉴추천/i, (msg) ->
    if FIREBASE_URL?
      robot.brain.setAutoSave false
      firebaseBrain = new Firebase(FIREBASE_URL)

      if FIREBASE_SECRET?
        tokenGenerator = new FirebaseTokenGenerator FIREBASE_SECRET
        token = tokenGenerator.createToken({ "uid": "hubot", "hubot": true });
        firebaseBrain.authWithCustomToken token, (error, authData) ->
          if error
            robot.logger.warning '인증실패', error

      getData(msg, firebaseBrain)
    else
      robot.logger.warning "URL is undefined"

getData = (msg, firebaseBrain) ->
  firebaseBrain.once "value", (data) ->
    objectKeys = Object.keys(data.val())
    index = Math.floor(Math.random() * objectKeys.length)
    data.forEach (data) ->
      if(data.key() == objectKeys[index])
        msg.send "#{data.val()}"
