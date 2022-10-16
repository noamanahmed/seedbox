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


apt install aria2 -qqy


php=8.1
username=aria2c_webui
user_root=/opt/aria2c_webui
rm -rf $user_root
# Create User
adduser --gecos "" --disabled-password  --home $user_root  $username
usermod -a -G $username nginx
git clone https://github.com/mayswind/AriaNg $user_root
npm install --prefix $user_root 

mkdir -p $user_root/logs/
mkdir -p $user_root/tmp/
mkdir -p $user_root/logs/nginx
mkdir -p $user_root/logs/mail
mkdir -p $user_root/cache
mkdir -p $user_root/cache/nginx
chown -R $username:$username $user_root


cp $template_path/aria2c/aria2c.service /etc/systemd/system/
cp $template_path/aria2c/aria2c-webui.service /etc/systemd/system/

systemctl daemon-reload
systemctl restart aria2c
systemctl enable aria2c
systemctl restart aria2c-webui
systemctl enable aria2c-webui

nginx_vhost_file="/etc/nginx/apps-available/aria2c.conf"
nginx_vhost_enabled="/etc/nginx/apps-enabled/aria2c.conf"
cp $template_path/aria2c/vhost.conf $nginx_vhost_file

sed -i "s/{{domain}}/$HOSTNAME/" $nginx_vhost_file

ln -s $nginx_vhost_file $nginx_vhost_enabled
systemctl reload nginx

#touch $LEMP_FLAG_DIR/MONIT_INSTALLED