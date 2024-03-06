#!/bin/bash

chgrp -R 0 /srv/ipt /var/run /usr/local/tomcat /home/user
chmod -R g=u /srv/ipt /var/run /usr/local/tomcat /home/user /etc/passwd
chmod gu+rw /var/run