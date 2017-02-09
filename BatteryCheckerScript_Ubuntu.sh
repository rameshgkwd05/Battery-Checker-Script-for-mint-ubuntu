#!/bin/bash

#
# Programmer: Ramesh Dilip Gaikwad
# Name: Battery Checker Script
# Date: Saturday July,4 2015 3:42:38 AM
# A Battery Percentage checker App
# It creates a low battery sound at 80% sound when battery is discharging and is below 18%
# The service runs after every 5 minutes
# The sound stops when a charger is connected

# Assumptions:
# + A Low-battery-sound.mp3 is present in /usr/share/sounds/ folder
# + The pc sounds are having alsa card
# + play command installed and can play .mp3 files

#
while true;
do
echo "BATTERY POWER CHECK"

checkpc=97
state=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "state" | awk '{print $2}'`
pc=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "percentage" | awk '{print $2}' | cut -d'%' -f1`

echo $state,$pc

if [ "$state" == "discharging" ]
then
	echo "Battery is DisCharging and is having $pc%"
	if [ "$pc" -le "$checkpc" ]
	then
		echo "It is less than $checkpc%"
		#play low battery sound while it is not charging
		#Check if Sound is Mute or Not
		#If MUTE then unmute it and play low battery sound
		# When charger is connected then set backto original state of volume
		OnOROff=` amixer sget 'Master' | grep "Mono" | grep "dB" | cut -d"[" -f4 | cut -d"]" -f1`
		vol_level=` amixer sget 'Master' | grep "Mono" | grep "dB" | cut -d"[" -f2 | cut -d "%" -f1`
		while [ "$state" != "charging" ]
		do
			echo "Connect Charger!" 
			
			state=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "state" | awk '{print $2}'`				       
			if [ "$vol_level" -lt "80" ]
			then
				 echo `amixer sset 'Master' 80%` > /dev/null
			fi

			if [ "$OnOROff" == "off" ]
			then
				OnOROff="wasOFF"
				`amixer -q -D pulse set Master toggle`
			fi
			cvlc  /usr/share/sounds/ubuntu/notifications/Xylo.ogg & sleep 1 && kill $!
		done 
		echo "Good job! Charger Connected :) "
		#set original volume level and OnOROff state
		echo `amixer sset 'Master' "$vol_level"%` > /dev/null
		if [ "$OnOROff" == "wasOFF" ]
		then
			`amixer -q -D pulse set Master toggle`
		fi
		
	fi
fi

sleep 2
done
