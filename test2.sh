#!/bin/bash

source "$(pwd)/spinner.sh"

# Example of prompt with spinner
prompt_spinner "hi: "
echo "Now, we go on... Next, example of prompt without any text:"

# Prompt without text, just the spinner
prompt_spinner
echo "Now, we go on again..."

# Use the key the user pressed
prompt_spinner "Hit any key: "
userkey="$(prompt_spinner_return)"
if [ -z "$userkey" ]; then
	echo "You hit a whitespace key"
else
	echo "You hit: $userkey"
fi
