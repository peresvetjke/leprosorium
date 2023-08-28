FROM libertas.art.rambler.ru/ruby:3.0.6-alpine3.16

RUN apk update && apk upgrade \
    && apk add build-base bash curl git tzdata nodejs npm yarn python3 py3-pip libstdc++
RUN pip3 install pymorphy3

RUN addgroup -S -g 1001 leprosorium && \
    adduser -S -D -u 1001 -G leprosorium leprosorium && \
    mkdir /app && \
    chown -R leprosorium:leprosorium /app

RUN npm install -g n && n 16.13.0

USER leprosorium:leprosorium

WORKDIR /app

COPY Gemfile Gemfile.lock ./
ADD --chown=leprosorium:leprosorium Gemfile Gemfile.lock ./
RUN gem install bundler & bundle install

COPY . .
ADD --chown=leprosorium:leprosorium . .

RUN yarn install --check-files
RUN rails webpacker:install

ENTRYPOINT [ "/app/entrypoint.sh" ]
