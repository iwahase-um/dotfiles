#!/bin/sh

PW="PASSPHRASE"
COMMAND="/usr/bin/mysql -h localhost -pPASSWORD -udbuser DBNAME--auto-rehash"
expect -c "
set timeout 5
spawn env LANG=C /usr/bin/ssh stg_furupure
expect \"Enter passphrase for key '/Users/iwahase_ryo/.ssh/id_rsa':\"
send \"${PW}\n\"
expect \"$\"
send \"${COMMAND}\n\"
expect \"MariaDB\"
interact
exit 0
"
