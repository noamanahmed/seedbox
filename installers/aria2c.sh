#!/bin/bash


if [ ! -d "/opt/lemp/" ]
then
  echo "LEMP installer not installed. Aborting!"
  exit 1;
fi

template_path="/opt/lemp/templates"
source /opt/lemp/includes/helpers.sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi


apt install aria2 -qqy


