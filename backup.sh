#!/bin/bash

RCLONE_TYPE=s3
RCLONE_PROVIDER=Other
RCLONE_ENDPOINT=a3s.fi
RCLONE_ACL=private
TIMESTAMP=$(date '+%Y%m%d%H%M%S') 

tar -czf "/tmp/backup-$TIMESTAMP.tar.gz" "/srv/ipt"

rclone copy "/tmp/backup-$TIMESTAMP.tar.gz" "default:hy-7088-finbif-ipt"
