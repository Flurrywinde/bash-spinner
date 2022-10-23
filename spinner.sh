#!/bin/bash

# Author: Tasos Latsas

# spinner.sh
#
# Display an awesome 'spinner' while running your long shell commands
#
# Do *NOT* call _spinner function directly.
# Use {start,stop}_spinner wrapper functions

# usage:
#   1. source this script in your's
#   2. start the spinner:
#       start_spinner [display-message-here]
#   3. run your command
#   4. stop the spinner:
#       stop_spinner [your command's exit status]
#		In other words: stop_spinner $?
#
# Also see: test.sh

# Kanon added: prompt_spinner and clear_spinner, but these are defunct now. Just use the prompt_spinner function standalone in kav. Oh wait. Added clear_spinner back into kav for arch news.

# Also added pre type spinner and tried to accommodate command output, but requires output to be saved in a string, then echoed. See: `updates`


function _spinner() {
    # $1 start/stop
    #
    # on start: $2 display message
    # on stop : $2 process exit status
    #           $3 spinner function pid (supplied from stop_spinner)

    local on_success="DONE"
    local on_fail="FAIL"
    local white="\e[1;37m"
    local green="\e[1;32m"
    local red="\e[1;31m"
    local nc="\e[0m"

    case $1 in
        start_pre)
			# Save cursor position
			echo -en '\033[s'
            # start spinner
            i=1
            sp='\|/-'
            delay=${SPINNER_DELAY:-0.15}

            while :
            do
				echo -en '\033[u'  # Restore cursor position
                printf "\e[1G${sp:i++%${#sp}:1} $2"
                sleep $delay
            done
            ;;
        start)
            # calculate the column where spinner and status msg will be displayed
            let column=$(tput cols)-${#2}-8
            # display message and position the cursor in $column column
            echo -ne ${2}
            printf "%${column}s"

            # start spinner
            i=1
            sp='\|/-'
            delay=${SPINNER_DELAY:-0.15}

            while :
            do
                printf "\b${sp:i++%${#sp}:1}"
                sleep $delay
            done
            ;;
        prompt)
            # display prompt
            echo -ne "${2} "  # space after because spinner does an initial \b

            # start spinner
            i=1
            sp='\|/-'
            delay=${SPINNER_DELAY:-0.15}

            while :
            do
                printf "\b${sp:i++%${#sp}:1}"
                sleep $delay
            done
            ;;
        stop)
            if [[ -z ${3} ]]; then
                echo "spinner is not running.."
                exit 1
            fi

            kill $3 > /dev/null 2>&1

            # inform the user uppon success or failure
            echo -en "\b["
            if [[ $2 -eq 0 ]]; then
                echo -en "${green}${on_success}${nc}"
            else
                echo -en "${red}${on_fail}${nc}"
            fi
            echo -e "]"
            ;;
        clear)
            if [[ -z ${3} ]]; then
                echo "spinner is not running.."
                exit 1
            fi

            kill $3 > /dev/null 2>&1

			# Erase prompt (2K = clear whole line, 1G = goto column 1)
            echo -en "\e[2K\e[1G$2"
            ;;
        *)
            echo "invalid argument, try {start/stop}"
            exit 1
            ;;
    esac
}

function pre_spinner {
    # $1 : msg to display
    _spinner "start_pre" "${1}" &
    # set global spinner pid
    _sp_pid=$!
    echo "$_sp_pid" > /tmp/spin.pid
    disown
}

function start_spinner {
    # $1 : msg to display
    _spinner "start" "${1}" &
    # set global spinner pid
    _sp_pid=$!
    disown
}

function stop_spinner {
    # $1 : command exit status
    _spinner "stop" $1 $_sp_pid
    unset _sp_pid
}

function prompt_spinner {
    # $1 : msg to display
    _spinner "prompt" "${1}" &
    # set global spinner pid
    _sp_pid=$!
    disown
	read -n1 -rs
	clear_spinner $?
}

function clear_spinner {
    # $1 : msg to display
    _spinner "clear" "$1" $_sp_pid
    unset _sp_pid
}
