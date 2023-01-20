#!/bin/sh

path="$HOME/files/mail"

mkdir -p "$path"/done

inotifywait -m "$path" -e create |
  while read -r dir action file; do
    if [[ "$file" =~ .*mail$ ]]; then # Does the file end with .mail?
      python3 "$dir"../../scripts/parser.py "$dir""$file" && \
        mv "$dir""$file" "$dir"/done/ && \
        mv "$dir""$file".html "$dir"/../html/
    fi
  done
