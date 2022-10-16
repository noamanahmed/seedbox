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


