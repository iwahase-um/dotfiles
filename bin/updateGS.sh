#!/bin/sh
# this script runs script on 26p.jp server to summerize wp order
# and down the csv file to local pc.
# updates data on Google spreadsheets 

PLCMD='/usr/bin/perl /home/kusanagi/JKZ/26pjp_growth_hack.pl'
updategs="export2GS" 

expect -c "
set timeout 25 
spawn env LANG=C /usr/bin/ssh furupure
expect \"$ \"
send \"${PLCMD}\n\"
expect \"$ \"
send \"exit\n\"
exit 0
"

sleep 2
scpcmd="scp furupure:/home/kusanagi/JKZ/26pjp_growth_hack.pl.csv /Users/iwahase_ryo/localdev/iwahase-um/data"
eval $scpcmd
sleep 1

eval $updategs

exit 0;

