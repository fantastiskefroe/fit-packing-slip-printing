#!/bin/sh

(cd "$HOME/files/html" && exec python3 -m uploadserver --basic-auth fit-user:"$PRINTER_TOKEN")
