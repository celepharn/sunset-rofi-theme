#!/bin/sh

# Hello! Hope I am making this clear enough so you can modify it to your needs

# -------- About me --------- #
# author = Emiliano Samario   #
# github username = celepharn #
# mail = celephrn@hotmail.com #
# --------------------------- #

# define the variables
dir = "~/.config/sunset/scripts/rofi/"

comm = "rofi -theme $dir/powermenu.rasi"

# optiones that will be displayed on the menu
shutdown = ""
reboot = ""
lock = ""
suspend = ""
logout = ""

# confirmation prompt
confirm() {
	rofi -dmenu -i -no-fixed-num-lines\
		-p "u sure? :"\
		-theme $dir/confirm.rasi
}

# messages and commands
msg_abort() {
	dunstify -t 1600 'tread lightly... 🍉🍀'
}
msg_shutdown() {
	dunstify -t 1600 'good bye... 🍉🍀'
}
msg_bit() {
	dunstify -t 1600 'see you in a bit... 🍉🍀'
}
s_lock() {
	swaylock -C ~/.config/swaylock/conf --screenshots --effect-blur 4x1 --fade-in 0.2
}
i3_lock() {
	i3lock -i ~/Pictures/Wallpapers/wallpapers/minimalistic/lock.png	
}

# variables for rofi
options = "$shutdown\n$suspend\n$reboot\n$logout\n$lock"

selected = "$(echo -e "$options" )"

case $selected in 
	$shutdown)
		answer = $(confirm &)
		if [[ $answer == "yes" || $answer = "YES" ||$answer = "Y" ||$answer = "y" || ]]; then
			sleep 0.5
			msg_shutdown
			sleep 2.1
			systemctl poweroff
	
		elif [[ $answer == "NO" || $answer == "no" || $answer == "n" || $answer == "N" || $answer = "nel" ]]; then
			exit 0
	else
		msg_abort
	fi
	;;
	$reboot)
		answer = $(confirm &)
		if [[ $answer == "yes" || $answer = "YES" ||$answer = "Y" ||$answer = "y" || ]]; then
			sleep 0.5
			msg_bit
			sleep 2.1
			systemctl reboot
	
		elif [[ $answer == "NO" || $answer == "no" || $answer == "n" || $answer == "N" || $answer = "nel" ]]; then
			exit 0
	else
		msg_abort
	fi
	;;
	$lock)
		if [[ -f /usr/bin/swaylock ]]; then
			sleep 0.5
			dunstify -t 1600 'see you in a bit... 🍉🍀'
			sleep 2.1
			s_lock
		elif [[ -f /usr/bin/i3lock ]]; then	
			i3_lock
		fi
	;;
	$suspend)
		answer = $(confirm &)
		if [[ $answer == "yes" || $answer = "YES" ||$answer = "Y" ||$answer = "y" || ]]; then
			sleep 0.5
			msg_bit
			sleep 2.1
			systemctl suspend
			s_lock
		elif [[ $answer == "NO" || $answer == "no" || $answer == "n" || $answer == "N" || $answer = "nel" ]]; then
			exit 0
	else
		msg_abort
	fi
	;;
	$logout)
		answer = $(confirm &)
		if [[ $answer == "yes" || $answer = "YES" ||$answer = "Y" ||$answer = "y" || ]]; then
			hyperctl exit
		elif [[ $answer == "NO" || $answer == "no" || $answer == "n" || $answer == "N" || $answer = "nel" ]]; then
			exit 0
	else
		msg_abort
	fi
	;;
esac
