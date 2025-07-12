#!/bin/bash
coverUrl=$(playerctl -s --player=%any metadata --format {{mpris:artUrl}})
status=$(playerctl -s status)
if [ "${status}" = "" ]; then
    echo "$HOME/.config/waybar/resources/transparent_square.png"
elif [[ $coverUrl == *"file://"* ]]; then
    DATA=$coverUrl
    pattern="file://"
    DATA=${DATA/$pattern/}
    echo "${DATA}"
else
    file="$HOME/.config/waybar/resources/tmp/album-cover.png"
    if test -e "$file"
    then zflag="-z '$file'"
    else zflag=
    fi
    curl -s -o "$file" $zflag "$coverUrl"
    echo "$HOME/.config/waybar/resources/tmp/album-cover.png"
fi