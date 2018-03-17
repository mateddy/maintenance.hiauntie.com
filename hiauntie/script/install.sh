#!/bin/bash

set -e

sudo apt-get install python-pip python3-pip pwgen -y
sudo pip install --upgrade pip
sudo pip3 install --upgrade pip
pip install --user --upgrade awscli
pip3 install --user --upgrade Mastodon.py

cd /home/hiauntie_bot
if [ ! -d maintenance.hiauntie.com ]; then
    git clone git@github.com:luzi82/maintenance.hiauntie.com.git
fi

cd /home/hiauntie_bot/maintenance.hiauntie.com
git pull
