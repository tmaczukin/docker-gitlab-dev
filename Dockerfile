FROM tmaczukin/debian
MAINTAINER Tomasz Maczukin "tomasz@maczukin.pl"

ENV LANG     pl_PL.UTF-8
ENV LANGUAGE pl_PL.UTF-8
ENV LC_ALL   pl_PL.UTF-8
ENV TZ       Europe/Warsaw
RUN apt-get install -y locales tzdata sudo;                   \
    sed -i "s/^# pl_PL.UTF-8/pl_PL.UTF-8/" /etc/locale.gen;   \
    sed -i "s|%sudo.*|%sudo ALL=NOPASSWD: ALL|" /etc/sudoers; \
    locale-gen

COPY assets/setup /setup
RUN chmod 777 /setup; sync; /setup; rm /setup

COPY assets/init /usr/local/sbin/init
RUN chmod 755 /usr/local/sbin/init; chown root:root /usr/local/sbin/init

COPY assets/run_bash /usr/local/bin/run_bash
RUN chmod 755 /usr/local/bin/run_bash; chown root:root /usr/local/bin/run_bash

COPY assets/bin/* /home/dev/bin/
RUN chmod +x /home/dev/*

USER dev
WORKDIR /home/dev

ENTRYPOINT ["/usr/local/sbin/init"]
CMD ["bash"]
