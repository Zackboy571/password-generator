#!/usr/bin/env bash

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

check "$1"
