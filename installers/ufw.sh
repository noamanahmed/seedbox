#!/bin/bash


if [ ! -d "/opt/lemp/" ]
then
  echo "LEMP installer not installed. Aborting!"
  exit 1;
fi

template_path="/opt/seedbox/templates"
source /opt/lemp/includes/helpers.sh
source /opt/seedbox/includes/helpers.sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi


ufw allow 20010/tcp
ufw allow 20020/tcp
ufw allow 20030/tcp
ufw allow 20040/tcp
ufw allow 20050/tcp
ufw allow 20060/tcp
ufw allow 20070/tcp
ufw allow 20080/tcp
ufw allow 20080/tcp
ufw allow 20100/tcp
ufw allow 20110/tcp
ufw allow 20120/tcp
ufw allow 20130/tcp
ufw allow 20140/tcp
ufw allow 20150/tcp
