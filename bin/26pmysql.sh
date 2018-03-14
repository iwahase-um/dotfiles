#!/bin/sh

PW="PASSWORD"
COMMAND="/usr/bin/mysql -h localhost -pPASSWORD -udbuser DBNAME--auto-rehash"
expect -c "
set timeout 5
spawn env LANG=C /usr/bin/ssh furupure
expect \"password:\"
send \"${PW}\n\"
expect \"$\"
send \"${COMMAND}\n\"
expect \"MariaDB\"
interact
exit 0
"
