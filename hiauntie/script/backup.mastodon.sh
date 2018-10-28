#!/bin/bash

# refer to https://github.com/tootsuite/documentation/blob/master/Maintaining-Mastodon/Backups-Guide.md

set -e

rm -rf /tmp/XFJXIDUJ-backup
mkdir -p /tmp/XFJXIDUJ-backup

mkdir -p /tmp/XFJXIDUJ-backup/hiauntie-backup

echo QPTRBMEM backup DB
pg_dump mastodon_production | gzip --stdout > /tmp/XFJXIDUJ-backup/hiauntie-backup/mastodon_production.sql.gz

echo HFGNJLSS backup user generated content
cd /home/mastodon/live/public
tar -czf /tmp/XFJXIDUJ-backup/hiauntie-backup/ugc.tar.gz system

echo SIXTBIUG backup server secret
cat /home/mastodon/live/.env.production | gzip --stdout > /tmp/XFJXIDUJ-backup/hiauntie-backup/env.production.gz
