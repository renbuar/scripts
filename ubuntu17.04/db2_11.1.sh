#!/bin/sh
sudo groupadd db2iadm1
sudo useradd -g db2iadm1 -m -d /home/db2inst1 db2inst1
#passwd db2inst1
sudo echo -e "pass\npass\n" | sudo passwd db2inst1
sudo groupadd db2fadm1
sudo useradd -g db2fadm1 -m -d /home/db2fenc1 db2fenc1
#sudo passwd db2fenc1
sudo echo -e "pass\npass\n" | sudo passwd db2fenc1
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libpam0g:i386 -y
#sudo apt-get install libaio1 -y
sudo apt-get install libx32stdc++6 -y
#sudo apt-get install binutils -y
sudo apt-get install libnuma-dev -y
sudo apt-get install libstdc++6 -y
#sudo apt-get install libstdc++5 -y
sudo apt-get install ksh -y
#sudo apt-get install rpm -y
cp /home/user/Загрузки/v11.1_linuxx64_expc.tar.gz /tmp
cd /tmp
tar xvzf v11.1_linuxx64_expc.tar.gz
cd expc
sudo ./db2_install -f sysreq
#Не указан сервер SMTP уведомлений. Пока он не задан, нельзя послать уведомления
cd /opt/ibm/db2/V11.1/instance
sudo ./db2icrt -u db2fenc1 db2inst1
sudo ./db2iauto -on db2inst1
sudo -u db2inst1 /home/db2inst1/sqllib/adm/db2set DB2_WORKLOAD=1C
#sudo -u db2inst1 /home/db2inst1/sqllib/adm/db2start
# скрипт автозапуска
cd /tmp
cat > db2auto.service <<EOF
[Unit]
Description = db2 db2auto daemon
[Service]
Type=forking
ExecStart=/usr/bin/sudo -u db2inst1 /home/db2inst1/sqllib/adm/db2start
ExecStop =/usr/bin/sudo -u db2inst1 /home/db2inst1/sqllib/adm/db2stop
[Install]
WantedBy=multi-user.target
EOF
#sudo chmod +x db2auto.service
sudo cp db2auto.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable db2auto.service
sudo systemctl start db2auto.service
#sudo systemctl status db2auto.service
#ps -eaf|grep -i db2sysc
# установка 1с
mkdir -p /tmp/1ctmp
cd /tmp/1ctmp
sudo apt install -y unixodbc libgsf-1-114
#ubuntu
#sudo apt install ttf-mscorefonts-installer -y
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
sudo usermod -aG db2iadm1 usr1cv8
#sudo echo ". /home/db2inst1/sqllib/db2profile" >> /home/usr1cv8/.profile
sudo sh -c "echo '. /home/db2inst1/sqllib/db2profile' >> /home/usr1cv8/.profile"
sudo service srv1cv83 start
#sudo service srv1cv83 status
mkdir /tmp/hasp
cd /tmp/hasp
#wget http://download.etersoft.ru/pub/Etersoft/HASP/last/x86_64/Debian/8/haspd-modules_7.60-eter1debian_amd64.deb
wget http://download.etersoft.ru/pub/Etersoft/HASP/last/x86_64/Ubuntu/17.04/haspd-modules_7.40-eter10ubuntu_amd64.deb
#wget http://download.etersoft.ru/pub/Etersoft/HASP/last/x86_64/Debian/8/haspd_7.60-eter1debian_amd64.deb
wget http://download.etersoft.ru/pub/Etersoft/HASP/last/x86_64/Ubuntu/17.04/haspd_7.40-eter10ubuntu_amd64.deb
sudo dpkg -i *.deb
sudo apt-get install -f -y
sudo service haspd start
#sudo service haspd status
#sudo shutdown -r now
