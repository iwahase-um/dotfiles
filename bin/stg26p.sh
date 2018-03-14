#!/bin/sh

PW="PASSPHRASE"
COMMAND="cd ~/26pjp/DocumentRoot"
expect -c "
set timeout 5
spawn env LANG=C /usr/bin/ssh stg_furupure
expect \"Enter passphrase for key '/Users/iwahase_ryo/.ssh/id_rsa':\"
send \"${PW}\n\"
expect \"$\"
send \"${COMMAND}\n\"
expect \"$\"
interact
exit 0
"
