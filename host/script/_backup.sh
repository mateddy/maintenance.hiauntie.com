#!/bin/bash

set -e

function toot {
    ACCOUNT=$1
    MSG=$2

    cd /home/hiauntie_bot/maintenance.hiauntie.com
    python3 -m hiauntie_py.toot --account ${ACCOUNT} --msg "${MSG}" || true
}

OPT_DB=0
OPT_VM=0
OPT_UPDATE=0
OPT_MSG=0

while getopts ":dvum" opt; do
    case $opt in
        d)
            OPT_DB=1
            ;;
        v)
            OPT_VM=1
            ;;
        u)
            OPT_UPDATE=1
            ;;
        m)
            OPT_MSG=1
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

TIMESTAMP_YYYY=`date +%Y`
TIMESTAMP_FULL=`date +%Y%m%d-%H%M%S`

echo UFIEXGNO backup start ${TIMESTAMP_FULL} OPT_DB=${OPT_DB} OPT_VM=${OPT_VM}

if [ -f /vm-swap/social.hiauntie.main.com.overlay ]; then
    toot verbose "XSPPHFJE ERROR ${TIMESTAMP_FULL} @luzi82"
    echo DOFKGMEW ERROR /vm-swap/social.hiauntie.main.com.overlay exist
    exit 1
fi

if [ -f /vm-swap/social.hiauntie.com.swap.overlay ]; then
    toot verbose "VUNWEIPB ERROR ${TIMESTAMP_FULL} @luzi82"
    echo GHOOUWMG ERROR /vm-swap/social.hiauntie.com.swap.overlay exist
    exit 1
fi

OVERLAY_COUNT=`virsh domblklist social.hiauntie.com | grep overlay | wc -l`
if [ ${OVERLAY_COUNT} -ne 0 ]; then
    toot verbose "YKSYLZXY ERROR ${TIMESTAMP_FULL} @luzi82"
    echo BBDMCQZZ ERROR vm in overlay mode
fi

if [ ${OPT_DB} -eq 1 ]; then

    toot verbose "URLKLBPN data backup ${TIMESTAMP_FULL} start"
    
    rm -f /tmp/AUXWBAWC.log
    ssh hiauntie_bot@hiauntie.com -C /home/hiauntie_bot/maintenance.hiauntie.com/hiauntie/script/backup.bot.sh | tee /tmp/AUXWBAWC.log
    DF_STAT_0=`cat /tmp/AUXWBAWC.log | grep ZGQSAAMK`
    rm -f /tmp/AUXWBAWC.log

    toot verbose "HHNSHGUM data backup ${TIMESTAMP_FULL} peak ${DF_STAT_0}"
    
    toot verbose "HHNSHGUM data backup ${TIMESTAMP_FULL} end"

fi

