#!/bin/sh

mouse="*.*Mouse"
touchpad="*.*Touchpad"

swaymsg -t subscribe -m '[ "input" ]' | while read line
do
    change="$(echo "$line" | jq -r --arg mouse "$mouse" 'select(.input.identifier==$mouse).change')"
    case $change in
        added)
            swaymsg input "$touchpad" events disabled \
                && notify-send "touchpad disabled"
            ;;
        removed)
            swaymsg input "$touchpad" events enabled \
                && notify-send "touchpad enabled"
            ;;
    esac