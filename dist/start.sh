#!/bin/bash

sed -e "s/127\.0\.0\.1/$DEST_IP/" /root/dist/.opencanary.conf.org > /root/.opencanary.conf

/etc/init.d/rsyslog start
/etc/init.d/samba start

source /opt/opencanary/bin/activate && /opt/opencanary/bin/opencanaryd --dev
