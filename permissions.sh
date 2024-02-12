#!/bin/bash

chgrp -R 0 /srv/ipt
chmod -R g=u /srv/ipt /etc/passwd
