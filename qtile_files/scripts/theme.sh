#!/bin/bash

# This script is used by the "change_theme" alias in .zshrc
# It is meant to change the content of ~/.config/qtile/config.json
# with another theme from the folder themes.

# Be sure to give execution permission before trying it
# chmod +x ./theme.sh

theme_list(){
  # Prepares a list of themes using ls -la.
  ls -la ~/.config/qtile/themes/ | awk '{print $9}';
}

search_theme(){
  # Searches trough the theme_list for the first argument.
  theme_list | grep -q -c "\<$1.json";  
}

# Shows the list without extension.
theme_list | sed -e 's/\.json$//';
# Asks the user to type the name of a theme.
echo -e "\n--- Select one of the previous themes: ---";
read THEME;

# If the theme name exists, then changes are made.
if search_theme $THEME; then
    
    touch ~/.config/qtile/config.json;
    echo -e "{\"theme\": \"$THEME\"}" > ~/.config/qtile/config.json;
    echo -e "\nRefresh your qtile configuration --> Win + Ctrl + R";
    
    # This will generate a new file for the wallpaper name.
    touch ~/.config/qtile/wallpaper.txt;
    # This is for the autostart.sh script to save the changes.
    echo "$THEME.png" > ~/.config/qtile/themes/wallpaper.txt;
    # This changes the wallpaper
    feh --bg-fill ~/.config/qtile/themes/wallpapers/$THEME.png;
    
  # If not, the script closes.
  else
    echo "Not a valid Theme. Closing...";
fi
