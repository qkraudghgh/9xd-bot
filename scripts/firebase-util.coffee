Firebase = require 'firebase'
FirebaseTokenGenerator = require 'firebase-token-generator'

FIREBASE_URL = "https://9xd-bot.firebaseio.com/" # 구파이어베이스, 계정 분리를 위해 구 파베 사용 추후 마이그레이션!
FIREBASE_SECRET = "b1z9KEjv9ts33CN29eDJflET97EkV0KTSnmvpjlA" # 문제시 ignore로 빼거나 env에 넣기.

module.exports = (robot, ref) ->
  if ref?
    fb = new Firebase(FIREBASE_URL)
    fb = fb.child(ref)

    robot.logger.info ref

    if FIREBASE_SECRET?
      tokenGenerator = new FirebaseTokenGenerator FIREBASE_SECRET
      token = tokenGenerator.createToken({ "uid": "hubot", "hubot": true });
      fb.authWithCustomToken token, (error, authData) ->
        if error
          robot.logger.warning '인증실패', error

    return fb
  else
  robot.logger.warning "Ref is undefined"
