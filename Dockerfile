# docker manifest inspect gbif/ipt:latest -v | jq '.Descriptor.digest'
FROM gbif/ipt:latest@sha256:90cd88a2e390175f22078edc320949e874b5ebd6f9735b86ed211bb0e25759ba AS builder

FROM tomcat:9.0-jdk17-temurin-focal

ENV IPT_DATA_DIR=/srv/ipt
ENV HOME=/home/user

COPY --from=builder /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/ROOT

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY permissions.sh /usr/local/bin/permissions.sh
COPY backup.sh /usr/local/bin/backup.sh
COPY backup-crontab /tmp/backup-crontab
COPY rclone.conf /home/user/.config/rclone/rclone.conf

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      cron \
      rclone \
      rsync \
 && apt-get autoremove --purge -y \
 && apt-get autoclean -y \
 && rm -rf /var/lib/apt/lists/*

RUN chmod +x /usr/local/bin/backup.sh && touch /tmp/cron.log

RUN crontab -u root /tmp/backup-crontab

RUN mkdir -p /srv/ipt \
 && permissions.sh

WORKDIR /home/user

ENTRYPOINT export -p | grep -v BRANCH > /tmp/env.sh && service cron start && entrypoint.sh

CMD ["catalina.sh", "run"]
