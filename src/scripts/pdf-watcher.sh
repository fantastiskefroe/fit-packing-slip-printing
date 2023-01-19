#!/bin/sh

path="/root/files/pdf"

mkdir -p "$path/done"

echo "$PRINTER_URL"

inotifywait -m "$path" -e moved_to |
  while read -r dir action file; do
    if [[ "$file" =~ .*pdf$ ]]; then # Does the file end with .pdf?
      curl -X POST "$PRINTER_URL" -F "files=@$dir$file" -F "token=$PRINTER_TOKEN" &&
        mv "$dir$file" "$dir/done/"
    fi
  done
