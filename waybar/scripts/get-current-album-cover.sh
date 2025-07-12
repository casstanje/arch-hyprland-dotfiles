#!/bin/bash
coverPath=$(playerctl --player=chromium,%any metadata --format {{mpris:artUrl}})
if [[ $coverPath == *"file://"* ]]; then
    DATA=$coverPath
    pattern="file://"
    DATA=${DATA/$pattern/}
    echo "${DATA}"
else
    echo "$HOME/.config/waybar/resources/album_cover_placeholder.png"
fi