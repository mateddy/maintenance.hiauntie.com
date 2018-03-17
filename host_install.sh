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

# install software
sudo apt-get install python-pip pwgen -y
sudo pip install --upgrade pip
pip install --user awscli
pip install --user --upgrade awscli

# create log folder
sudo mkdir -p /var/log/hiauntie
sudo chown hiauntie_bot:hiauntie_bot /var/log/hiauntie
sudo chmod 755 /var/log/hiauntie

# clone backup enc key to hiauntie.com
ssh hiauntie_bot@hiauntie.com -C mkdir -p /home/hiauntie_bot/.hiauntie
ssh hiauntie_bot@hiauntie.com -C chmod 700 /home/hiauntie_bot/.hiauntie
scp /home/hiauntie_bot/.hiauntie/backup_enc_key hiauntie_bot@hiauntie.com:/home/hiauntie_bot/.hiauntie/backup_enc_key
ssh hiauntie_bot@hiauntie.com -C chmod 600 /home/hiauntie_bot/.hiauntie/backup_enc_key

# run script in hiauntie.com
scp hiauntie/script/install.sh hiauntie_bot@hiauntie.com:/home/hiauntie_bot/
ssh hiauntie_bot@hiauntie.com -C chmod 755 /home/hiauntie_bot/install.sh
ssh hiauntie_bot@hiauntie.com -C /home/hiauntie_bot/install.sh

# install files
sudo cp host/root/etc/cron.d/hiauntie_backup /etc/cron.d/hiauntie_backup

echo LAMAGTUZ ${0} done
