#!/bin/bash
coverPath=$(playerctl -s --player=chromium,%any metadata --format {{mpris:artUrl}})
status=$(playerctl -s status)
if [ "${status}" = "" ]; then
    echo "$HOME/.config/waybar/resources/transparent_square.png"
elif [[ $coverPath == *"file://"* ]]; then
    DATA=$coverPath
    pattern="file://"
    DATA=${DATA/$pattern/}
    echo "${DATA}"
else
    echo "$HOME/.config/waybar/resources/album_cover_placeholder.png"
fi