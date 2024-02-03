# backlightctl-script
Simple script to change brightness level without dedicated tools

Be sure to change this value to the gpu you want to use.
Look inside /sys/class/backlight/ directory, for a folder contaning 
files `max_brightness` and `brightness`.

```
# set this to your desired gpu in /sys/class/backlight/
gpu=amdgpu_bl2
```
The full path should look like this:
/sys/class/backlight/\<your-gpu-path\>/max_brightness

### Dependencies
* bc - basic calculator

### Installation
You can run using `bash backlightctl.sh` or `./backlightctl.sh`.
To be able to run anywhere, copy the script to /usr/bin/backlightctl.sh and use 
chmod to change rights to 0777 (Or any other that lets you execute the script)

### Usage
As root (or using sudo), run
`./backlightctl.sh <percentage>`
With percentage being between 0 and 100.

