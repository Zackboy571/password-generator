#!/usr/bin/env bash
current_path="$(pwd)"

check=""$current_path"/check.sh"

[ "$UID" -eq 0 ] || exec sudo "$0"

single-user() {
	read -p "username : " username
	read -s -p "password : " password
	"$check" "$password"
	echo
	read -p "preferred shell : " shell

	sudo useradd -m -d /home/"$username" -s /bin/"$shell" "$username"

	echo "$username":"$password" | sudo chpasswd 
}

multiple-users() {
	
}

read -p "Would you like to create (o)ne or (m)ultiple users? : " choice

case "$choice" in
	"o") single-user ;;
	"m") multiple-users ;;
	*) ;;
esac
