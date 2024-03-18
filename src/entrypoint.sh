#!/bin/sh

echo "Starting..."

"$HOME"/scripts/html-uploader.sh & \
"$HOME"/scripts/html-watcher.sh & \
"$HOME"/scripts/pdf-watcher.sh

echo "Exiting..."
