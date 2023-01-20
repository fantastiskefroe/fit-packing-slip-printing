#!/bin/sh

echo "Inserting mail account and password into .fetchmailrc"

sed -i "3i username \"$MAIL_ACCOUNT\"" "$HOME"/.fetchmailrc
sed -i "4i password \"$MAIL_PASSWORD\"" "$HOME"/.fetchmailrc

echo "Starting..."

"$HOME"/scripts/mailfetcher.sh &
"$HOME"/scripts/mail-watcher.sh & \
"$HOME"/scripts/html-watcher.sh & \
"$HOME"/scripts/pdf-watcher.sh

echo "Exiting..."
