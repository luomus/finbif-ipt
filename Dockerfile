# docker manifest inspect gbif/ipt:latest -v | jq '.Descriptor.digest'
FROM gbif/ipt:latest@sha256:26e2aeb07a19715a733e2c553581b18b291fd7edbc63e4391b893d1dfcb0feb8

ENV IPT_DATA_DIR=/srv/ipt
ENV HOME=/home/user
ENV DEBIAN_FRONTEND=noninteractive

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
