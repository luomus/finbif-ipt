# docker manifest inspect gbif/ipt:latest -v | jq '.[0].Descriptor.digest'
FROM gbif/ipt:latest@sha256:250c29b238d6a2397e1ea5c5fe824188f0ebd548b46e8dadffc7118a22ef40c7

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY permissions.sh /usr/local/bin/permissions.sh

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      cron \
      rclone \
 && apt-get autoremove --purge -y \
 && apt-get autoclean -y \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /srv/ipt \
 && permissions.sh

ENTRYPOINT ["entrypoint.sh"]

CMD ["catalina.sh", "run"]
