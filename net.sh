# настройка ip debian 9 на kvm
sudo cat > /tmp/interfaces <<EOF
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
#auto ens3
#iface ens3 inet dhcp

iface ens3 inet static
address 192.168.0.160
netmask 255.255.255.0
gateway 192.168.0.1
dns-nameservers 192.168.0.1
auto ens3
EOF
sudo cp /tmp/interfaces /etc/network
sudo cat > /tmp/hosts <<EOF
127.0.0.1       localhost
127.0.1.1       debian
EOF
sudo cp /tmp/hosts /etc
sudo /bin/su -c "echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.conf"
sudo /bin/su -c "echo 'net.ipv6.conf.default.disable_ipv6 = 1' >> /etc/sysctl.conf"
sudo /bin/su -c "echo 'net.ipv6.conf.lo.disable_ipv6 = 1' >> /etc/sysctl.conf"
#sudo /bin/su -c "echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf"
sudo sysctl -p
# ubuntu
# Отключим службу ondemand
# (для разгона cpu)
# cat /proc/cpuinfo | grep MHz
# systemctl status ondemand
# systemctl stop ondemand
# systemctl disable ondemand
# nano /etc/sysctl.conf
