#!/bin/bash

chgrp -R 0 /srv/ipt /var/run /usr/local/tomcat
chmod -R g=u /srv/ipt /var/run /usr/local/tomcat /etc/passwd
