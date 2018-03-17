#!/bin/bash

set -e

MY_DNSDOMAINNAME=`dnsdomainname`
MY_HOSTNAME=`hostname`

# check run origin
if [ "${MY_DNSDOMAINNAME}" != "luzi82.com" ]; then
    echo run me only on hiauntie_bot@host0.luzi82.com
    exit 1
fi

if [ "${MY_HOSTNAME}" != "host0" ]; then
    echo run me only on hiauntie_bot@host0.luzi82.com
    exit 1
fi

if [ ! -f /home/hiauntie_bot/.hiauntie/backup_enc_key ]; then
    echo require /home/hiauntie_bot/.hiauntie/backup_enc_key
    exit 1
fi

if [ ! -f /home/hiauntie_bot/.hiauntie/config.json ]; then
    echo require /home/hiauntie_bot/.hiauntie/config.json
    exit 1
fi

chmod 600 /home/hiauntie_bot/.hiauntie/config.json

# install software
sudo apt-get install python-pip python3-pip pwgen -y
sudo pip install --upgrade pip
sudo pip3 install --upgrade pip
pip install --user --upgrade awscli
pip3 install --user --upgrade Mastodon.py

# init bot stuff
python3 -m hiauntie_py.init
chmod 600 /home/hiauntie_bot/.hiauntie/bot_client.secret
chmod 600 /home/hiauntie_bot/.hiauntie/user_announcement.secret
chmod 600 /home/hiauntie_bot/.hiauntie/user_verbose.secret

# create log folder
sudo mkdir -p /var/log/hiauntie
sudo chown hiauntie_bot:hiauntie_bot /var/log/hiauntie
sudo chmod 755 /var/log/hiauntie

# clone key to hiauntie.com
ssh hiauntie_bot@hiauntie.com -C mkdir -p /home/hiauntie_bot/.hiauntie
ssh hiauntie_bot@hiauntie.com -C chmod 700 /home/hiauntie_bot/.hiauntie
scp /home/hiauntie_bot/.hiauntie/backup_enc_key           hiauntie_bot@hiauntie.com:/home/hiauntie_bot/.hiauntie/backup_enc_key
ssh hiauntie_bot@hiauntie.com -C chmod 600 /home/hiauntie_bot/.hiauntie/backup_enc_key
scp /home/hiauntie_bot/.hiauntie/bot_client.secret        hiauntie_bot@hiauntie.com:/home/hiauntie_bot/.hiauntie/bot_client.secret
ssh hiauntie_bot@hiauntie.com -C chmod 600 /home/hiauntie_bot/.hiauntie/bot_client.secret
scp /home/hiauntie_bot/.hiauntie/user_announcement.secret hiauntie_bot@hiauntie.com:/home/hiauntie_bot/.hiauntie/user_announcement.secret
ssh hiauntie_bot@hiauntie.com -C chmod 600 /home/hiauntie_bot/.hiauntie/user_announcement.secret
scp /home/hiauntie_bot/.hiauntie/user_verbose.secret      hiauntie_bot@hiauntie.com:/home/hiauntie_bot/.hiauntie/user_verbose.secret
ssh hiauntie_bot@hiauntie.com -C chmod 600 /home/hiauntie_bot/.hiauntie/user_verbose.secret

# run script in hiauntie.com
scp hiauntie/script/install.sh hiauntie_bot@hiauntie.com:/home/hiauntie_bot/
ssh hiauntie_bot@hiauntie.com -C chmod 755 /home/hiauntie_bot/install.sh
ssh hiauntie_bot@hiauntie.com -C /home/hiauntie_bot/install.sh
ssh hiauntie_bot@hiauntie.com -C rm /home/hiauntie_bot/install.sh

# install files
sudo cp host/root/etc/cron.d/hiauntie_backup /etc/cron.d/hiauntie_backup

echo LAMAGTUZ ${0} done
