FROM debian:buster-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/root

# RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
	# rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update && \
	apt-get -y --no-install-recommends install \
		apt-utils ca-certificates gnupg sudo \
		rsync curl git unzip \
		openssh-client && \
	apt-get clean && \
	apt-get purge -y --auto-remove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && \
	apt-get -y --no-install-recommends install \
		python3 \
		php-cli php-xml php-curl php-zip composer \
		nodejs yarn && \
	apt-get clean && \
	apt-get purge -y --auto-remove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV COMPOSER_ALLOW_SUPERUSER=1 \
	PATH="/root/.composer/vendor/bin::${PATH}"

RUN yarn global add node-sass && \
	yarn cache clean && \
	composer global require phpunit/phpunit && \
	composer clear-cache

COPY .bashrc /root/.bashrc
COPY ./bin/* /usr/local/bin/
