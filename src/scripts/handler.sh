#!/bin/sh

id=$(date +"%Y%m%d_%H%M%S_%N")
file="$HOME/files/mail/$id.mail"

mailFile=$(cat)
echo "$mailFile" > "$file"
