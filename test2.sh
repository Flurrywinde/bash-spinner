#!/bin/bash

source "$(pwd)/spinner.sh"

# Used by prompt_spinner for when user hits ctrl-c. Exits like should but kills the spinner first. (Without this, ctrl-c will leave a spinner behind even when back in shell.)
killspin() {
	if [ ! -z "$_sp_pid" ]; then
		kill $_sp_pid > /dev/null 2>&1
		#echo "$_sp_pid killed"
	else
		echo "No pid: $_sp_pid"
	fi
	exit
}

# Prepare spinner for possible interruption
_sp_pid=''
trap "killspin" SIGINT

# Example of prompt with spinner
prompt_spinner "hi: "
echo "Now, we go on..."

# Prompt without text, just the spinner
prompt_spinner
echo "Now, we go on again..."
