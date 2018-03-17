#!/bin/bash

set -e

# backup DB
sudo rm -rf /tmp/XFJXIDUJ-backup
sudo su - mastodon -c bash /home/hiauntie_bot/maintenance.hiauntie.com/hiauntie/script/backup.bot.sh
