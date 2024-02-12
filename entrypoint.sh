#!/bin/bash

echo "user:x:$(id -u):0::/home/user:/sbin/nologin" >> /etc/passwd

service cron start

"$@"
