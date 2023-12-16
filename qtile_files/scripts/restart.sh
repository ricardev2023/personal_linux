#!/bin/sh

# Configuracion del fondo de pantalla
wallpaper(){
  cat ~/.config/qtile/themes/wallpaper.txt
}
feh --bg-fill ~/.config/qtile/themes/wallpapers/$( wallpaper ) &