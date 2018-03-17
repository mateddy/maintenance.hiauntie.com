#!/bin/bash

set -e

MY_DNSDOMAINNAME=`dnsdomainname`
MY_HOSTNAME=`hostname`

if [ "${MY_DNSDOMAINNAME}" != "luzi82.com" ]; then
    echo run me only on hiauntie_bot@host0.luzi82.com
    return 1
fi

if [ "${MY_HOSTNAME}" != "host0" ]; then
    echo run me only on hiauntie_bot@host0.luzi82.com
    return 1
fi

scp install/hiauntie_run.sh hiauntie_bot@hiauntie.com:/home/hiauntie_bot/
ssh hiauntie_bot@hiauntie.com -C chmod 755 /home/hiauntie_bot/hiauntie_run.sh
ssh hiauntie_bot@hiauntie.com -C /home/hiauntie_bot/hiauntie_run.sh
