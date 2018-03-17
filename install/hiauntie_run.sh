#!/bin/bash

set -e

cd /home/hiauntie_bot
if [ ! -d maintenance.hiauntie.com ]; then
    git clone git@github.com:luzi82/maintenance.hiauntie.com.git
fi

cd /home/hiauntie_bot/maintenance.hiauntie.com
git pull
