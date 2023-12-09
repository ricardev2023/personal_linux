#!/bin/sh

# Configuracion del fondo de pantalla
wallpaper(){
  cat /home/strelock/.config/qtile/wallpaper.txt
}
feh --bg-fill /home/strelock/.config/qtile/themes/wallpapers/$( wallpaper ) &

# Configurar sombras y opacidades
picom -b &

# Configurar sonido en systray
volumeicon &

# Configurar Flamshot screenshoots en systray
flameshot &
