#!/bin/bash

source $(dirname $0)/../simple_curses.sh
main(){
    window "Test 1" "red" "33%"
        append "First simple window"
        addsep
        append_command "cal"
        endwin

        window "Tree files" "gree" "33%"
        if [[ -x `which tree 2> /dev/null` ]]; then
            append_command "tree -L 2 -C -A ./"
        else
            append "Please install tree command"
        fi
    endwin
    #tput clear
}
main_loop
