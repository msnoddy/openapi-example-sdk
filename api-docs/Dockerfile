FROM ruby:2.6.5-alpine

RUN apk update \
  && apk add \
    coreutils \
    g++ \
    git \
    make \
    nodejs

WORKDIR /slate

RUN git clone https://github.com/slatedocs/slate .

RUN gem install bundler \
  && bundle update --bundler \
  && bundle install

RUN mkdir /slate/build

VOLUME /slate
VOLUME /slate/build

CMD bundle exec middleman build --clean
