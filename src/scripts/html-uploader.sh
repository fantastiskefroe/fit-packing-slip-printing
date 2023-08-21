#!/bin/sh

path="$HOME/files/html"

mkdir "$path"

(cd "$path" && exec python3 -m uploadserver --basic-auth fit-user:"$PRINTER_TOKEN")
