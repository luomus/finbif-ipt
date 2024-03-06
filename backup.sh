#!/bin/bash

TIMESTAMP=$(date '+%Y%m%d%H%M%S')

curl -o backup-$TIMESTAMP-$BRANCH.zip $API_HOSTNAME:$API_PORT/backup

echo "Copying data to object store [$TIMESTAMP]\n"

rclone copy "/home/user/backup-$TIMESTAMP-$BRANCH.zip" "default:hy-7088-finbif-ipt"

echo "Removing local archive [$TIMESTAMP]\n"

rm /home/user/backup-$TIMESTAMP-$BRANCH.zip
