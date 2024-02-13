#!/bin/bash

chgrp -R 0 /srv/ipt /var/run /usr/local/tomcat /usr/sbin/cron /home/user
chmod -R g=u /srv/ipt /var/run /usr/local/tomcat /usr/sbin/cron /home/user /etc/passwd
chmod gu+rw /var/run
chmod gu+s /usr/sbin/cron
