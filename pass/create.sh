#!/usr/bin/env bash

current_path=$(pwd)

check=""$current_path"/check.sh"

echo
read -s -p "Enter your password : " passwd

"$check" "$passwd"

echo -e "\nYour password meets the minimum requirements\n"

echo "$passwd"

exit 0
