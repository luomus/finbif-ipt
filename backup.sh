#!/bin/bash

TIMESTAMP=$(date '+%Y%m%d%H%M%S') 

echo "Archiving data [$TIMESTAMP]\n"

tar -czf /home/user/backup-$TIMESTAMP-$BRANCH.tar.gz -C / srv/ipt/

echo "Copying data to object store [$TIMESTAMP]\n"

rclone copy "/home/user/backup-$TIMESTAMP-$BRANCH.tar.gz" "default:hy-7088-finbif-ipt"

echo "Removing local archive [$TIMESTAMP]\n"

rm /home/user/backup-$TIMESTAMP-$BRANCH.tar.gz
