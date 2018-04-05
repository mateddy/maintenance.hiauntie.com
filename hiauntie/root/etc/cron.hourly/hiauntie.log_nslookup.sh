#!/bin/base

set -e

TIMESTAMP_FULL=`date +%Y%m%d-%H%M%S`

mkdir -p /var/log/hiauntie

echo DJQZRGPG ${TIMESTAMP_FULL} >> /var/log/hiauntie/log_nslookup.sh

nslookup hiauntie.com >> /var/log/hiauntie/log_ip.sh
