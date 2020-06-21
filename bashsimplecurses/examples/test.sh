#!/bin/bash
#
# Alert Screen for task spooler
#
#
AUTOREFRESHTIME=10


echo -e "\e[3J"
while true
    do
        tput clear
        
        echo -e "\e[3J"
        echo -e "\033(0lqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqk\033(B"
        echo -ne "\033(0x\033(B"
       # echo -e "\e[1;31m This is red text \e[0m"
        echo -e  "\e[1;31m                   Task Spooler                        \e[0m"
        echo -ne "\033(0x\033(B"
        printf "|                Monitoring System                      |\n"
        printf "+=======================================================+\n"
        printf " Date :: $(date +"%D %T")\n"
        printf "+-------------------------------------------------------+\n"
        abort=`tsp -l |grep finished|gawk '{ if ( $4 != "0" ) print; }'|wc -l`
        completed=`tsp -l |grep finished|gawk '{ if ( $4 == "0" ) print; }'|wc -l`
        running=`tsp -l |grep running|wc -l`
        queued=`tsp -l |grep queued|wc -l`

        printf " Aborted Jobs # $(tsp -l |grep finished|gawk '{ if ( $4 != "0" ) print; }'|wc -l)\n" 
        printf " Completed Jobs # $(tsp -l |grep finished|gawk '{ if ( $4 == "0" ) print; }'|wc -l)\n" 
        printf " Running Jobs # $(tsp -l |grep running|wc -l)\n" 
        printf " Queued Jobs # $(tsp -l |grep queued|wc -l) \n"
        printf ""
        
        tput cup 1 59
        echo -e "\033(0lqqqqqqqqqqqqqqqqqqqqqqqqqqqqqk\033(B"
        sleep $AUTOREFRESHTIME
        
        tput clear
        
        
    done
tput clear

