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
cp /home/user/Загрузки/v11.1_linuxx64_expc.tar.gz /home/user
cd /home/user
tar xvzf v11.1_linuxx64_expc.tar.gz
cd expc
cp /home/user/Загрузки/v11.1_linuxx64_nlpack.tar.gz /home/user/expc
tar xvzf v11.1_linuxx64_nlpack.tar.gz
sudo ./db2setup -f sysreq
