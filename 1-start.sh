# Update and upgrade
apt-get update --force-yes
apt-get upgrade --force-yes

# Getting rid of the messages
# "perl: warning: Setting locale failed"
locale-gen en_US.UTF-8 ru_RU.UTF-8
dpkg-reconfigure locales
echo LANG="en_US.utf8" >> /etc/environment
echo LANGUAGE="en_US.utf8" >> /etc/environment
echo LC_ALL="en_US.UTF-8" >> /etc/environment
echo LC_CTYPE="en_US.UTF-8" >> /etc/environment

# if we work under root (DigitalOcean and Netangels) -
# we want to create a new user
USERID=$(id -u)
if [ $USERID -eq "0" ]; then
	useradd -m -d /home/ubuntu ubuntu
	mkdir /home/ubuntu/.ssh
	cp /root/.ssh/authorized_keys /home/ubuntu/.ssh
	chown -R ubuntu:ubuntu /home/ubuntu/.ssh
	echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu
	chmod 440 /etc/sudoers.d/ubuntu
	usermod -s /bin/bash ubuntu
	# Restrict root login via SSH
	sudo sed -i -e 's/PermitRootLogin\ yes/PermitRootLogin\ no/g' /etc/ssh/sshd_config
	echo "We've just created a new ubuntu user.\n Check"
fi

read -p "We've just Press any key to continue... " -n1

reboot