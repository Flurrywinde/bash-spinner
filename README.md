# spinner.sh

Display an awesome 'spinner' in bash scripts

## Usage

  1. source spinner.sh in your script

### For a long-running shell command:

start_spinner 'sleeping for 2 secs...'
sleep 2  # put your command here instead
stop_spinner $?

This will show "sleeping for 2 secs..." with the spinner to the right. When the command, in this case, `sleep 2` finishes, the spinner changes to a green [DONE] if it was successful, or a red [FAIL] if it wasn't.

### Put the spinner before the display message (allows for output during the spinning):

pre_spinner 'Testing intermittent output with pre spinner...'
sleep 2
echo a
sleep 1.5
echo b
sleep 1
echo c
stop_spinner $?

### Rather than report [DONE] (or [FAIL]), clear the spinner line and output something:

pre_spinner 'Searching for somefile...'
sleep 2
if [ -f somefile ]; then
	clear_spinner "File found.\n"
else
	clear_spinner "Error: file not found.\n"
fi

### Spinner as a prompt (waits until user hits a key to continue):

prompt_spinner "hi: "
echo "Now, we go on..."

### If user might hit ctrl-c:

# Used by prompt_spinner for when user hits ctrl-c. Exits like should but kills the spinner first.
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

## Demos

Run these for demos: `test.sh`, `test2.sh`
