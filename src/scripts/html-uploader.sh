#!/bin/sh

path="$HOME/files/html"

mkdir p "$path"

(cd "$path" && exec python3 -m uploadserver)
