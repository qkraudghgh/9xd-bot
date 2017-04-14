FROM ubuntu:14.04

ENV BOTDIR /opt/bot

RUN apt-get update && \
  apt-get install -y wget && \
  wget -q -O - https://deb.nodesource.com/setup_6.x | sudo bash - && \
  apt-get install -y git build-essential nodejs && \
  rm -rf /var/lib/apt/lists/* && \
  git clone --depth=1 https://github.com/qkraudghgh/9xd-bot.git ${BOTDIR}

WORKDIR ${BOTDIR}

RUN npm install

ENV HUBOT_PORT 8080
ENV HUBOT_ADAPTER slack
ENV HUBOT_NAME 9xd
ENV HUBOT_SLACK_TEAM 9xd
ENV HUBOT_SLACK_BOTNAME ${HUBOT_NAME}
ENV PORT ${HUBOT_PORT}

EXPOSE ${HUBOT_PORT}

CMD bin/hubot