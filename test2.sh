#!/bin/bash

source "$(pwd)/spinner.sh"

prompt_spinner "hi: "
echo "Now, we go on..."

# Prompt without text, just the spinner
prompt_spinner
echo "Now, we go on again..."
