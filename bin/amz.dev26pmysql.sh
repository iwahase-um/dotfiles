#!/bin/sh
## connect to MySQL development env for 26p.jp
## development mysql replaced to aurora MySQL 2019/1/
COMMAND="mysql -ufurusato_user -prv_furusato -hdstgfurusato-cluster.cluster-cnk9ucbp77um.ap-northeast-1.rds.amazonaws.com furusato_development --auto-rehash"
SETPAGER="pager less -i -S"
expect -c "
set timeout 5
spawn env LANG=C /usr/bin/ssh app-furusato-dev 
#expect \"password:\"
#send \"${PW}\n\"
expect \"$\"
send \"${COMMAND}\n\"
expect \"MySQL\"
send \"${SETPAGER}\n\"
interact
exit 0
"
