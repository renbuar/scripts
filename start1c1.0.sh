#!/bin/sh
mkdir -p /tmp/1ctmp
cd /tmp/1ctmp
sudo apt install -y unixodbc libgsf-1-114

#debian
#wget  http://ftp.ru.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb
#sudo  apt install -y xfonts-utils cabextract
#sudo dpkg -i ttf-mscorefonts-installer_3.6_all.deb
# фонты от Etersoft
cp /home/user/Загрузки/fonts-ttf-ms_1.0-eter4ubuntu_all.deb /tmp/1ctmp
sudo dpkg -i fonts-ttf-ms_1.0-eter4ubuntu_all.deb
cp /home/user/Загрузки/deb64.tar.gz /tmp/1ctmp
cp /home/user/Загрузки/client.deb64.tar.gz /tmp/1ctmp
tar xvzf deb64.tar.gz
tar xvzf client.deb64.tar.gz
sudo dpkg -i 1c*.deb
sudo apt -f -y install
sudo chown -R usr1cv8:grp1cv8 /opt/1C
sudo echo -e "pass\npass\n" | sudo passwd usr1cv8
# rm -r /tmp/1ctmp
