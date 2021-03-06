#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

#paint wallpaper
feh --bg-fill $HOME/Pictures/wallpapers/Tartarus.jpg

# Launch polybar
polybar main -c $HOME/.config/polybar/start/Tartarus.ini &
polybar center -c $HOME/.config/polybar/start/Tartarus.ini &
polybar right -c $HOME/.config/polybar/start/Tartarus.ini &
polybar monitoring -c $HOME/.config/polybar/start/Tartarus.ini & 
