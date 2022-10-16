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

while [ $# -gt 0 ]; do
    case "$1" in
        -u|--username)
            username="$2"
            shift
        ;;
        -p|--password)
            password="$2"
            shift
        ;;
        -h|--hostname)
            hostname="$2"
            shift
        ;;
        --help)
            echo 'LEMP Seedbox Installer'            
        *)
            printf "***************************\n"
            printf "* Error: Invalid argument. $1 *\n"
            printf "***************************\n"
            exit 1
    esac
    shift
done


if [ -z "$username" ]
then
    echo "Please provide a username using -u.If you are confused just set it to your first name"
    exit
fi


if [ -z "$hostname" ]
then
    echo "Please provide a hostname using -h "
    exit
fi


if [ -z "$password" ]
then
    echo "Please provide a password using -p "
    exit
fi

tee -a /home/$username/.bashrc <<EOF

# set PATH so it includes lemp seedbox binaries if it exists
if [ -d "/opt/lemp_seedbox/bin" ] ; then
    PATH="/opt/lemp_seedbox/bin:$PATH"
fi

EOF


