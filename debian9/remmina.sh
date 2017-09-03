sudo apt purge libssl-dev
sudo apt install build-essential git-core libssh-dev cmake libx11-dev libxext-dev libxinerama-dev libxdamage-dev libxv-dev libxkbfile-dev libasound2-dev libcups2-dev libxml2 libxml2-dev libxrandr-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libxi-dev libavutil-dev libavcodec-dev libxtst-dev libgtk-3-dev libgcrypt11-dev libpulse-dev libvte-2.91-dev libxkbfile-dev libtelepathy-glib-dev libjpeg-dev libgnutls28-dev libgnome-keyring-dev libavahi-ui-gtk3-dev libvncserver-dev libappindicator3-dev intltool libsecret-1-dev libwebkit2gtk-4.0-dev libsystemd-dev -y
#sudo apt purge "remmina*" "libfreerdp*" "libwinpr*" "freerdp*"
mkdir ~/remmina_devel
cd ~/remmina_devel
git clone https://github.com/FreeRDP/FreeRDP.git
$ cd FreeRDP
cmake -DCMAKE_BUILD_TYPE=Debug -DWITH_SSE2=ON -DWITH_CUPS=on -DWITH_PULSE=on -DCMAKE_INSTALL_PREFIX:PATH=/opt/remmina_devel/freerdp .
make && sudo make install
echo /opt/remmina_devel/freerdp/lib | sudo tee /etc/ld.so.conf.d/freerdp_devel.conf > /dev/null
sudo ldconfig
sudo ln -s /opt/remmina_devel/freerdp/bin/xfreerdp /usr/local/bin/
#$ xfreerdp +clipboard /sound:rate:44100,channel:2 /v:192.168.1.162 /u:user
cd ~/remmina_devel
git clone https://github.com/FreeRDP/Remmina.git -b next
cd Remmina
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX:PATH=/opt/remmina_devel/remmina -DCMAKE_PREFIX_PATH=/opt/remmina_devel/freerdp --build=build .
make && sudo make install
sudo ln -s /opt/remmina_devel/remmina/bin/remmina /usr/local/bin/
