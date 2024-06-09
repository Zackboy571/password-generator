#!/usr/bin/env bash

current_path=$(pwd)

check=""$current_path"/check.sh"

echo
echo "Enter your password : " ; read -s passwd

"$check" "$passwd"

echo -e "\nYour password meets the minimum requirements\n"

echo "$passwd"

exit 0
