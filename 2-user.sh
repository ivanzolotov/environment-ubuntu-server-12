# DigitalOcean and Netangels only!
# Not for AWS!
useradd -m -d /home/ubuntu ubuntu
mkdir /home/ubuntu/.ssh
cp /root/.ssh/authorized_keys /home/ubuntu/.ssh
chown -R ubuntu:ubuntu /home/ubuntu/.ssh
echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu
chmod 440 /etc/sudoers.d/ubuntu
usermod -s /bin/bash ubuntu
