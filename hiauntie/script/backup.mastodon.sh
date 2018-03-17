#!/bin/bash

# refer to https://github.com/tootsuite/documentation/blob/master/Maintaining-Mastodon/Backups-Guide.md

set -e

rm -rf /tmp/XFJXIDUJ-backup

# backup DB
pg_dump mastodon_production > /tmp/XFJXIDUJ-backup/mastodon_production.sql

# backup user generated content
cd /home/mastodon/live/public
tar -czf /tmp/XFJXIDUJ-backup/ugc.tar.gz system

# backup server secret
cp /home/mastodon/live/.env.production /tmp/XFJXIDUJ-backup/
