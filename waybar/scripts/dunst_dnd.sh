#!/bin/bash
if [ $(dunstctl is-paused) != true ]; then 
    echo 'i 󰋑 󰂚' 
else 
    echo 'i 󰋔 󰂛' 
fi
