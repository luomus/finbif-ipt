# docker manifest inspect gbif/ipt:latest -v | jq '.Descriptor.digest'
FROM gbif/ipt:latest@sha256:cac31d56afd36328da2e9b171fb81959041b1ecefb14ef88c9c6349cfddc2570 AS builder

FROM tomcat:9.0-jdk17-temurin-focal

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

WORKDIR /home/user

ENTRYPOINT ["entrypoint.sh"]

CMD ["catalina.sh", "run"]
