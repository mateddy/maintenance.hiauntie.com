#!/bin/bash

set -e

PATH=/home/hiauntie_bot/bin:/home/hiauntie_bot/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/snap/bin

TIMESTAMP_YYYY=`date +%Y`
TIMESTAMP_FULL=`date +%Y%m%d-%H%M%S`

echo JEJJYMOF TIMESTAMP_FULL=${TIMESTAMP_FULL}

echo KDSVWOCI create backup files
cd /tmp
sudo rm -rf /tmp/XFJXIDUJ-backup
sudo sudo -u mastodon /home/hiauntie_bot/maintenance.hiauntie.com/hiauntie/script/backup.mastodon.sh
sudo chown -R hiauntie_bot:hiauntie_bot /tmp/XFJXIDUJ-backup

echo LEEIMVXB tar gz everything
cd /tmp/XFJXIDUJ-backup
tar -czf hiauntie-backup.tar.gz hiauntie-backup
rm -rf /tmp/XFJXIDUJ-backup/hiauntie-backup

echo COZNCIRT encrypt files
cd /tmp/XFJXIDUJ-backup
pwgen -s 256 1 > /tmp/XFJXIDUJ-backup/enc.key
openssl enc -aes-256-cbc -salt -kfile /tmp/XFJXIDUJ-backup/enc.key -in hiauntie-backup.tar.gz -out hiauntie-backup.tar.gz.enc
openssl enc -aes-256-cbc -salt -kfile /home/hiauntie_bot/.hiauntie/backup_enc_key -in /tmp/XFJXIDUJ-backup/enc.key -out /tmp/XFJXIDUJ-backup/enc.key.enc
rm -rf /tmp/XFJXIDUJ-backup/hiauntie-backup.tar.gz
rm -rf /tmp/XFJXIDUJ-backup/enc.key

echo UQMEXYOM final tar to one file
cd /tmp/XFJXIDUJ-backup
mkdir -p /tmp/XFJXIDUJ-backup/pack
mv /tmp/XFJXIDUJ-backup/hiauntie-backup.tar.gz.enc /tmp/XFJXIDUJ-backup/pack/hiauntie-backup.tar.gz.enc
mv /tmp/XFJXIDUJ-backup/enc.key.enc                /tmp/XFJXIDUJ-backup/pack/enc.key.enc
tar -cf pack.tar pack
rm -rf /tmp/XFJXIDUJ-backup/pack

echo KXYMXFAE upload to s3
cd /tmp/XFJXIDUJ-backup
aws s3 cp /tmp/XFJXIDUJ-backup/pack.tar s3://hiauntie-backup/data/${TIMESTAMP_YYYY}/${TIMESTAMP_FULL}/data-backup-${TIMESTAMP_FULL}.tar --quiet
rm -rf /tmp/XFJXIDUJ-backup/pack.tar

echo GQNLIDYQ clean up
cd /tmp
sudo rm -rf /tmp/XFJXIDUJ-backup
