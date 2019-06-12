FROM debian:buster-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/root

# RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
	# rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update && \
	apt-get -y --no-install-recommends install \
		apt-utils ca-certificates sudo rsync

RUN apt-get update && \
	apt-get -y --no-install-recommends install \
		python3

RUN apt-get update && \
	apt-get -y --no-install-recommends install \
		php-cli composer

RUN apt-get update && \
	apt-get -y --no-install-recommends install \
		nodejs yarnpkg

RUN yarnpkg add node-sass

RUN ln -s /root/node_modules/.bin /node

RUN apt-get update && \
	apt-get -y --no-install-recommends install \
		openssh-client

COPY ./bin/* /usr/local/bin/
