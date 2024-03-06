#!/bin/bash

if [ "${BRANCH}" == "main" ]; then

echo "<script defer data-domain=\"$HOST\" src=\"https://plausible.io/js/script.js\"></script>" >> $CATALINA_HOME/webapps/ROOT/WEB-INF/pages/inc/header.ftl

fi

echo "user:x:$(id -u):0::/home/user:/sbin/nologin" >> /etc/passwd

"$@"
