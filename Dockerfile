FROM ruby:2.6-alpine
RUN mkdir -p /ufo
WORKDIR /ufo
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh build-base

COPY . ./

RUN bundle
RUN rake install
