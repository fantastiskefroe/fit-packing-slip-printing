#!/bin/sh

path="/root/files/html"

mkdir -p "$path"/done

inotifywait -m "$path" -e moved_to |
  while read -r dir action file; do
    if [[ "$file" =~ .*html$ ]]; then # Does the file end with .html?
      wkhtmltopdf -B 24 -L 12 -R 12 -T 24 "$dir""$file" "$dir""$file"".pdf" && \
        mv "$dir""$file" "$dir"/done/ && \
        mv "$dir""$file".pdf "$dir"/../pdf/
    fi
  done
