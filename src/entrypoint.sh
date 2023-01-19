#!/bin/sh

echo "Starting..."

/root/scripts/mailfetcher.sh &
/root/scripts/mail-watcher.sh & \
/root/scripts/html-watcher.sh & \
/root/scripts/pdf-watcher.sh

echo "Exiting..."
