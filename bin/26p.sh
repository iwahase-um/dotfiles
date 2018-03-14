#!/bin/sh

PW="PASSWORD"
COMMAND="cd ~/26pjp/DocumentRoot"
expect -c "
set timeout 5
spawn env LANG=C /usr/bin/ssh furupure
expect \"password:\"
send \"${PW}\n\"
expect \"$\"
send \"${COMMAND}\n\"
expect \"$\"
interact
exit 0
"
