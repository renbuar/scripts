sudo apt install -y smbclient
cd /tmp
wget http://gdlp01.c-wss.com/gds/6/0100004596/05/linux-capt-drv-v271-uken.tar.gz
cd /tmp/linux-capt-drv-v271-uken/64-bit_Driver/Debian
sudo dpkg --add-architecture i386
sudo apt update
apt install -y libc6:i386 libpopt0:i386 zlib1g:i386 libxml2:i386 libstdc++6:i386
sudo dpkg -i cndrvcups-common_3.21-1_amd64.deb
sudo dpkg -i cndrvcups-capt_2.71-1_amd64.deb
sudo apt install -f -y
