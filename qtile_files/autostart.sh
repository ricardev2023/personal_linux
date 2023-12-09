#!/bin/sh

# Configuracion del fondo de pantalla
wallpaper(){
  cat ~/.config/qtile/wallpaper.txt
}
feh --bg-fill ~/.config/qtile/themes/wallpapers/$( wallpaper ) &

# Configurar sombras y opacidades
picom -b &

# Configurar sonido en systray
# volumeicon &

# Configurar Flamshot screenshoots en systray
flameshot &
