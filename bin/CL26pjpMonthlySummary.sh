#!/bin/sh

## client script to execute remote script @kusanagi
# usage : CL26pjpMonthlySummary -m '%Y%m01'

while getopts m: ARG
do
    case $ARG in
             m) targetmonth=$OPTARG
              ;;
    esac
done

remotehomedir='/home/kusanagi'
remotescript='26pjpMonthlySummary.sh'
execcmd=$(printf "%s/JKZ/%s -m '%s'" $remotehomedir $remotescript $targetmonth)
echo $execcmd

expect -c "
set timeout 15
spawn env LANG=C /usr/bin/ssh furupure
expect \"$ \"
send \"${execcmd}\n\"
expect \"$ \"
send \"exit\n\"
exit 0
"

outputdir=$(printf "%s/data/monthly/Order%s" $remotehomedir ${targetmonth:0:6})
outputfile=$(printf "%s.zip" $outputdir)

scpcmd=$(printf "scp furupure:%s /Users/iwahase_ryo/docs/dev/26pjp/datas/monthly_csv" $outputfile)
eval $scpcmd

#procedures=(
#"proc26pjpOrderMonthlySummary"
#"proc26pjpProductOrderMonthlyRanking"
#"proc26pjpPriceOrderMonthlyRanking"
#)
#for i in 0 1 2 
#do
#    outputfile="${outputdir}/${procedures[$i]}.$targetmonth.csv"
#    scpcmd=$(printf "scp furupure:%s /Users/iwahase_ryo/docs/dev/26pjp/datas/monthly_csv" $outputfile)
#    eval $scpcmd
#    sleep 1
#done

