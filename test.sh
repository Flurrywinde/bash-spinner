#!/bin/bash

source "$(pwd)/spinner.sh"

pre_spinner 'Testing intermittent output with pre spinner...'
sleep 2
echo a
sleep 1.5
echo b
sleep 1
echo c
stop_spinner $?

pre_spinner 'Testing intermittent output with pre spinner (clear at end, not just stop)...'
sleep 2
echo a
sleep 1.5
echo b
sleep 1
echo c
clear_spinner "done"

# test success
start_spinner 'sleeping for 2 secs...'
sleep 2
stop_spinner $?

# test fail
start_spinner 'copying non-existen files...'
# use sleep to give spinner time to fork and run
# because cp fails instantly
sleep 1
cp 'file1' 'file2' > /dev/null 2>&1
stop_spinner $?

