#!/bin/bash

TIMESTAMP=$(date '+%Y%m%d%H%M%S') 

tar -czf backup-$TIMESTAMP-$BRANCH.tar.gz -C / srv/ipt/

rclone copy "/backup-$TIMESTAMP-$BRANCH.tar.gz" "default:hy-7088-finbif-ipt"

rm backup-$TIMESTAMP-$BRANCH.tar.gz
