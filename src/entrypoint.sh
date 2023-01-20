#!/bin/sh

echo "Inserting mail account and password into .fetchmailrc"

sed -i "3i username \"$MAIL_ACCOUNT\"" /root/.fetchmailrc
sed -i "4i password \"$MAIL_PASSWORD\"" /root/.fetchmailrc

echo "Starting..."

/root/scripts/mailfetcher.sh &
/root/scripts/mail-watcher.sh & \
/root/scripts/html-watcher.sh & \
/root/scripts/pdf-watcher.sh

echo "Exiting..."
