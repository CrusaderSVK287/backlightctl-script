#!/bin/bash

# set this to your desired gpu in /sys/class/backlight/
gpu=intel_backlight


path_prefix=/sys/class/backlight/
max_brightness=$(cat $path_prefix$gpu/max_brightness) # Get the max brightness 
percentage=$1                                         # Brightness set by user

usage() {
    echo "Usage: $0 <percentage>|help";
}

error() {
    echo "Error: $1" >&2
}

#
# Error checking
#

# Check if we got the max brightness
if [ "$max_brightness" == "" ]; then
    error "Failed to get max brightness";
    exit 1;
fi

# Check if user provided percentage, if not, display current percentage and exit
if [ "$percentage" == "" ]; then
    current_brightness=$(cat $path_prefix$gpu/brightness)
    echo $(printf "Current brightness of $gpu: %.0f%%" $(echo "scale=4; (100/$max_brightness)*$current_brightness" | bc));

    exit 0;
fi

# display help if user stated "help" parameter
if [ "$percentage" == "help" ]; then
    usage $@;
    exit 0;
fi

# Check if the percentage is valid
if ! [[ "$percentage" =~ ^[0-9]+$ ]] || [ "$percentage" -gt 100 ]; then
    error "Percentage cannot be less than 0 or more than 100";
    exit 1;
fi 

#
# Setting backlight value
#

# Calculate new brightness
new_brightness=$(printf "%.0f" $(echo "scale=2; ($max_brightness/100)*$percentage" | bc));

if [ "$new_brightness" -gt "$max_brightness" ]; then
    error "New brightness calculated as $new_brightness but max_brightness is $max_brightness";
    exit 1;
fi

# Write the new brightness
echo "$new_brightness" > $path_prefix$gpu/brightness

