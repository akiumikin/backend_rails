FROM ruby:3.1.2

ENV LANG C.UTF-8
ENV WORKSPACE=/var/www/app/

RUN apt update && \
    apt install -y vim less && \
    apt list installed && \
    apt clean

WORKDIR $WORKSPACE
