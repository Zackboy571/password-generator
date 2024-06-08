#!/usr/bin/env bash

current_dir=$(pwd)

create=""$current_dir"/create.sh"

user=""$current_dir"/user.sh"

generate(){
	pass=$(echo $(openssl rand -base64 12 | tr -d '=='))
	echo -e "\npassword "$pass""
	echo -e "\nhash $(echo "$pass" | md5sum)\n" | tr -d '-'	
}

echo -e "\n(c)reate or (g)enerate fairly secure passwords and/or create (u)sers\n"

echo -e "--------------------------------------------------------------------\n"

read -p "What do you want to do? : " choice

case "$choice" in
	"c") "$create" ;;
	"g") generate ;;
	"u") "$user" ;;
	*) echo "not a valid option exiting" ; exit 1 ;;
esac
