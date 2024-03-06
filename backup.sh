#!/bin/bash

TIMESTAMP=$(date '+%Y%m%d%H%M%S') 

echo "Archiving data [$TIMESTAMP]\n"

tar -czf /tmp/backup-$TIMESTAMP-$BRANCH.tar.gz -C / srv/ipt/

echo "Copying data to object store [$TIMESTAMP]\n"

rclone copy "/tmp/backup-$TIMESTAMP-$BRANCH.tar.gz" "default:hy-7088-finbif-ipt"

echo "Removing local archive [$TIMESTAMP]\n"

rm /tmp/backup-$TIMESTAMP-$BRANCH.tar.gz
