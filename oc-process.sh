#!/bin/bash

i="all"

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

elif [ $i = "image" ]; then

ITEM=".items[1]"

elif [ $i = "build" ]; then

ITEM=".items[2]"

elif [ $i = "deploy" ]; then

ITEM=".items[3]"

elif [ $i = "service" ]; then

ITEM=".items[4]"

elif [ $i = "route" ]; then

ITEM=".items[5]"

else

ITEM=""

fi

oc process -f $f \
-p HOST=$HOST \
-p STORAGE=$STORAGE \
| jq $ITEM
