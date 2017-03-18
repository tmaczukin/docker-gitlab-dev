FROM debian:jessie
MAINTAINER Tomasz Maczukin "tomasz@maczukin.pl"

ENTRYPOINT ["/usr/local/sbin/init"]
CMD ["bash"]

ARG RUBY_VERSION=2.3.3
ARG SETUP_LOCALE=en_US.UTF-8
ARG TZ=Europe/Warsaw

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=$TZ

RUN mkdir /setup

COPY assets/prepare /setup/prepare
RUN  chmod 777 /setup/prepare; sync; /setup/prepare

ENV LANG=$SETUP_LOCALE
ENV LC_ALL=$SETUP_LOCALE
ENV LANGUAGE=$SETUP_LOCALE

COPY assets/setup /setup/setup
RUN  chmod 777 /setup/setup; sync; /setup/setup

COPY assets/init     /usr/local/sbin/init
COPY assets/run_bash /usr/local/bin/run_bash

RUN  chmod 755       /usr/local/sbin/init;    \
     chown root:root /usr/local/sbin/init;    \
     chmod 755       /usr/local/bin/run_bash; \
     chown root:root /usr/local/bin/run_bash

USER git
WORKDIR /home/git/src
