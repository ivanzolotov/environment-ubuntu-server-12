# Update and upgrade
apt-get update
apt-get upgrade

# Getting rid of the messages
# "perl: warning: Setting locale failed"
locale-gen en_US.UTF-8 ru_RU.UTF-8
dpkg-reconfigure locales
echo LANG="en_US.utf8" >> /etc/environment
echo LANGUAGE="en_US.utf8" >> /etc/environment
echo LC_ALL="en_US.UTF-8" >> /etc/environment
echo LC_CTYPE="en_US.UTF-8" >> /etc/environment
