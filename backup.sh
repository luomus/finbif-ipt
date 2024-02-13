#!/bin/bash

RCLONE_TYPE=s3
RCLONE_PROVIDER=Other
RCLONE_ENDPOINT=a3s.fi
RCLONE_ACL=private
TIMESTAMP=$(date '+%Y%m%d%H%M%S') 

tar -czf "/home/user/backup-$TIMESTAMP-$BRANCH.tar.gz" "/srv/ipt"

rclone copy "/home/user/backup-$TIMESTAMP-$BRANCH.tar.gz" "default:hy-7088-finbif-ipt"

rm /home/user/backup-$TIMESTAMP-$BRANCH.tar.gz
