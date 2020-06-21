#!/bin/bash
#
# Alert Screen for task spooler
#
#
AUTOREFRESHTIME=1


export _hline="\033(0q\033(B"
export _vline="\033(0x\033(B"
export _blcorner="\033(0m\033(B"
export _brcorner="\033(0j\033(B"
export _ulcorner="\033(0l\033(B"
export _urcorner="\033(0k\033(B"
export _lseperator="\033(0t\033(B"
export _rseperator="\033(0u\033(B"

      

window (){

#window 1 row 1

window1_title="System Information"
window1_title_len=$(echo $window1_title|wc -c)

window2_title="Task Spooler Monitoring System"
window2_title_len=$(echo $window2_title|wc -c)

window1_start_col=1
window1_end_col=$(echo \($(tput cols)/2\)+0|bc)

echo -ne $_ulcorner;for i in $(seq $window1_start_col $window1_end_col ); do echo -ne $_hline; done;echo -ne $_urcorner

CURRENT_CUR_ROW_POS=1
CURRENT_CUR_COL_POS=$( echo \($window1_end_col - $window1_start_col - $window1_title_len\)/2|bc)

echo -e $_vline
tput cup $CURRENT_CUR_ROW_POS $CURRENT_CUR_COL_POS

echo -e $window1_title


#window 2 row 1
window2_start_col=$(echo \($(tput cols)/2\)+2|bc)
window2_end_col=$(echo "$(tput cols)-3"|bc)

echo -ne $_ulcorner;for i in $(seq $window2_start_col $window2_end_col ); do echo -ne $_hline; done;echo -e $_urcorner


CURRENT_CUR_ROW_POS=1
CURRENT_CUR_COL_POS=$( echo \($window1_end_col - $window1_start_col - $window1_title_len\)/2|bc)

echo -e $_vline
tput cup $CURRENT_CUR_ROW_POS $CURRENT_CUR_COL_POS

echo -e $window1_title

CURRENT_CUR_ROW_POS=1
CURRENT_CUR_COL_POS=$(echo \($(tput cols)/2\)+1|bc)

tput cup $CURRENT_CUR_ROW_POS $CURRENT_CUR_COL_POS
echo -e $_vline

#window2_start_col=1
#window2_end_col=$(echo \($(tput cols)/2\)|bc)


#echo -ne $_ulcorner
#for i in $(seq $(echo \($(tput cols)/2\)+6|bc) $(tput cols)); do echo -ne $_hline; done
#echo -e $_urcorner

#echo -ne $_vline
#tput cup 1 
#echo -ne "Task Spooler Monitoring System"
#tput cup 1 $(echo \($(tput cols)/2\)+1|bc)

#echo -ne $_vline

}





while true
    do
        tput clear
        window
        sleep $AUTOREFRESHTIME
        
        tput clear
        
        
done
