#!/bin/bash

TIMESTAMP=$(date '+%Y%m%d%H%M%S') 

tar -czf /home/user/backup-$TIMESTAMP-$BRANCH.tar.gz -C / srv/ipt/

rclone copy "/home/user/backup-$TIMESTAMP-$BRANCH.tar.gz" "default:hy-7088-finbif-ipt"

rm /home/user/backup-$TIMESTAMP-$BRANCH.tar.gz
