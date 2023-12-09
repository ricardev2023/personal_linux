#!/bin/sh

# This script is used in the "set_target" alias in .zshrc
# It is meant to create a target.txt and then write the target
# written as first argument beetwen "".

# Then ~/.config/qtile/settings/widgets.py target() will
# read through the target.txt file and put it on the bar.

# Be sure to give execution permission before trying it
# chmod +x ./target.sh

if [ "$1" = "" ] 
  then
    rm -f ~/.config/qtile/scripts/target.txt
  else 
    touch "~/.config/qtile/scripts/target.txt";
    echo $1 > "~/.config/qtile/scripts/target.txt";  
fi 


