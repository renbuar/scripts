sudo groupadd db2iadm1
sudo useradd -g db2iadm1 -m -d /home/db2inst1 db2inst1
#passwd db2inst1
sudo echo -e "pass\npass\n" | sudo passwd db2inst1
sudo groupadd db2fadm1
sudo useradd -g db2fadm1 -m -d /home/db2fenc1 db2fenc1
#sudo passwd db2fenc1
sudo echo -e "pass\npass\n" | sudo passwd db2fenc1
#sudo dpkg --add-architecture i386
#sudo apt-get update
#sudo apt-get install libaio1 -y
sudo apt-get install libx32stdc++6 -y
#sudo apt-get install libpam0g:i386 -y
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
sudo echo -e "pass\n" | su - db2inst1
