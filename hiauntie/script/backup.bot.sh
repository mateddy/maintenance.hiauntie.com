#!/bin/bash

set -e

# backup DB
sudo rm -rf /tmp/XFJXIDUJ-backup
sudo sudo -u mastodon /home/hiauntie_bot/maintenance.hiauntie.com/hiauntie/script/backup.mastodon.sh
