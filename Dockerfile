FROM debian:jessie
MAINTAINER Tomasz Maczukin "tomasz@maczukin.pl"

ENTRYPOINT ["/usr/local/sbin/init"]
CMD ["bash"]

ARG RUBY_VERSION=2.1.8
ARG PHANTOM_JS_VERSION=phantomjs-1.9.8-linux-x86_64
ARG SETUP_LOCALE=pl_PL.UTF-8
ARG TZ=Europe/Warsaw

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=$TZ

COPY assets/prepare /prepare
RUN  chmod 777 /prepare; sync; /prepare; rm /prepare

ENV LANG=$SETUP_LOCALE
ENV LC_ALL=$SETUP_LOCALE
ENV LANGUAGE=$SETUP_LOCALE

COPY assets/setup /setup
RUN  chmod 777 /setup; sync; /setup; rm /setup

COPY assets/init     /usr/local/sbin/init
COPY assets/run_bash /usr/local/bin/run_bash
COPY assets/bin/*    /home/git/bin/

RUN  chmod 755       /usr/local/sbin/init;    \
     chown root:root /usr/local/sbin/init;    \
     chmod 755       /usr/local/bin/run_bash; \
     chown root:root /usr/local/bin/run_bash; \
     chmod 755       /home/git/bin/*;         \
     chown git:git   /home/git/bin/*

USER git
WORKDIR /home/git/src
