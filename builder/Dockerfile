

FROM    alpine:edge

ADD     repositories /etc/apk/repositories
RUN     apk -U add alpine-sdk

RUN     mkdir -p /var/cache/distfiles && \
        adduser -D packager && \
        addgroup packager abuild && \
        chgrp abuild /var/cache/distfiles && \
        chmod g+w /var/cache/distfiles && \
        echo "packager    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ADD     setup.sh /home/packager/bin/setup.sh

ARG PACKAGER
RUN sed -i "s/#PACK.*/PACKAGER=\"$PACKAGER\"/g" /etc/abuild.conf
RUN sed -i "s/#MAINTAINER/MAINTAINER/g" /etc/abuild.conf

WORKDIR /work
USER    packager
