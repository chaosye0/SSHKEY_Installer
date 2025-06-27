#/bin/sh
apt-get update -y
apt-get install curl -y
yum clean all
yum make cache
yum install curl -y
echo '============================
      SSH Key Installer
usage: bash key.sh [your Github username]  
============================'
cd ~
mkdir -p .ssh
cd .ssh
rm authorized_keys
curl https://github.com/$1.keys > authorized_keys
chmod 700 authorized_keys
cd ../
chmod 600 .ssh
cd /etc/ssh/

sed -i '/^#*RSAAuthentication/s/^#*RSAAuthentication.*/RSAAuthentication yes/; t; $a RSAAuthentication yes' /etc/ssh/sshd_config
sed -i '/^#*PubkeyAuthentication/s/^#*PubkeyAuthentication.*/PubkeyAuthentication yes/; t; $a PubkeyAuthentication yes' /etc/ssh/sshd_config
sed -i '/^#*PasswordAuthentication/s/^#*PasswordAuthentication.*/PasswordAuthentication no/; t; $a PasswordAuthentication no' /etc/ssh/sshd_config
sed -i '/^#*PubkeyAcceptedKeyTypes/s/^#*PubkeyAcceptedKeyTypes.*/PubkeyAcceptedKeyTypes +ssh-rsa/; t; $a PubkeyAcceptedKeyTypes +ssh-rsa' /etc/ssh/sshd_config
sed -i '/^#*Port/s/^#*Port.*/Port 22922/; t; $a Port 22922' /etc/ssh/sshd_config

service sshd restart
service ssh restart
systemctl restart sshd
systemctl restart ssh
cd ~
rm -rf key.sh
