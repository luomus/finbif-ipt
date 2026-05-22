# docker manifest inspect gbif/ipt:latest -v | jq '.Descriptor.digest'
FROM gbif/ipt:latest@sha256:dc46a0cac297e2fbb651f197ce2dc27a4d923a45276719e5235fef73e5fd5d08 AS builder

FROM tomcat:11.0.20-jdk17-temurin

ENV IPT_DATA_DIR=/srv/ipt
ENV HOME=/home/user
ENV DEBIAN_FRONTEND=noninteractive

COPY --from=builder /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/ROOT
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY permissions.sh /usr/local/bin/permissions.sh
COPY backup.sh /usr/local/bin/backup.sh
COPY backup.r /home/user/backup.r
COPY init.r /home/user/init.r
COPY rclone.conf /home/user/.config/rclone/rclone.conf

RUN sed -i 's/maxParameterCount="1000"/maxParameterCount="10000"/g' /usr/local/tomcat/conf/server.xml

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      rclone \
      r-cran-plumber \
      rsync \
 && apt-get autoremove --purge -y \
 && apt-get autoclean -y \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /srv/ipt \
 && permissions.sh

VOLUME /srv/ipt

EXPOSE 8080

WORKDIR /home/user

ENTRYPOINT ["entrypoint.sh"]

CMD ["catalina.sh", "run"]
