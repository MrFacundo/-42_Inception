#!/bin/sh

# Add user
FTP_USER=$(cat /run/secrets/ftp_username)
adduser -D $FTP_USER

FTP_PASS=$(cat /run/secrets/ftp_password)
echo  $FTP_USER:$FTP_PASS | /usr/sbin/chpasswd

chown $FTP_USER:$FTP_USER -R /home/$FTP_USER/
echo  $FTP_USER | tee -a /etc/vsftpd.userlist 

# Start vsftpd in foreground with configuration file
/usr/sbin/vsftpd /etc/vsftpd.conf