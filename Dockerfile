FROM tmaczukin/debian
MAINTAINER Tomasz Maczukin "tomasz@maczukin.pl"

ENV TZ=UTC
ENTRYPOINT ["/usr/local/sbin/init"]
CMD ["bash"]

RUN apt-get update;                         \
    apt-get install -y locales tzdata sudo; \
    sed -i "s|%sudo.*|%sudo ALL=NOPASSWD: ALL|" /etc/sudoers

ARG RUBY_VERSION=2.1.8
COPY assets/setup /setup
RUN chmod 777 /setup; sync; /setup; rm /setup

COPY assets/init /usr/local/sbin/init
COPY assets/run_bash /usr/local/bin/run_bash
COPY assets/bin/* /home/git/bin/
RUN  chmod 755 /usr/local/sbin/init;          \
     chown root:root /usr/local/sbin/init;    \
     chmod 755 /usr/local/bin/run_bash;       \
     chown root:root /usr/local/bin/run_bash; \
     chmod +x /home/git/bin/*

USER git
WORKDIR /home/git/src
