#!/usr/bin/env bash

current_dir=$(pwd)

create=""$current_dir"/create.sh"

user=""$current_dir"/user.sh"

check=""$current_path"/check.sh"

check() {
        local passwd="$1"
        local passwd_lenght=${#passwd}
        local upper_check=$(echo "$passwd" | grep -o '[A-Z]' | tr -d '\n' | wc -c)
        local special_char_check=$(echo "$passwd" | tr -dc '[:punct:]' | wc -c)
        local num_check=$(echo "$passwd" | grep -o '[0-9]' | tr -d '\n' | wc -c)

        if [ "$passwd_lenght" -lt "16" ];then
                echo -e "\nPassword must be a minimum of 16 characters"
                exit 1
        fi

        if [ "$upper_check" -lt "2" ] || [ "$special_char_check" -lt "2" ] || [ "$num_check" -lt "2" ];then
                echo -e "\nPassword must contain a minimum of 2 upper case letters, numbers and special characters"
                exit 1
        fi
}


single-user() {
        read -p "username : " username
        read -s -p "password : " password
        check "$password"
        echo
        read -p "preferred shell : " shell

        sudo useradd -m -d /home/"$username" -s /bin/"$shell" "$username"

        echo "$username":"$password" | sudo chpasswd

	if [ "$?" -eq 0 ];then
		echo -e "\nuser "$username" was created"
	fi
}


generate(){
	pass=$(echo $(openssl rand -base64 12 | tr -d '=='))
	echo -e "\npassword "$pass""
	echo -e "\nhash $(echo "$pass" | md5sum)\n" | tr -d '-'	
}


create(){
	echo
	read -s -p "Enter your password : " passwd

	check "$passwd"

	echo -e "\nYour password meets the minimum requirements\n"

	echo "$passwd"

}


user() {
	read -p "Would you like to create (o)ne or (m)ultiple users? : " choice

	case "$choice" in
        	"o") single-user ;;
        	"m") multiple-users ;;
        	*) echo -e "\nnot a valid option exiting" ; exit 1 ;;
	esac
}



echo -e "\n(c)reate or (g)enerate fairly secure passwords and/or create (u)sers\n"

echo -e "--------------------------------------------------------------------\n"

read -p "What do you want to do? : " choice


case "$choice" in
	"c") create ;;
	"g") generate ;;
	"u") user ;;
	*) echo "\nnot a valid option exiting" ; exit 1 ;;
esac
