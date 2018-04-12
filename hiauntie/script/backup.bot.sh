#!/bin/bash

set -e

PATH=/home/hiauntie_bot/bin:/home/hiauntie_bot/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/snap/bin

TIMESTAMP_YYYY=`date +%Y`
TIMESTAMP_FULL=`date +%Y%m%d-%H%M%S`

echo JEJJYMOF TIMESTAMP_FULL=${TIMESTAMP_FULL}

echo KDSVWOCI create backup files
cd /tmp
sudo rm -rf /tmp/XFJXIDUJ-backup
sudo -u mastodon /home/hiauntie_bot/maintenance.hiauntie.com/hiauntie/script/backup.mastodon.sh
sudo chown -R hiauntie_bot:hiauntie_bot /tmp/XFJXIDUJ-backup

echo ZJFKDKLW move backup product
mv /tmp/XFJXIDUJ-backup/hiauntie-backup/mastodon_production.sql.gz /tmp/XFJXIDUJ-backup/
mv /tmp/XFJXIDUJ-backup/hiauntie-backup/ugc.tar.gz                 /tmp/XFJXIDUJ-backup/
mv /tmp/XFJXIDUJ-backup/hiauntie-backup/env.production.gz          /tmp/XFJXIDUJ-backup/

echo RIAZEMKH encrypt files
cd /tmp/XFJXIDUJ-backup
pwgen -s 256 1 > mastodon_production.sql.gz.enc.key
pwgen -s 256 1 > ugc.tar.gz.enc.key
pwgen -s 256 1 > env.production.gz.enc.key
openssl enc -aes-256-cbc -salt -kfile mastodon_production.sql.gz.enc.key -in mastodon_production.sql.gz -out mastodon_production.sql.gz.enc
openssl enc -aes-256-cbc -salt -kfile ugc.tar.gz.enc.key                 -in ugc.tar.gz                 -out ugc.tar.gz.enc
openssl enc -aes-256-cbc -salt -kfile env.production.gz.enc.key          -in env.production.gz          -out env.production.gz.enc
openssl enc -aes-256-cbc -salt -kfile /home/hiauntie_bot/.hiauntie/backup_enc_key -in mastodon_production.sql.gz.enc.key -out mastodon_production.sql.gz.enc.key.enc
openssl enc -aes-256-cbc -salt -kfile /home/hiauntie_bot/.hiauntie/backup_enc_key -in ugc.tar.gz.enc.key                 -out ugc.tar.gz.enc.key.enc
openssl enc -aes-256-cbc -salt -kfile /home/hiauntie_bot/.hiauntie/backup_enc_key -in env.production.gz.enc.key          -out env.production.gz.enc.key.enc
rm -f /tmp/XFJXIDUJ-backup/mastodon_production.sql.gz
rm -f /tmp/XFJXIDUJ-backup/ugc.tar.gz
rm -f /tmp/XFJXIDUJ-backup/env.production.gz
rm -f /tmp/XFJXIDUJ-backup/mastodon_production.sql.gz.enc.key
rm -f /tmp/XFJXIDUJ-backup/ugc.tar.gz.enc.key
rm -f /tmp/XFJXIDUJ-backup/env.production.gz.enc.key

echo HUBTKBWW upload to s3
cd /tmp/XFJXIDUJ-backup
aws s3 cp /tmp/XFJXIDUJ-backup/mastodon_production.sql.gz.enc s3://hiauntie-backup/data/${TIMESTAMP_YYYY}/${TIMESTAMP_FULL}/mastodon_production.sql.gz.enc.${TIMESTAMP_FULL} --quiet
aws s3 cp /tmp/XFJXIDUJ-backup/ugc.tar.gz.enc                 s3://hiauntie-backup/data/${TIMESTAMP_YYYY}/${TIMESTAMP_FULL}/ugc.tar.gz.enc.${TIMESTAMP_FULL} --quiet
aws s3 cp /tmp/XFJXIDUJ-backup/env.production.gz.enc          s3://hiauntie-backup/data/${TIMESTAMP_YYYY}/${TIMESTAMP_FULL}/env.production.gz.enc.${TIMESTAMP_FULL} --quiet
aws s3 cp /tmp/XFJXIDUJ-backup/mastodon_production.sql.gz.enc.key s3://hiauntie-backup/data/${TIMESTAMP_YYYY}/${TIMESTAMP_FULL}/mastodon_production.sql.gz.enc.key.${TIMESTAMP_FULL} --quiet
aws s3 cp /tmp/XFJXIDUJ-backup/ugc.tar.gz.enc.key                 s3://hiauntie-backup/data/${TIMESTAMP_YYYY}/${TIMESTAMP_FULL}/ugc.tar.gz.enc.key.${TIMESTAMP_FULL} --quiet
aws s3 cp /tmp/XFJXIDUJ-backup/env.production.gz.enc.key          s3://hiauntie-backup/data/${TIMESTAMP_YYYY}/${TIMESTAMP_FULL}/env.production.gz.enc.key.${TIMESTAMP_FULL} --quiet

echo GQNLIDYQ clean up
cd /tmp
sudo rm -rf /tmp/XFJXIDUJ-backup