if [ ${OPT_VM} -eq 1 ]; then

    toot verbose "AUVHTAWG vm backup ${TIMESTAMP_FULL} start"

    echo "LLGDRILQ remove old tmp file"
    
    sudo rm -rf /vm/DVCQDYKB-hiauntie-vm-backup.tmp
    sudo mkdir -p /vm/DVCQDYKB-hiauntie-vm-backup.tmp
    sudo chown hiauntie_bot:hiauntie_bot /vm/DVCQDYKB-hiauntie-vm-backup.tmp

    echo "TTOCUASF create snapshot"

    virsh snapshot-create-as \
        --domain social.hiauntie.com \
        --diskspec vda,file=/vm-swap/social.hiauntie.main.com.overlay \
        --diskspec hda,file=/vm-swap/social.hiauntie.com.swap.overlay \
        --disk-only --atomic --quiesce --no-metadata

    echo "PGXSEFIQ confirm using overlay mode"

    OVERLAY_COUNT=`virsh domblklist social.hiauntie.com | grep overlay | wc -l`
    if [ ${OVERLAY_COUNT} -ne 2 ]; then
        toot verbose "QXGFNQJS ERROR ${TIMESTAMP_FULL} @luzi82"
        echo WNTOHSZA ERROR create overlay fail
    fi

    echo "YLLXUKQD copy and gz main disk"

    cd /vm
    sudo rm -rf /vm/social.hiauntie.main.com.img.gz
    sudo gzip -k /vm/social.hiauntie.main.com.img
    sudo mv /vm/social.hiauntie.main.com.img.gz /vm/DVCQDYKB-hiauntie-vm-backup.tmp/social.hiauntie.main.com.img.gz
    sudo chown hiauntie_bot:hiauntie_bot /vm/DVCQDYKB-hiauntie-vm-backup.tmp/social.hiauntie.main.com.img.gz

    echo "AWXWTOWX VM go back to non-overlay mode"

    virsh blockcommit \
        --domain social.hiauntie.com \
        --path vda \
        --active --verbose --pivot --wait
    virsh blockcommit \
        --domain social.hiauntie.com \
        --path hda \
        --active --verbose --pivot --wait

    echo "EFTMXBNG check not using overlay"

    OVERLAY_COUNT=`virsh domblklist social.hiauntie.com | grep overlay | wc -l`
    if [ ${OVERLAY_COUNT} -ne 0 ]; then
        toot verbose "YKQGVYCO ERROR ${TIMESTAMP_FULL} @luzi82"
        echo SEDKSKAS ERROR overlay exist
    fi

    echo "CGKVRMYU remove overlay file"

    sudo rm -rf /vm-swap/social.hiauntie.main.com.overlay
    sudo rm -rf /vm-swap/social.hiauntie.com.swap.overlay

    echo "PAQBJCQE encrypt backup files"

    cd /vm/DVCQDYKB-hiauntie-vm-backup.tmp
    pwgen -s 256 1 > /vm/DVCQDYKB-hiauntie-vm-backup.tmp/enc.key
    openssl enc -aes-256-cbc -salt \
        -kfile /vm/DVCQDYKB-hiauntie-vm-backup.tmp/enc.key \
        -in  social.hiauntie.main.com.img.gz \
        -out social.hiauntie.main.com.img.gz.enc
    openssl enc -aes-256-cbc -salt \
        -kfile /home/hiauntie_bot/.hiauntie/backup_enc_key \
        -in  /vm/DVCQDYKB-hiauntie-vm-backup.tmp/enc.key \
        -out /vm/DVCQDYKB-hiauntie-vm-backup.tmp/enc.key.enc
    rm -rf /vm/DVCQDYKB-hiauntie-vm-backup.tmp/social.hiauntie.main.com.img.gz
    rm -rf /vm/DVCQDYKB-hiauntie-vm-backup.tmp/enc.key

    echo "NJUQUVIR md5"
    
    cd /vm/DVCQDYKB-hiauntie-vm-backup.tmp
    md5sum social.hiauntie.main.com.img.gz.enc enc.key.enc > md5.txt

    echo "RURUAIWB upload to AWS"

    aws s3 cp \
        /vm/DVCQDYKB-hiauntie-vm-backup.tmp/md5.txt \
        s3://hiauntie-backup/vm/${TIMESTAMP_YYYY}/${TIMESTAMP_FULL}/md5.txt --quiet
    aws s3 cp \
        /vm/DVCQDYKB-hiauntie-vm-backup.tmp/enc.key.enc \
        s3://hiauntie-backup/vm/${TIMESTAMP_YYYY}/${TIMESTAMP_FULL}/enc.key.enc --quiet
    aws s3 cp \
        /vm/DVCQDYKB-hiauntie-vm-backup.tmp/social.hiauntie.main.com.img.gz.enc \
        s3://hiauntie-backup/vm/${TIMESTAMP_YYYY}/${TIMESTAMP_FULL}/social.hiauntie.main.com.img.gz.enc --quiet

    echo "YGQIGSLZ clear tmp data"

    cd /vm
    sudo rm -rf /vm/DVCQDYKB-hiauntie-vm-backup.tmp

    toot verbose "EPRITVAU vm backup ${TIMESTAMP_FULL} end"

fi

if [ ${OPT_UPDATE} -eq 1 ]; then

    toot verbose "UFMBYMOO vm update-reboot ${TIMESTAMP_FULL} start"

    echo "SJZMLATO guest os_upgrade"
    ssh hiauntie_bot@hiauntie.com -C /home/hiauntie_bot/maintenance.hiauntie.com/hiauntie/script/os_update.sh

    echo "SHBETWFC guest shutdown"
    ssh hiauntie_bot@hiauntie.com -C "sudo shutdown now" || true

    echo "QPMMCFPU wait guest shutdown"
    /home/hiauntie_bot/maintenance.hiauntie.com/host/script/wait_shutdown.sh 60
    
    echo "JDHPJAMO restart guest"
    virsh start social.hiauntie.com
    
    echo "KDOUHDDZ wait guest up"
    /home/hiauntie_bot/maintenance.hiauntie.com/host/script/wait_up.sh 180
    
    toot verbose "RZHNHRQY vm update-reboot ${TIMESTAMP_FULL} end"
fi

if [ ${OPT_MSG} -eq 1 ]; then

    toot announcement "維護作業已經完成"

fi

echo JXDNKIBA backup end ${TIMESTAMP_FULL}

