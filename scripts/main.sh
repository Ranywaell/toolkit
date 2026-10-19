#!/bin/bash

# Authentication
user_file="$(dirname "$0")/users.txt"
access_file="$(dirname "$0")/access_control.txt"

if [ ! -f "$user_file" ]; then
    echo "Missing $user_file. Copy users.txt.example to users.txt first."
    exit 1
fi

read -p "Username: " username
read -s -p "Password: " password
echo

auth_line="$username:$password"
# -F: treat input as a fixed string, not a regex (prevents '.*' bypass)
if [ -z "$username" ] || ! grep -qxF -- "$auth_line" "$user_file"; then
    echo "Access denied: Wrong username or password."
    exit 1
fi

# Function to check file access
check_access() {
    local user=$1
    local file=$2
    if ! grep -qxF -- "$user:$file" "$access_file"; then
        echo "Access denied: You do not have permission to access $file"
        exit 1
    fi
}

source "$(dirname "$0")/charts.sh"
source "$(dirname "$0")/stats.sh"

echo "========= Visualization Toolkit ========="
echo "1) Show Stats"
echo "2) Show Bar Chart"
echo "3) Exit"
read -p "Choose an option: " opt

case $opt in
    1)
        read -p "Enter filename (data/sample.csv): " file
        check_access "$username" "$file"
        read -p "Enter column index for analysis (e.g., 2 for Score): " col
        print_stats "$file" "$col"
        ;;
    2)
        read -p "Enter filename (data/sample.csv): " file
        check_access "$username" "$file"
        read -p "Enter label column (e.g., 1 for Name): " lcol
        read -p "Enter value column (e.g., 2 for Score): " vcol
        bar_chart "$file" "$lcol" "$vcol"
        ;;
    3) exit 0 ;;
    *) echo "Invalid option" ;;
esac
