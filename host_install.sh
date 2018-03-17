#!/bin/bash

set -e

MY_DNSDOMAINNAME=`dnsdomainname`
MY_HOSTNAME=`hostname`

if [ "${MY_DNSDOMAINNAME}" != "luzi82.com" ]; then
    echo run me only on hiauntie_bot@host0.luzi82.com
    exit 1
fi

if [ "${MY_HOSTNAME}" != "host0" ]; then
    echo run me only on hiauntie_bot@host0.luzi82.com
    exit 1
fi

sudo apt install python-pip pwgen -y
sudo pip install --upgrade pip
pip install --user awscli
pip install --user --upgrade awscli

ssh hiauntie_bot@hiauntie.com -C mkdir -p /home/hiauntie_bot/.hiauntie
ssh hiauntie_bot@hiauntie.com -C chmod 700 /home/hiauntie_bot/.hiauntie
scp /home/hiauntie_bot/.hiauntie/backup_enc_key hiauntie_bot@hiauntie.com:/home/hiauntie_bot/.hiauntie/backup_enc_key
ssh hiauntie_bot@hiauntie.com -C chmod 600 /home/hiauntie_bot/.hiauntie/backup_enc_key

scp hiauntie/script/hiauntie_run.sh hiauntie_bot@hiauntie.com:/home/hiauntie_bot/
ssh hiauntie_bot@hiauntie.com -C chmod 755 /home/hiauntie_bot/hiauntie_run.sh
ssh hiauntie_bot@hiauntie.com -C /home/hiauntie_bot/hiauntie_run.sh
