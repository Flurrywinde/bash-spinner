#!/bin/bash

# Kanon added: prompt_spinner and clear_spinner.

# Also added pre_spinner and tried to accommodate command output, but requires output to be saved in a string, then echoed. See: `updates`. 10/22/22-Not sure what this means anymore.

# 10/20/23-Added other spinners (from https://github.com/SteveClement/bash-spinners plus my creations). TODO: multi-width spinners, user-selectable instead of random

# Prepare spinner for possible interruption
_sp_pid=''
trap "killspin" SIGINT

spinsel() {
	spinlist=(
		←↖↑↗→↘↓↙ arrows .oO@* .oO°Oo.  🔹🔷🔵🔵🔷 ⠁⠂⠄⠂ ▖▘▝▗ ▌▀▐▄ 🌲🎄 ◡◠ ◐◓◑◒ ◴◷◶◵ ◔◑◕⬤ ○oOo o◔◑◕⬤◕◑◔ ●⬤ 🕛🕐🕑🕒🕓🕔🕕🕖🕗🕘🕙🕚 ⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏ ⢄⢂⢁⡁⡈⡐⡠ ⠁⠂⠄⡀⢀⠠⠐⠈ ⢀⠀⡀⠀⠄⠀⢂⠀⡂⠀⠅⠀⢃⠀⡃⠀⠍⠀⢋⠀⡋⠀⠍⠁⢋⠁⡋⠁⠍⠉⠋⠉⠋⠉⠉⠙⠉⠙⠉⠩⠈⢙⠈⡙⢈⠩⡀⢙⠄⡙⢂⠩⡂⢘⠅⡘⢃⠨⡃⢐⠍⡐⢋⠠⡋⢀⠍⡁⢋⠁⡋⠁⠍⠉⠋⠉⠋⠉⠉⠙⠉⠙⠉⠩⠈⢙⠈⡙⠈⠩⠀⢙⠀⡙⠀⠩⠀⢘⠀⡘⠀⠨⠀⢐⠀⡐⠀⠠⠀⢀⠀⡀ ⣼⣹⢻⠿⡟⣏⣧⣶ ⣾⣽⣻⢿⡿⣟⣯⣷ ⠋⠙⠚⠞⠖⠦⠴⠲⠳⠓ ⠄⠆⠇⠋⠙⠸⠰⠠⠰⠸⠙⠋⠇⠆ ⠋⠙⠚⠒⠂⠂⠒⠲⠴⠦⠖⠒⠐⠐⠒⠓⠋ ⠁⠉⠙⠚⠒⠂⠂⠒⠲⠴⠤⠄⠄⠤⠴⠲⠒⠂⠂⠒⠚⠙⠉⠁ ⠈⠉⠋⠓⠒⠐⠐⠒⠖⠦⠤⠠⠠⠤⠦⠖⠒⠐⠐⠒⠓⠋⠉⠈ ⠁⠁⠉⠙⠚⠒⠂⠂⠒⠲⠴⠤⠄⠄⠤⠠⠠⠤⠦⠖⠒⠐⠐⠒⠓⠋⠉⠈⠈ ⠀⠁⠂⠃⠄⠅⠆⠇⡀⡁⡂⡃⡄⡅⡆⡇⠈⠉⠊⠋⠌⠍⠎⠏⡈⡉⡊⡋⡌⡍⡎⡏⠐⠑⠒⠓⠔⠕⠖⠗⡐⡑⡒⡓⡔⡕⡖⡗⠘⠙⠚⠛⠜⠝⠞⠟⡘⡙⡚⡛⡜⡝⡞⡟⠠⠡⠢⠣⠤⠥⠦⠧⡠⡡⡢⡣⡤⡥⡦⡧⠨⠩⠪⠫⠬⠭⠮⠯⡨⡩⡪⡫⡬⡭⡮⡯⠰⠱⠲⠳⠴⠵⠶⠷⡰⡱⡲⡳⡴⡵⡶⡷⠸⠹⠺⠻⠼⠽⠾⠿⡸⡹⡺⡻⡼⡽⡾⡿⢀⢁⢂⢃⢄⢅⢆⢇⣀⣁⣂⣃⣄⣅⣆⣇⢈⢉⢊⢋⢌⢍⢎⢏⣈⣉⣊⣋⣌⣍⣎⣏⢐⢑⢒⢓⢔⢕⢖⢗⣐⣑⣒⣓⣔⣕⣖⣗⢘⢙⢚⢛⢜⢝⢞⢟⣘⣙⣚⣛⣜⣝⣞⣟⢠⢡⢢⢣⢤⢥⢦⢧⣠⣡⣢⣣⣤⣥⣦⣧⢨⢩⢪⢫⢬⢭⢮⢯⣨⣩⣪⣫⣬⣭⣮⣯⢰⢱⢲⢳⢴⢵⢶⢷⣰⣱⣲⣳⣴⣵⣶⣷⢸⢹⢺⢻⢼⢽⢾⢿⣸⣹⣺⣻⣼⣽⣾⣿ ⢹⢺⢼⣸⣇⡧⡗⡏ dqpb 🌍🌎🌏 🤘🤟🖖✋🤚👆 "___-\`\`'´-___" '،\′´‾⸌⸊|⁎⁕෴⁓' ▏▎▍▌▋▊▉▊▋▌▍▎ ▁▃▄▅▆▇▆▅▄▃ '💛💙💜💚❤️' -=≡ 　-=≡=- -\\\|/ ⠂-–—–- 😐😐😮😮😦😦😧😧🤯💥✨　　　 🙈🙈🙉🙊 🌑🌒🌓🌔🌕🌖🌗🌘 ▓▒░ 🔸🔶🟠🟠🔶🔹🔷🔵🔵🔷 🔸🔶🟠🟠🔶 ┤┘┴└├┌┬┐ 🚶🏃 ⠁⠂⠄⡀⡈⡐⡠⣀⣁⣂⣄⣌⣔⣤⣥⣦⣮⣶⣷⣿⡿⠿⢟⠟⡛⠛⠫⢋⠋⠍⡉⠉⠑⠡⢁ 😄😝 🔈🔉🔊🔉 ◰◳◲◱ ╫╪ ✶✸✹✺✹✷ +x* +*x* ㊂㊀㊁ ☗☖ =*- □■ ■□▪▫ ▮▯ ⦾⦿ ◍◌ ◉◎ ◢◣◤◥ weather)  # ☱☲☴ ◜◝◞◟▫▪ ⦿⊙● ⊶⊷ ⧇⧆ 
	#echo ${spinlist[1]}  # Strange. Index 0 and 1 same thing as if light blue glyph arrows are being converted to regular
	if [ $# -eq 0 ]; then
		sel=$(( $RANDOM % ${#spinlist[@]} ))  # Interesting: random item from bash array ${spinlist[ $RANDOM % ${#spinlist[@]} ]}
	else
		sel="$1"  # Should error check $1. Ignores other parms.
	fi

	# go thru one by one
	carousel=0
	if [ $carousel -eq 1 ]; then
		if [ -f /tmp/spinsel ]; then
			sel=$(cat /tmp/spinsel)
			if [ $((sel+1)) -ge ${#spinlist[@]} ]; then
				echo 0 > /tmp/spinsel
			else
				echo $((sel + 1)) > /tmp/spinsel
			fi
		else
			echo 0 > /tmp/spinsel
		fi
	fi

	echo "${spinlist[$sel]}"
}

function _spinner() {
	# Do not call this function directly.
	#
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
			sp=$(spinsel)
            delay=${SPINNER_DELAY:-0.15}

            while :
            do
				echo -en '\033[u'  # Restore cursor position
				printf "\e[1G${sp:i++%${#sp}:1} $2"  #\e[1G = CSI n G = cursor horizontal absolute, aka Goto column n
				#printf "\r${sp:i++%${#sp}:1} $2"  # maybe try this? Another option anyway.
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
			sp=$(spinsel)
            delay=${SPINNER_DELAY:-0.15}

            while :
            do
                printf "\b${sp:i++%${#sp}:1}"
                sleep $delay
            done
            ;;
        prompt)
			# 10/22/22-defunct. Just making standalone function for a prompt spinner.
            # display prompt
            echo -ne "${2} "  # space after because spinner does an initial \b

            # start spinner
            i=1
			sp=$(spinsel)
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

function prompt_spinner_donotuse {
	# TODO: see if can get this to work. Currently mostly works but outputs a '0' when key is pressed.
    # $1 : msg to display
    _spinner "prompt" "${1}" &
    # set global spinner pid
    _sp_pid=$!
    disown
	read -n1 -rs
	clear_spinner $?
}

function prompt_spinner {
    # $1 : msg to display

	# display prompt
	{
		tput civis
		sp=$(spinsel)
		# special weather case
		if [ "$sp" = 'weather' ]; then
			sp=(☀️ ☀️ ☀️ 🌤️ ⛅ 🌥️ ☁️ ☁️ 🌧️ 🌨️ 🌧️ 🌨️ 🌧️ 🌨️ ⛈️ 🌨️ 🌨️ ☁️ 🌥️ ⛅ 🌤️ ☀️ )
			isarray=1
		elif [ "$sp" = 'arrows' ]; then
			sp=(⬆️ ↗️ ➡️ ↘️ ⬇️ ↙️ ⬅️ ↖️ )
			isarray=1
		else
			isarray=0
		fi

		echo -ne "${1} "  # space after because spinner does an initial \b

		# start spinner
		if [ $isarray -eq 1 ]; then
			i=0
		else
			i=1
		fi
		delay=${SPINNER_DELAY:-0.15}  # Uses shell var if set, else .15

		backspaces=''
		echo '' > /tmp/o
		while :
		do
			if [ $isarray -eq 1 ]; then
				c=${sp[i++]}
				if [ $i -ge ${#sp[@]} ]; then
					i=0
				fi
			else
				c=${sp:i++%${#sp}:1}
				if [ "$c" = "❤" ] || [ "$c" = "☀" ]; then
						# The red heart is 2 characters but 2nd is ''. -z didn't work, as something is there, just not visible. "${#c}" also no go.
						#The "character" "❤️" you are using is not actually a single character. It is composed of two Unicode characters, "❤"(U+2764) and a modifying U+FE0F, "VARIATION SELECTOR-16" which gives the red style of the emoji.
						#
						#You can verify the encoded form of a string by typing echo -n ❤️ | hexdump -C in WSL console, which should output
						#
						#00000000  e2 9d a4 ef b8 8f                                 |......|
						#00000006 
					c+=${sp:i++%${#sp}:1}
				fi
			fi
			printf "$backspaces"
			echo "$c" > /tmp/spinner_c.txt
			#if $(file /tmp/spinner_c.txt | grep Unicode > /dev/null 2>&1); then  # will say ASCII text if non-glyph. Darn, can't distinguish between color and non-color. Interesting: how to detect unicode vs ascii. See: https://unix.stackexchange.com/questions/474709/how-to-grep-for-unicode-in-a-bash-script
			chardetect --minimal /tmp/spinner_c.txt >> /tmp/o
			#if $(chardetect --minimal /tmp/spinner_c.txt | grep 'None' > /dev/null 2>&1) || [ "$c" = "❤️" ] || [ "$c" = "✋" ] || [ "$c" = "💥" ] || [ "$c" = "✨" ] || [ "$c" = "　" ]; then  # will say UTF-8 for b/w glyph and ascii for non-glyph. ✋ is Windows-1252, but can't consider this a /b/b because ↖↑↗→↘↓↙ are also (← is utf-8). Dunno what "blank" is, but it's part of the face explosion. See: https://stackoverflow.com/questions/10373258/check-if-file-contains-multibyte-character
			if $(chardetect --minimal /tmp/spinner_c.txt | grep 'None' > /dev/null 2>&1) || [[ "$c" =~ [❤️✋💥✨　㊂㊀㊁⛅] ]]; then  # will say UTF-8 for b/w glyph and ascii for non-glyph. ✋ is Windows-1252, but can't consider this a /b/b because ↖↑↗→↘↓↙ are also (← is utf-8). Dunno what "blank" is, but it's part of the face explosion. See: https://stackoverflow.com/questions/10373258/check-if-file-contains-multibyte-character
				backspaces=$'\b\b'
				echo -e "\t'$c' BB" >> /tmp/o
			else
				backspaces=$'\b'
				echo -e "\t'$c' b" >> /tmp/o
			fi
			printf "$c"
			#printf "\e[2D${sp:i++%${#sp}:1}"  # CSI (aka ESC [ ) n D = cursor back. Glyphs need 2D or \b\b
			sleep $delay
		done
	} &
    # set global spinner pid
    _sp_pid=$!
    disown
	read -n1 -rs
	tput cvvis
	kill $_sp_pid > /dev/null 2>&1

	# Erase prompt
	echo -en "\e[0G\e[2K"

	# Use /tmp/prompt_spinner_return_value.txt as return value (used by kav)
	echo "$REPLY" > /tmp/prompt_spinner_return_value.txt
}

prompt_spinner_return() {
	reply="$(head -n 1 /tmp/prompt_spinner_return_value.txt)"
	reply="${reply//[ $'\t'$'\n']}"
	echo "$reply"
}

function clear_spinner {
    # $1 : msg to display
    _spinner "clear" "$1" $_sp_pid
    unset _sp_pid
}

# Used by prompt_spinner for when user hits ctrl-c. Exits like should but kills the spinner first. (Without this, ctrl-c will leave a spinner behind even when back in shell.)
killspin() {
	if [ ! -z "$_sp_pid" ]; then
		kill $_sp_pid > /dev/null 2>&1
		#echo "$_sp_pid killed"
		tput cvvis
	else
		echo "No pid: $_sp_pid"
	fi
	exit 2
}
