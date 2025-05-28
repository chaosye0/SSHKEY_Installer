#/bin/sh
apt-get update -y
apt-get install curl -y
yum clean all
yum make cache
yum install curl -y
echo '============================
      SSH Key Installer
	 V1.0 Alpha
	Author:Kirito
============================'
cd ~
mkdir .ssh
cd .ssh
rm authorized_keys
curl https://github.com/$1.keys > authorized_keys
chmod 700 authorized_keys
cd ../
chmod 600 .ssh
cd /etc/ssh/

sed -i "/RSAAuthentication no/c RSAAuthentication yes" sshd_config
sed -i "/PubkeyAuthentication no/c PubkeyAuthentication yes" sshd_config
sed -i "/PasswordAuthentication yes/c PasswordAuthentication no" sshd_config
sed -i "10a PubkeyAcceptedKeyTypes +ssh-rsa" sshd_config


service sshd restart
service ssh restart
systemctl restart sshd
systemctl restart ssh
cd ~
rm -rf key.sh
