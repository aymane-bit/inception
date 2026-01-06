#!/bin/sh
set -e

FTP_USER=${FTP_USER:-"ftpuser"}
FTP_PASS_FILE=${FTP_PASS_FILE:-"/run/secrets/ftp_password.txt"}

if [ -f "$FTP_PASS_FILE" ]; then
    FTP_PASS=$(cat "$FTP_PASS_FILE")
else
    echo "FTP password secret not found!"
    exit 1
fi

if ! id "$FTP_USER" > /dev/null 2>&1; then
    echo "Creating FTP user: $FTP_USER"
    useradd -m -d /var/www/html -s /bin/bash "$FTP_USER"
    echo "$FTP_USER:$FTP_PASS" | chpasswd
    usermod -aG www-data "$FTP_USER"
fi

cat << EOF > /etc/vsftpd.conf
listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
allow_writeable_chroot=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
pasv_enable=YES
pasv_min_port=21100
pasv_max_port=21110
user_sub_token=$FTP_USER
local_root=/var/www/html
EOF

echo "Starting vsftpd..."
exec /usr/sbin/vsftpd /etc/vsftpd.conf
