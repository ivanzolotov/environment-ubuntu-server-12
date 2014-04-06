# Works fine with:
# - Netangels Ubuntu 12.04 LTS
# - Netangels Ubuntu 12.04 LTS

# curl https://raw.github.com/ivanzolotov/environment-ubuntu-server-12/master/1-start.sh | bash

# Скрип можно запустить под рутом на чистом образе в Netangels или DigitalOcean

# 1. Всё обновляем
# 2. Устраняем проблемы с кодировками
# 3. Создаём нового пользователя ubuntu, если это необходимо

# Update and upgrade while we are root.
apt-get update --force-yes
apt-get upgrade --force-yes

# Getting rid of the messages
# "perl: warning: Setting locale failed".
locale-gen en_US.UTF-8 ru_RU.UTF-8
dpkg-reconfigure locales
echo 'LANG="en_US.utf8"' >> /etc/environment
echo 'LANGUAGE="en_US.utf8"' >> /etc/environment
echo 'LC_ALL="en_US.UTF-8"' >> /etc/environment
echo 'LC_CTYPE="en_US.UTF-8"' >> /etc/environment

# If we work under root (DigitalOcean and Netangels) -
# we want to create a new user.
# Проблема заключается в том, что этот блок выполнится, если мы запустим весь скрипт под sudo,
# без чего не выполнится блок выше, если мы работаем не из под root
USERID=$(id -u)
if [ $USERID -eq "0" ]; then
useradd -m -d /home/ubuntu ubuntu
mkdir /home/ubuntu/.ssh
cp /root/.ssh/authorized_keys /home/ubuntu/.ssh
chown -R ubuntu:ubuntu /home/ubuntu/.ssh
echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu
chmod 440 /etc/sudoers.d/ubuntu
usermod -s /bin/bash ubuntu
echo "New user \"ubuntu\" created, you can log in as \"ubuntu\" with root ssh key..."
# Restrict root login via SSH
sed -i -e 's/PermitRootLogin\ yes/PermitRootLogin\ no/g' /etc/ssh/sshd_config
echo "You shouldn't be able to log in as root with your key nor password anymore..."
echo "Check it after reboot and change \"root\" to \"ubuntu\" in your ~/.ssh/config "
fi

read -p "We've just Press any key to continue... " -n1

reboot