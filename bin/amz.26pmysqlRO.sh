#!/bin/sh
# connect to MySQL READ ONLY production env for 26p.jp

COMMAND="mysql -ufurusato_user -prv_furusato -hdfurusato-cluster.cluster-ro-cnk9ucbp77um.ap-northeast-1.rds.amazonaws.com furusato_production --auto-rehash"
SETPAGER="pager less -i -S"
expect -c "
set timeout 5
spawn env LANG=C /usr/bin/ssh batch-furusato 
#expect \"password:\"
#send \"${PW}\n\"
expect \"$\"
send \"${COMMAND}\n\"
expect \"MySQL\"
send \"${SETPAGER}\n\"
interact
exit 0
"
