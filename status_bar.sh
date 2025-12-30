#!/bin/bash
echo "$(wpctl get-volume @DEFAULT_SINK@)" "$(cat /sys/class/power_supply/BAT0/status)" Battery:"$(cat /sys/class/power_supply/BAT0/capacity)"% "$(date --rfc-3339=seconds)"
