# DigitalOcean and Netangels only!
# Not for AWS!
USERID=$(id -u) 
if [ $USERID e "0" ]; then
	(useradd -m -d /home/ubuntu ubuntu
	mkdir /home/ubuntu/.ssh
	cp /root/.ssh/authorized_keys /home/ubuntu/.ssh
	chown -R ubuntu:ubuntu /home/ubuntu/.ssh
	echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu
	chmod 440 /etc/sudoers.d/ubuntu
	usermod -s /bin/bash ubuntu
	# Restrict root login via SSH
	sudo sed -i -e 's/PermitRootLogin\ yes/PermitRootLogin\ no/g' /etc/ssh/sshd_config)
	echo 2
else
	echo 1
fi

