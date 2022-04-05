#!/bin/bash

# overview:
# -----------------
# This script is meant to bridge the distance between the complicated usage of changing screen brightnesses with xrandr, 
# and monkeys who can't be bothered to remember all of the documentation just to turn their screen down 5 brightness units.
# -----------------


syntax_error()
{
 # write in red
 tput setaf 1; echo "A syntax error has ocurred."

 # if a message is passed through to the error function, print it in red
 if [ ! -z "$1" ]; then
  echo "" # line skip

  tput setaf 1; echo $1
 fi

 echo "" # line skip

 # write in white
 tput sgr0; echo "Example of using this script:"

 echo "" # line skip

 # write in green
 tput setaf 2; echo "./glow.sh set DEVICE_NAME BRIGHTNESS"

}

echo "" # skip the first line

# if the first parameter isn't nil, then go on with the task, if it is, return an error
if [ ! -z $1 ]; then
 
 # get details
 if [ $1 == "get" ]; then

  # get active devices
  if [ $2 == "dev" ] || [ $2 == "device" ]; then
   # show screen device name
   echo "Connected screens:"

   echo "" # line skip
  
   # get list of devices, cut out their names and print them in green
   tput setaf 2; xrandr --prop | grep " connected" | awk '{print $1}'

  # show brightness of devices
  elif [ $2 == "br" ] || [ $2 == "brightness" ]; then
   
   # get all of the options in a string
   options=$(xrandr --prop | grep " connected" | awk '{print $1}')

   # check if the third parameter exists within the options string
   if [[ $3 =~ ^(${options//$'\n'/|})$ ]]; then

    echo -n "The brightness of this device is " && tput setaf 2; xrandr --verbose | grep -A 5 $3 | awk '/Brightness/ {print $2}'

   else
    syntax_error "No device name was given."
   fi

  else
   syntax_error "Not a valid option to get from Xrandr."
  fi

 # set brightness
 elif [ $1 == "set" ]; then

  if [ ! -z $2 ]; then
   # get all of the options in a string
   options=$(xrandr --prop | grep " connected" | awk '{print $1}')

   # check if the third parameter exists within the options string
   if [[ $2 =~ ^(${options//$'\n'/|})$ ]]; then
    # if passed in parameter is not nil
    if [ ! -z $3 ]; then
     # and if passed in parameter is within the range of 0 and 1
     if [ $(bc <<< "$3 >= 0") == 1 ] && [ $(bc <<< "$3 <= 1") == 1 ]; then
      # set the brightness to the given parameter
      xrandr --output $2 --brightness $3
  
      # in green print success message
      tput setaf 2; echo "SUCCESSFULLY SET SCREEN BRIGHTNESS"
     else
      syntax_error "The parameter is not in given range."
     fi
    else
     syntax_error "Needed parameter isn't specified."
    fi
   else
    syntax_error "Device doesn't exist."
   fi
  else
   syntax_error "Device was not inputted."
  fi
 else
  syntax_error "Not a valid action."
 fi
else
 syntax_error "No action has been entered."
fi

echo "" # line skip
