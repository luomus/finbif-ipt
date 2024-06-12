#!/bin/bash

i="all"
f="template.yml"
e=".env"

while getopts ":f:e:i::" flag; do
case $flag in
f) f=${OPTARG} ;;
e) e=${OPTARG} ;;
i) i=${OPTARG} ;;
esac
done

set -a

source ./$e

set +a

BRANCH=$(git symbolic-ref --short -q HEAD)

if [ "$BRANCH" != "main" ]; then

HOST=$HOST_DEV
STORAGE=$STORAGE_DEV

fi

if [ $i = "volume" ]; then

ITEM=".items[0]"

elif [ $i = "secrets" ]; then

ITEM=".items[1]"

elif [ $i = "deploy" ]; then

ITEM=".items[2]"

elif [ $i = "service-app" ]; then

ITEM=".items[3]"

elif [ $i = "service-api" ]; then

ITEM=".items[4]"

elif [ $i = "route" ]; then

ITEM=".items[5]"

elif [ $i = "job" ]; then

ITEM=".items[6]"

elif [ $i = "all" ]; then

ITEM=""

else

echo "Object not found"
exit 1

fi

RCLONE_ACCESS_KEY_ID=$(echo -n $RCLONE_ACCESS_KEY_ID | base64)
RCLONE_SECRET_ACCESS_KEY=$(echo -n $RCLONE_SECRET_ACCESS_KEY | base64)

echo "# $(oc project finbif-ipt)"

oc process -f $f \
-p BRANCH=$BRANCH \
-p HOST=$HOST \
-p STORAGE=$STORAGE \
-p RCLONE_ACCESS_KEY_ID=$RCLONE_ACCESS_KEY_ID \
-p RCLONE_SECRET_ACCESS_KEY=$RCLONE_SECRET_ACCESS_KEY \
| jq $ITEM
